import 'package:flutter/material.dart';
import 'package:group_chat_flutter/screens/signup_screen.dart';
import 'package:group_chat_flutter/widgets/custom_button.dart';
import 'package:group_chat_flutter/widgets/field_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: size.height / 20,
            ),
            Container(
              alignment: Alignment.centerLeft,
              width: size.width / 1.2,
              child: IconButton(
                onPressed: () {
                  print(_email.text);
                },
                icon: const Icon(Icons.arrow_back_ios),
              ),
            ),
            SizedBox(
              height: size.height / 50,
            ),
            SizedBox(
              width: size.width / 1.3,
              child: const Text(
                "Welcome",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              width: size.width / 1.3,
              child: Text(
                "Sign In to continue!",
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(
              height: size.height / 10,
            ),
            Container(
              width: size.width,
              alignment: Alignment.center,
              child: Field(
                size: size,
                icon: Icons.account_box,
                hintText: "Email",
                controller: _email,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Container(
                width: size.width,
                alignment: Alignment.center,
                child: Field(
                  size: size,
                  icon: Icons.lock,
                  hintText: "password",
                  controller: _password,
                ),
              ),
            ),
            SizedBox(
              height: size.height / 20,
            ),
            CustomButton(size: size, text: "Login",controllerList:[_email,_password]),
            SizedBox(
              height: size.height / 20,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => const SignUp()));
              },
              child: const Text(
                "Create Account",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
