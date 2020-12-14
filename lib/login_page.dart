import 'package:budeng/user_dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:budeng/sign_in.dart';
import 'package:budeng/registration.dart';
import 'package:budeng/admin_screen.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  User currentUser;
  String userType;

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
              SizedBox(height: 50,),
              Center(
                child: Text("Welcome To", style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),),
              ),
              SizedBox(height: 10,),
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
            print('logged in user: ' + name + ' UID: ' + uid);

            Future<bool> userExists = _checkIfUserRegistered();
            userExists
                .then((bool x) {
                  if (x == false) {
                    print("User not yet registered.");
                    registerUser();
                  } else {
                    print('User already registered.');
                    if(userType == 'Regular') {
                      Navigator.of(context).push(
                        //MaterialPageRoute<void>(builder: (_) => BEServices()),
                        MaterialPageRoute<void>(builder: (_) => UserDashboard()),
                      );
                    } else {
                      Navigator.of(context).push(
                        MaterialPageRoute<void>(builder: (_) => AdminScreen()),
                      );
                    }
                  }
                })
                .catchError((e) => print('in catch error' + e.toString()));
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
    print('Welcome to Budget Engineering.. going for registration.' + currentUser.displayName);
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => Registration(currentUser)),
    );
  }

  Future<bool> _checkIfUserRegistered() async {
    bool retval = false;
    currentUser = _auth.currentUser;
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
        Map<String, dynamic> data = value.data();
        userType = data['userType'];
        retval = true;
      }
    });

    print('Exiting: ' + retval.toString());
    return retval;
  }
}
