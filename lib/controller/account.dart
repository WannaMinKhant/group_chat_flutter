import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:group_chat_flutter/screens/login_screen.dart';

Future<User?> createAccount(String name, String email, String password) async {
  FirebaseAuth _auth = FirebaseAuth.instance;

  try {
    User? user = (await _auth.createUserWithEmailAndPassword(
            email: email, password: password))
        .user;
    if (user != null) {
      // print("Login Successfully");
      return user;
    } else {
      // print("Account Create is failed");
      return user!;
    }
  } catch (e) {
    // print(e);
    return null;
  }
}

Future<User?> logIn(String email, String password) async {
  FirebaseAuth _auth = FirebaseAuth.instance;

  try {
    User? user = (await _auth.signInWithEmailAndPassword(
            email: email, password: password))
        .user;

    if(user != null){
      // print("Login Success");
      return user;
    }else{
      // print("Login Failed");
      return user;
    }
  } catch (e) {
    // print(e);
    // print("Login Failed");
    return null;
  }
}

Future logOut(BuildContext context) async{
  FirebaseAuth _auth = FirebaseAuth.instance;

  try{
    await _auth.signOut().then((user) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => const LoginScreen()));
    });
  }catch(e){
    // print("error");
  }
}
