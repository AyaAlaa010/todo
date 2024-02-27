import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'core/service/snakers_service.dart';

class FirebaseUtils{
  BuildContext context;
  late var locale;

  FirebaseUtils(this.context){
     locale= AppLocalizations.of(context)!;

  }



  Future <bool> createAccount(String email,String password) async{
    EasyLoading.show();

    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      print(" user= ${credential.user!.email}");
      return Future.value(true);

    } on FirebaseAuthException catch (e) {
      print("___________${e.message}");
      if (e.code == 'weak-password') {
        print(locale.password_weak);
        SnackerService(context).showErrorMsg(locale.password_weak);
        EasyLoading.dismiss();
        return Future.value(false);
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        SnackerService(context).showErrorMsg(locale.account_already_exist);
        EasyLoading.dismiss();
        return Future.value(false);
      }
      else{
        SnackerService(context).showErrorMsg(locale.unkown_error);
        EasyLoading.dismiss();
        return Future.value(false);
      }

    } catch (e) {
      print(e);
      EasyLoading.dismiss();
      return Future.value(false);
    }
  }

  Future <bool> login(String email, String password)async{
    EasyLoading.show();
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );
     return Future.value(true);

    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        SnackerService(context).showErrorMsg(locale.no_user_found_email);
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        SnackerService(context).showErrorMsg(locale.wrong_password_user);
      }else{
        SnackerService(context).showErrorMsg(locale.unkown_error);
      }
      EasyLoading.dismiss();
      return Future.value(false);
    }catch (e) {
      print(e);
      EasyLoading.dismiss();
      return Future.value(false);
    }
  }




}