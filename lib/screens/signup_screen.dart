import 'package:flutter/material.dart';
import 'package:group_chat_flutter/widgets/custom_button.dart';
import 'package:group_chat_flutter/widgets/field_input.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final isLoading = false;
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
                onPressed: () => Navigator.pop(context),
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
                "Create Account to continue!",
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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 18.0),
              child: Container(
                width: size.width,
                alignment: Alignment.center,
                child: Field(size: size, icon: Icons.account_box, hintText: "Name",controller: _name,),
              ),
            ),
            Container(
              width: size.width,
              alignment: Alignment.center,
              child: Field(size: size, icon: Icons.email, hintText: "Email",controller: _email,),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 18.0),
              child: Container(
                width: size.width,
                alignment: Alignment.center,
                child: Field(size: size, icon: Icons.lock, hintText: "password",controller: _password,),
              ),
            ),
            SizedBox(
              height: size.height / 20,
            ),
            CustomButton(size: size, text: "Create Account",controllerList: [_email,_password,_name],),
            SizedBox(
              height: size.height / 20,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => const SignUp()));
              },
              child: const Text(
                "Login ",
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

