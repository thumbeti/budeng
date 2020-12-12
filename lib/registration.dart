import 'package:budeng/first_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Registration extends StatefulWidget {
  @override
  _RegestrationState createState() => _RegestrationState();
}

class _RegestrationState extends State<Registration> {
  final _formKey = GlobalKey();

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

  createDate() {
    DocumentReference ds =
    FirebaseFirestore.instance.collection('users').doc(phoneNum);

    Map<String, dynamic> users = {
      'userName':userName,
      'phoneNum':phoneNum,
      'address1':address1,
      'address2':address2,
      'city':city,
      'country':country,
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
        title: Text('User registration.'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        child: Builder(
          builder: (context) => Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 16.0, right: 16.0),
                  child: TextField(
                    // controller: _taskNameController,
                    onChanged: (String userName){
                      getUserName(userName);
                    },
                    decoration: InputDecoration(
                      labelText: "Full Name",
                      icon: Icon(Icons.person),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16.0, right:16.0),
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
                  padding: EdgeInsets.only(left: 16.0, right:16.0),
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
                  padding: EdgeInsets.only(left: 16.0, right:16.0),
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
                  padding: EdgeInsets.only(left: 16.0, right:16.0),
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
                  padding: EdgeInsets.only(left: 16.0, right:16.0),
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
                Row (
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    RaisedButton (
                      color: Colors.blueAccent,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text (
                        "Cancel",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    RaisedButton(
                      color: Colors.blueAccent,
                      onPressed: () {
                        createDate();
                        Navigator.of(context).push(
                            //MaterialPageRoute<void>(builder: (_) => OrderingMenu(phoneNum))
                            MaterialPageRoute<void>(builder: (_) => FirstScreen())
                        );
                      },
                      child: const Text (
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
