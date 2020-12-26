import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:budeng/user_dashboard.dart';

class Registration2 extends StatefulWidget {
  final User currentUser;
  const Registration2(this.currentUser);
  @override
  _Registration2State createState() => _Registration2State();
}

class _Registration2State extends State<Registration2> {
  final _formKey = GlobalKey<FormState>();

  String userName, phoneNum, address1, address2, city, country;

  getUserName(userName) {
    this.userName = userName;
  }

  getPhoneNum(phoneNum) {
    this.phoneNum = phoneNum;
  }

  getAddress1(address1) {
    this.address1 = address1;
  }

  getAddress2(address2) {
    this.address2 = address2;
  }

  getCity(city) {
    this.city = city;
  }

  getCountry(country) {
    this.country = country;
  }

  addUserDetails() {
    DocumentReference ds =
        FirebaseFirestore.instance.collection('users').doc(widget.currentUser.email);

    Map<String, dynamic> users = {
      'userName': userName,
      'email': widget.currentUser.email,
      'phoneNum': phoneNum,
      'address1': address1,
      'address2': address2,
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
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('User Registration'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        child: Builder(
          builder: (context) => Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Text(
                    "Welcome " + widget.currentUser.displayName
                        + ".\n Please provide the following details:",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16.0, right: 16.0),
                  child: TextFormField(
                    // controller: _taskNameController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter Full Name';
                      }
                      return null;
                    },
                    onChanged: (String userName) {
                      getUserName(userName);
                    },
                    decoration: InputDecoration(
                      labelText: "Full Name",
                      icon: Icon(Icons.person),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16.0, right: 16.0),
                  child: TextField(
                    onChanged: (String phoneNum) {
                      getPhoneNum(phoneNum);
                    },
                    decoration: InputDecoration(
                      labelText: "Phone Number",
                      icon: Icon(Icons.contact_phone),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16.0, right: 16.0),
                  child: TextField(
                    onChanged: (String address1) {
                      getAddress1(address1);
                    },
                    decoration: InputDecoration(
                      labelText: "Address line 1",
                      icon: Icon(Icons.contact_mail),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16.0, right: 16.0),
                  child: TextField(
                    onChanged: (String address2) {
                      getAddress2(address2);
                    },
                    decoration: InputDecoration(
                      labelText: "Address line 2",
                      icon: Icon(Icons.contact_mail),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16.0, right: 16.0),
                  child: TextField(
                    onChanged: (String city) {
                      getCity(city);
                    },
                    decoration: InputDecoration(
                      labelText: "City",
                      icon: Icon(Icons.location_city),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16.0, right: 16.0),
                  child: TextField(
                    onChanged: (String country) {
                      getCountry(country);
                    },
                    decoration: InputDecoration(
                      labelText: "Country",
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    RaisedButton(
                      color: Colors.blueAccent,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        "Cancel",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    RaisedButton(
                      color: Colors.blueAccent,
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          // If the form is valid, display a Snackbar.
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Processing Data')));
                        }
                        addUserDetails();
                        Navigator.of(context).push(
                            //MaterialPageRoute<void>(builder: (_) => OrderingMenu(phoneNum))
                            MaterialPageRoute<void>(
                                builder: (_) => UserDashboard()));
                      },
                      child: const Text(
                        "Submit",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}