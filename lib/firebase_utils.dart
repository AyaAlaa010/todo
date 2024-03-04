import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo/core/config/common.dart';
import 'package:todo/models/task_model.dart';
import 'core/service/snakers_service.dart';

class FirebaseUtils {
  // locale = AppLocalizations.of(context)!;

  static Future<void> updateTask(TaskModel taskModel) {
    var collectionRef = getCollectionRef();
    var docRef = collectionRef.doc(taskModel.id);
    return docRef.update(taskModel.toFirestore());
  }

  static Future<void> deleteTask(TaskModel taskModel) {
    var collectionRef = getCollectionRef();
    var docRef = collectionRef.doc(taskModel.id);
    return docRef.delete();
  }

  static CollectionReference<TaskModel> getCollectionRef() {
    var dp = FirebaseFirestore.instance;
    return dp.collection("tasks").withConverter<TaskModel>(
        fromFirestore: (snapshot, _) =>
            TaskModel.fromFirestore(snapshot.data()!),
        toFirestore: (taskModel, _) => taskModel.toFirestore());
  }

  static Future<void> addToFirestore(TaskModel taskModel) {
    var collectionRef = getCollectionRef();
    var docRef = collectionRef.doc();
    taskModel.id = docRef.id;
    return docRef.set(taskModel);
  }

  Future<List<TaskModel>> getDataFromFirestore(DateTime dateTime) async {
    var collectionRef = getCollectionRef().where("dateTime",
        isEqualTo: Common.extractDate(dateTime).microsecondsSinceEpoch);
    var data = await collectionRef.get();
    return data.docs.map((e) => e.data()).toList();
  }

  static Stream<QuerySnapshot<TaskModel>> getStreamDataFromFirestore(
      DateTime dateTime) {
    var collectionRef = getCollectionRef().where("dateTime",
        isEqualTo: Common.extractDate(dateTime).microsecondsSinceEpoch);
    return collectionRef.snapshots();
  }

  static Future<bool> createAccount(
      String email, String password, var context) async {
    var locale = AppLocalizations.of(context)!;
    EasyLoading.show();

    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return Future.value(true);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        SnackerService.showErrorMsg(locale.password_weak, context);
        EasyLoading.dismiss();
        return Future.value(false);
      } else if (e.code == 'email-already-in-use') {
        SnackerService.showErrorMsg(locale.account_already_exist, context);
        EasyLoading.dismiss();
        return Future.value(false);
      } else {
        SnackerService.showErrorMsg(locale.unkown_error, context);
        EasyLoading.dismiss();
        return Future.value(false);
      }
    } catch (e) {
      print(e);
      EasyLoading.dismiss();
      return Future.value(false);
    }
  }

  static Future<bool> login(
      String email, String password, BuildContext context) async {
    var locale = AppLocalizations.of(context)!;

    EasyLoading.show();
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return Future.value(true);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        SnackerService.showErrorMsg(locale.no_user_found_email, context);
      } else if (e.code == 'wrong-password') {
        SnackerService.showErrorMsg(locale.wrong_password_user, context);
      }else if(e.code=="invalid-credential"){
        SnackerService.showErrorMsg(locale.wrong_email_password, context);
      }
      else {
        SnackerService.showErrorMsg(locale.unkown_error, context);
      }
      EasyLoading.dismiss();
      return Future.value(false);
    } catch (e) {
      print(e);
      EasyLoading.dismiss();
      return Future.value(false);
    }
  }
}
