import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Authservice {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User> signin(String mail, String sifre) async {
    try {
      UserCredential kulla = await _auth.signInWithEmailAndPassword(
        email: mail,
        password: sifre,
      );
      return kulla.user;
    } on FirebaseAuthException catch (e) {
      debugPrint(e.toString());
      print("qq");
      if (e.toString() ==
          "[firebase_auth/user-not-found] There is no user record corresponding to this identifier. The user may have been deleted.") {
        print("dd");
      }

      /* Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );*/
    }
  }
}
