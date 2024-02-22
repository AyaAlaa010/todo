import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class FirebaseUtils{

  Future <bool>createAccount(String email,String password) async{
    try {
      EasyLoading.show();
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      print(" user= ${credential.user!.email}");
      return Future.value(true);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        BotToast.showText(text: 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        BotToast.showText(text: 'The acc/ount already exists for that email.');
      }
      else{
        BotToast.showText(text: 'Unknown Error');

      }
      EasyLoading.dismiss();
      return Future.value(false);
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
        BotToast.showText(text: 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        BotToast.showText(text: 'Wrong password provided for that user.');
      }else{
        BotToast.showText(text: 'Unknown Error');
      }
      EasyLoading.dismiss();
      return Future.value(false);
    }
  }




}