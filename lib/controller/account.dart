import 'package:firebase_auth/firebase_auth.dart';

Future<User?> createAccount(String name, String email, String password) async {
  FirebaseAuth _auth = FirebaseAuth.instance;

  try {
    User? user = (await _auth.createUserWithEmailAndPassword(
            email: email, password: password))
        .user;
    if (user != null) {
      print("Login Successfully");
      return user;
    } else {
      print("Account Create is failed");
      return user!;
    }
  } catch (e) {
    print(e);
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
      print("Login Success");
      return user;
    }else{
      print("Login Failed");
      return user;
    }
  } catch (e) {
    print(e);
    print("Login Failed");
    return null;
  }
}

Future logOut() async{
  FirebaseAuth _auth = FirebaseAuth.instance;

  try{
    await _auth.signOut();
  }catch(e){
    print("error");
  }
}
