import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:budeng/sign_in.dart';
import 'package:budeng/registration.dart';

import 'first_screen.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                alignment: Alignment.center,
                color: Colors.white,
                child: SizedBox(
                  height: 100.0,
                  child: Image(
                    alignment: Alignment.center,
                    image: AssetImage("assets/BE_logo.PNG"),
                    //fit: BoxFit.fill,
                  ),
                ),
              ),
              SizedBox(height: 10),
              _signInButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _signInButton() {
    return OutlineButton(
      splashColor: Colors.black,
      onPressed: () {
        signInWithGoogle().then((result) {
          if (result != null) {
            print('loggen in user: ' + name + ' UID: ' + uid);

            //addUserRecord();
            Future<bool> userExists = _checkIfUserRegistered();
            userExists
                .then((bool x) {
                  print('retval of check user :  $x');
                  if (x == false) {
                    print("User not present DB..");
                    registerUser();
                  } else {
                    print('retval of check user .. $x');
                  }
                })
                .catchError((e) => print('in catch error' + e.toString()))
                .whenComplete(() {
                  print('On success/error its commpeted');
                });
          }
        });
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.grey),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage("assets/google_logo.png"), height: 35.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Sign in with Google',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void registerUser() {
    print('Welcome to Budget Engineering.. going for regestration.');
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => Registration()),
    );
  }

  Future<bool> _checkIfUserRegistered() async {
    bool retval = false;
    final User currentUser = await _auth.currentUser;
    await FirebaseFirestore.instance
        .collection("users")
        .doc(currentUser.email)
        .get()
        .then((value) {
      if (value.data() == null) {
        print('User does not exist.');
        retval = false;
      } else {
        print('DB values: ');
        print(value.data().entries.elementAt(1).toString());
        retval = true;
      }
    });

    print('Exiting: ' + retval.toString());
    return retval;
  }

  void addUserRecord() async {
    final User currentUser = await _auth.currentUser;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.email)
        .set({
      'name': 'SivaRam',
      'phoneNumber': '+165055599000',
      'more': 'moreData'
    });
  }
}
