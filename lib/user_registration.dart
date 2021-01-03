import 'package:budeng/sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:budeng/constants/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:budeng/home.dart';

class UserRegistration extends StatefulWidget {
  final User currentUser;
  final String phoneNum;
  const UserRegistration(this.currentUser, this.phoneNum);
  @override
  _UserRegistrationState createState() => _UserRegistrationState();
}

class _UserRegistrationState extends State<UserRegistration> {
  final _formKey = GlobalKey<FormState>();

  String userName, phoneNum, address, city, country;

  getUserName(userName) {
    this.userName = userName;
  }

  getPhoneNum(phoneNum) {
    this.phoneNum = phoneNum;
  }

  getAddress1(address) {
    this.address = address;
  }

  getCity(city) {
    this.city = city;
  }

  getCountry(country) {
    this.country = country;
  }

  addUserDetails() {
    DocumentReference ds = FirebaseFirestore.instance
        .collection('users')
        .doc(widget.currentUser.email);

    Map<String, dynamic> users = {
      'userName': userName,
      'email': widget.currentUser.email,
      'phoneNum': phoneNum,
      'address': address,
      'city': city,
      'country': country,
      'userType': 'Regular',
    };

    ds.set(users).whenComplete(() {
      Text("Added");
      print("user added..!");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBg,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Builder(
            builder: (context) => Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 18.0, right: 18, top: 18),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 40,
                          child: Image.asset('assets/images/Group7.png'),
                        ),
                        Text(
                          'Welcome ' + name,
                          style: TextStyle(
                              fontFamily: 'CircularStd-Book',
                              fontSize: 20,
                              color: lightBg),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 18.0, top: 18),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Let's sign you in",
                              style: TextStyle(
                                  fontFamily: 'CircularStd-Bold',
                                  fontSize: 32,
                                  color: buttonBg),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 18.0, right: 18, top: 7),
                        child: Container(
                          height: 70,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Color(0xffFFFFFF)
                                .withOpacity(0.10196078431372549),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Center(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 18.0, right: 18),
                              child: Row(
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 14.0),
                                        child: Container(
                                            height: 20,
                                            child: Image.asset(
                                                "assets/images/user (1).png")),
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Center(
                                        child: Container(
                                          height: 60,
                                          width: 250,
                                          child: TextFormField(
                                            onChanged: (String userName) {
                                              getUserName(userName);
                                            },
                                            style: TextStyle(
                                                fontFamily: 'CircularStd-Book',
                                                fontSize: 16,
                                                color: Color(0xffA2A2A2)),
                                            keyboardType:
                                                TextInputType.name,
                                            decoration: new InputDecoration(
                                              hintText: name,
                                              hintStyle: TextStyle(
                                                  fontFamily:
                                                      'CircularStd-Book',
                                                  fontSize: 20,
                                                  color: Colors.white70),
                                              border: InputBorder.none,
                                              focusedBorder: InputBorder.none,
                                              enabledBorder: InputBorder.none,
                                              errorBorder: InputBorder.none,
                                              disabledBorder: InputBorder.none,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 18.0, right: 18, top: 9),
                        child: Container(
                          height: 70,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Color(0xffFFFFFF)
                                .withOpacity(0.10196078431372549),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Center(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 18.0, right: 18),
                              child: Row(
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 14.0),
                                        child: Container(
                                            height: 20,
                                            child: Image.asset(
                                                "assets/images/envelope (1).png")),
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Center(
                                        child: Container(
                                          height: 60,
                                          width: 250,
                                          child: TextField(
                                            readOnly: true,
                                            style: TextStyle(
                                                fontFamily: 'CircularStd-Book',
                                                fontSize: 16,
                                                color: Color(0xffA2A2A2)),
                                            keyboardType:
                                                TextInputType.multiline,
                                            decoration: new InputDecoration(
                                              hintText: email,
                                              hintStyle: TextStyle(
                                                  fontFamily:
                                                      'CircularStd-Book',
                                                  fontSize: 20,
                                                  color: Colors.white70),
                                              border: InputBorder.none,
                                              focusedBorder: InputBorder.none,
                                              enabledBorder: InputBorder.none,
                                              errorBorder: InputBorder.none,
                                              disabledBorder: InputBorder.none,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 18.0, right: 18, top: 9),
                        child: Container(
                          height: 70,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Color(0xffFFFFFF)
                                .withOpacity(0.10196078431372549),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Center(
                            child: Padding(
                              padding:
                              const EdgeInsets.only(left: 18.0, right: 18),
                              child: Row(
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding:
                                        const EdgeInsets.only(bottom: 14.0),
                                        child: Container(
                                            height: 20,
                                            child: Image.asset(
                                                "assets/images/phone-numbers-call.png")),
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Center(
                                        child: Container(
                                          height: 60,
                                          width: 250,
                                          child: TextFormField(
                                            validator: (value) {
                                              if (value.isEmpty) {
                                                return 'Please enter phone number';
                                              }
                                              return null;
                                            },
                                            onChanged: (String phoneNum) {
                                              getPhoneNum(phoneNum);
                                            },
                                            style: TextStyle(
                                                fontFamily: 'CircularStd-Book',
                                                fontSize: 16,
                                                color: Color(0xffA2A2A2)),
                                            keyboardType:
                                            TextInputType.phone,
                                            decoration: new InputDecoration(
                                              hintText: '+x xxx xxx xxxx',
                                              hintStyle: TextStyle(
                                                  fontFamily:
                                                  'CircularStd-Book',
                                                  fontSize: 20,
                                                  color: Colors.white70),
                                              border: InputBorder.none,
                                              focusedBorder: InputBorder.none,
                                              enabledBorder: InputBorder.none,
                                              errorBorder: InputBorder.none,
                                              disabledBorder: InputBorder.none,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      if (_formKey.currentState.validate()) {
                        // If the form is valid, display a Snackbar.
                        //ScaffoldMessenger.of(context).showSnackBar(
                        //    SnackBar(content: Text('Processing Data')));
                        addUserDetails();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Home(widget.currentUser, widget.phoneNum)),
                        );
                      }
                    },
                    child: Padding(
                      padding:
                          const EdgeInsets.only(right: 35, left: 35, top: 30.0),
                      child: Container(
                        height: 65,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: buttonBg,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Register me',
                                style: TextStyle(
                                    fontFamily: 'CircularStd-Medium',
                                    fontSize: 22,
                                    color: darkBg),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
