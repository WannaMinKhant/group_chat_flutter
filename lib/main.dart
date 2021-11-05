import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:group_chat_flutter/screens/home_screen.dart';
import 'package:group_chat_flutter/screens/login_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Group Chat',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginScreen(),
    );
  }
}
