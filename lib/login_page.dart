import 'package:budeng/constants/service_tasks.dart';
import 'package:budeng/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:budeng/sign_in.dart';
import 'package:budeng/admin_screen.dart';
import 'package:budeng/constants/colors.dart';
import 'package:budeng/user_registration.dart';
import 'package:toast/toast.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  User currentUser;
  String userType;
  String phoneNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBg,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Welcome To',
                      style: TextStyle(
                          fontFamily: 'CircularStd-Bold',
                          fontSize: 25,
                          color: Colors.white),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 25.0),
                      child: Container(
                          height: 70,
                          child: Image.asset(
                            'assets/images/Group 57.png',
                          )),
                    )
                  ],
                ),
                Column(
                  children: [
                    Row(children: [
                      SizedBox(width: 10,),
                      Text(
                        'Services offered by ',
                        style: TextStyle(
                            fontFamily: 'CircularStd-Bold',
                            fontSize: 20,
                            color: Colors.white),
                      ),
                      Text(
                        'Budget Engineers',
                        style: TextStyle(
                            fontFamily: 'CircularStd-Bold',
                            fontSize: 25,
                            color: buttonBg),
                      ),
                    ]),
                    Container(
                      width: 370,
                      child: Divider(
                        thickness: 4,
                        color: Colors.white,
                        height: 10,
                      ),
                    ),
                  ],
                ),
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  serviceInfoWidget("Vigilance of Plot",
                      "Monthly video tour of plot", 0),
                  serviceInfoWidget("Cleaning plot",
                      "Cutting un-wanted-grass / shrubs", 1),
                  serviceInfoWidget(
                      "Fencing Plot", "Barb wire fencing with MS gate", 2),
                  serviceInfoWidget("Compound Wall",
                      "4 ft height solid block wall with MS gate", 3),
                  serviceInfoWidget("EC / Khatha",
                      "Liaisons with Govt. officials to get documentation", 4),
                  serviceInfoWidget("Rent",
                      "BE will manage to get tenent & agreement formalities", 5),
                ],
              ),
            ),
              /*
                serviceInfoWidget(false, "Vigilance of Plot",
                    "Monthly video tour of plot", 0),
                serviceInfoWidget(true, "Cleaning plot",
                    "Cutting un-wanted-grass / shrubs", 1),
                serviceInfoWidget(
                    false, "Fencing Plot", "Barb wire fencing with MS gate", 2),
                serviceInfoWidget(true, "Compound Wall",
                    "4 ft height solid block wall with MS gate", 3),
                serviceInfoWidget(false, "EC / Khatha",
                    "Liaisons with Govt. officials to get documentation", 4),
                serviceInfoWidget(true, "Rent",
                    "BE will manage to get tenent & agreement formalities", 5),
                */
                signInButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding serviceInfoWidget(
      String serviceName, String serviceInfo, int index) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 13.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: Text(
                  serviceName,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontFamily: 'CircularStd-Bold',
                      fontSize: 20,
                      color: buttonBg),
                ),
              ),
              Container(
                height: 28,
                width: 130,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: buttonBg,
                ),
                child: Center(
                  child: Text(
                    BEServicesChargesStr[index],
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            Expanded(
              child: Text(
                serviceInfo,
                //textAlign: TextAlign.start,
                style: TextStyle(
                    fontFamily: 'CircularStd-Bold',
                    fontSize: 16,
                    color: Colors.white),
              ),
            ),
            Container(),
          ]),
        ],
      ),
    );
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
                Toast.show(
                    "User not registered.. going for registration", context);
                registerUser();
              } else {
                print('User already registered.');
                Toast.show("User already present..", context);
                if (userType == 'Regular') {
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                        builder: (_) => Home(currentUser, phoneNumber)),
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
        padding: const EdgeInsets.only(right: 35, left: 35, top: 30.0),
        child: Container(
          height: 50,
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
    print('Welcome to Budget Engineering.. going for registration.' +
        currentUser.displayName);
    Navigator.of(context).push(
      MaterialPageRoute<void>(
          builder: (_) => UserRegistration(currentUser, phoneNumber)),
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
        phoneNumber = data['phoneNum'];
        retval = true;
      }
    });

    print('Exiting: ' + retval.toString());
    return retval;
  }
}
