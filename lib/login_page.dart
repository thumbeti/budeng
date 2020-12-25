import 'package:budeng/user_dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:budeng/sign_in.dart';
import 'package:budeng/registration.dart';
import 'package:budeng/admin_screen.dart';
import 'package:budeng/constants/colors.dart';

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
        backgroundColor: darkBg,
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(),
                Column(
                  children: [
                    Text(
                      'Welcome To',
                      style: TextStyle(
                          fontFamily: 'CircularStd-Bold',
                          fontSize: 32,
                          color: Colors.white),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 25.0),
                      child: Container(
                          height: 230,
                          child: Image.asset(
                            'assets/images/Group 57.png',
                          )),
                    )
                  ],
                ),
                signInButton(context),
              ],
            ),
          ),
        ));
  }

  InkWell signInButton(BuildContext context) {
    return InkWell(
      onTap: () {
        signInWithGoogle().then((result) {
          if (result != null) {
            print('logged in user: ' + name + ' UID: ' + uid);
            Future<bool> userExists = _checkIfUserRegistered();
            userExists.then((bool x) {
              if (x == false) {
                print("User not yet registered.");
                registerUser();
              } else {
                print('User already registered.');
                if (userType == 'Regular') {
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(builder: (_) => UserDashboard()),
                  );
                } else {
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(builder: (_) => AdminScreen()),
                  );
                }
              }
            }).catchError((e) => print('in catch error' + e.toString()));
          } else {
            print('SIVA: login failed...');
          }
        });
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 35, left: 35, bottom: 148.0),
        child: Container(
          height: 65,
          width: double.infinity,
          decoration: BoxDecoration(
            color: lightBg,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    height: 35,
                    child: Image.asset("assets/images/googlelogo.png")),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Login With Google',
                  style: TextStyle(
                      fontFamily: 'CircularStd-Medium',
                      fontSize: 19,
                      color: darkBg),
                ),
              ],
            ),
          ),
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
