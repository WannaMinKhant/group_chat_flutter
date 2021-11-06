import 'package:flutter/material.dart';
import 'package:group_chat_flutter/controller/account.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Welcome From My Chat",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 40,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(20),
                ),
                color: Colors.green[200],
              ),
              width: 200,
              height: 70,
              child: const Center(
                  child: Text(
                "Get Start",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 30,
                ),
              )),
            ),
            TextButton(
              onPressed: () => logOut(context),
              child: const Text("Logout"),
            ),
          ],
        ),
      ),
    );
  }
}
