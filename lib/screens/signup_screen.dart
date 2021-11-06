import 'package:flutter/material.dart';
import 'package:group_chat_flutter/controller/account.dart';

import 'home_screen.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool isLoading = false;
  bool _show = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: isLoading
          ? Center(
              child: SizedBox(
                height: size.height / 20,
                width: size.width / 10,
                child: const CircularProgressIndicator(),
              ),
            )
          : SingleChildScrollView(
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
                      child: field(
                        _name,
                        size,
                        Icons.account_box,
                        "Name",
                      ),
                    ),
                  ),
                  Container(
                    width: size.width,
                    alignment: Alignment.center,
                    child: field(
                      _email,
                      size,
                      Icons.email,
                      "Email",
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 18.0),
                    child: Container(
                      width: size.width,
                      alignment: Alignment.center,
                      child: field(
                        _password,
                        size,
                        Icons.lock,
                        "password",
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height / 20,
                  ),
                  customButton("Create Account", size),
                  SizedBox(
                    height: size.height / 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
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

  void _showToast(BuildContext context, String msg) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(msg),
        action: SnackBarAction(
            label: 'OK', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }

  Widget field(TextEditingController controller, Size size, IconData icon,
      String hintText) {
    return SizedBox(
      height: size.height / 15,
      width: size.width / 1.3,
      child: TextField(
        controller: controller,
        keyboardType: hintText == "email"
            ? TextInputType.emailAddress
            : TextInputType.text,
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          suffixIcon: hintText == "password"
              ? _show
                  ? IconButton(
                      icon: const Icon(Icons.visibility),
                      onPressed: () {
                        setState(() {
                          _show = false;
                        });
                      },
                    )
                  : IconButton(
                      icon: const Icon(Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          _show = true;
                        });
                      })
              : null,
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Colors.grey,
          ),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
        ),
        obscureText: hintText == "password"
            ? _show
                ? false
                : true
            : false,
      ),
    );
  }

  Widget customButton(String text, Size size) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          //for sign up
          if (_email.text.isNotEmpty &&
              _password.text.isNotEmpty &&
              _name.text.isNotEmpty) {
            if (!checkEmail(_email.text)) {
              _showToast(context, "Enter Valid Email Address");
            } else {
              setState(() {
                isLoading = true;
              });
              createAccount(_name.text, _email.text, _password.text)
                  .then((user) {
                if (user != null) {
                  setState(() {
                    isLoading = false;
                  });
                  // print("Account is Created");
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const HomeScreen()));
                  _showToast(context, "Account is Created, Please Login");
                } else {
                  // print("Fail to Create Account");
                  _showToast(context, "Fail to Create Account");
                  setState(() {
                    isLoading = false;
                  });
                }
              });
            }
          } else {
            _showToast(context, "Please fill all data");
          }
        },
        child: Container(
          height: size.height / 14,
          width: size.width / 1.3,
          decoration: const BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          alignment: Alignment.center,
          child: Text(
            text,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.white,
              letterSpacing: 1.1,
            ),
          ),
        ),
      ),
    );
  }

  bool checkEmail(email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }
}
