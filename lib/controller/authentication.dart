import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:group_chat_flutter/screens/home_screen.dart';
import 'package:group_chat_flutter/screens/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';


class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
      // Firebase.initializeApp();
    }
  @override
  Widget build(BuildContext context) {

    final FirebaseAuth _auth = FirebaseAuth.instance;
    if(_auth.currentUser != null){
      return const HomeScreen();
    }else{
      return const LoginScreen();
    }

  }
}
