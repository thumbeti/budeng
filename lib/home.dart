import 'package:budeng/constants/colors.dart';
import 'package:budeng/login_page.dart';
import 'package:budeng/sign_in.dart';
import 'package:budeng/user_registration.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:budeng/constants/service_tasks.dart';
import 'package:budeng/subscribe_property.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:focused_menu/modals.dart';
import 'package:intl/intl.dart';
import 'package:focused_menu/focused_menu.dart';

class Home extends StatefulWidget {
  final User currentUser;
  final String phoneNum;
  const Home(this.currentUser, this.phoneNum);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  bool isService = false;
  bool isHome = true;
  TabController _controller;
  int _selectedIndex = 0;

  List<bool> servicesSelected = [];
  bool temp = false;

  Stream<QuerySnapshot> itemStream;

  void initState() {
    // TODO: implement initState
    itemStream = FirebaseFirestore.instance
        .collection('users')
        .doc(widget.currentUser.email)
        .collection('subscriptions')
        .snapshots();
    super.initState();
    // Create TabController for getting the index of current tab
    _controller = TabController(length: 2, vsync: this);

    _controller.addListener(() {
      setState(() {
        _selectedIndex = _controller.index;
      });
      print("Selected Index: " + _controller.index.toString());
    });
    setState(() {
      for (int i = 0; i < BEServices.length; i++) {
        servicesSelected.add(false);
      }
      ;
      temp = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBg.withOpacity(1),
      //backgroundColor: darkBg.withOpacity(1),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              isHome ? home() : services(),
              Positioned(
                bottom: 2,
                left: 18,
                right: 18,
                child: Container(
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.black,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            isHome = true;
                            isService = false;
                          });
                        },
                        child: Container(
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Container(
                                  height: 40,
                                  width: isHome ? 120 : 120,
                                  decoration: BoxDecoration(
                                      color: isHome ? buttonBg : Colors.black,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Row(
                                      children: [
                                        isHome
                                            ? Image.asset(
                                                'assets/images/home.png')
                                            : Image.asset(
                                                'assets/images/home2.png'),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        isHome
                                            ? Text(
                                                'Home',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18),
                                              )
                                            : Text(
                                          'Home',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            isService = true;
                            isHome = false;
                          });
                        },
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Container(
                                  height: 40,
                                  width: isService ? 140 : 140,
                                  decoration: BoxDecoration(
                                      color:
                                          isService ? buttonBg : Colors.black,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Row(
                                      children: [
                                        isService
                                            ? Image.asset(
                                                'assets/images/30-technical2.png')
                                            : Image.asset(
                                                'assets/images/30-technical.png'),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        isService
                                            ? Text(
                                                'Services',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18),
                                              )
                                            : Text(
                                                'Services',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18),
                                              ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget home() {
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            homeHeader(),
            Padding(
              padding: const EdgeInsets.only(top: 15, right: 150),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'All your properties',
                    style: TextStyle(
                        fontFamily: 'CircularStd-Bold',
                        fontSize: 25,
                        color: Color(0xff000000)),
                  ),
                  Container(
                      width: 200,
                      child: Divider(
                        thickness: 3,
                        color: buttonBg,
                        height: 10,
                      )),
                ],
              ),
            ),
            Container(
              //height: 550,
              child: StreamBuilder(
                stream: itemStream,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.data.documents.length == 0) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 50,
                          ),
                          Text(
                              'Please subscribe services for your properties..!!',
                              style: TextStyle(
                                  fontFamily: 'CircularStd-Bold',
                                  fontSize: 25,
                                  color: Color(0xff000000))),
                          Container(),
                        ],
                      ),
                    );
                  }
                  return ListView.builder(
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, index) {
                        return listTileBuilder(
                            context, snapshot.data.documents[index], index);
                      },
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics());
                },
              ),
            ),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  Widget listTileBuilder(
      BuildContext context, DocumentSnapshot document, int index) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
      child: Card(
        color: Colors.black12,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white70,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 18.0, top: 0),
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Text(
                        'Address:      ',
                        style: TextStyle(
                            fontFamily: 'CircularStd-Bold',
                            fontSize: 18,
                            color: Color(0xff000000).withOpacity(1)),
                      ),
                    ),
                    Flexible(
                      child: Text(
                        document['propertyAddress'],
                        style: TextStyle(
                            fontFamily: 'CircularStd-Bold',
                            fontSize: 21,
                            color: Color(0xff000000).withOpacity(1)),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                  child: Row(
                    children: [
                      Text(
                        'Subscribed on:  ',
                        style: TextStyle(
                            fontFamily: 'CircularStd-Bold',
                            fontSize: 18,
                            color: Color(0xff000000).withOpacity(1)),
                      ),
                      Flexible(
                        child: Text(
                          DateFormat('dd-MM-yyyy').format(
                              DateTime.fromMillisecondsSinceEpoch(
                                  document['subscriptionDate']
                                      .millisecondsSinceEpoch)),
                          style: TextStyle(
                              fontFamily: 'CircularStd-Medium',
                              fontSize: 20,
                              color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Subscribed for:',
                        style: TextStyle(
                            fontFamily: 'CircularStd-Bold',
                            fontSize: 18,
                            color: Color(0xff000000).withOpacity(1)),
                      ),
                      Text(
                        document['noYears'].toString() + ' years.',
                        style: TextStyle(
                            fontFamily: 'CircularStd-Medium',
                            fontSize: 20,
                            color: Colors.black),
                      ),
                      Container(
                        height: 30,
                        width: 50,
                        decoration: BoxDecoration(
                          color: buttonBg,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Center(
                          child: Text(
                            (index + 1).toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 22),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Subscribed services:  ',
                        style: TextStyle(
                            fontFamily: 'CircularStd-Bold',
                            fontSize: 18,
                            color: Color(0xff000000).withOpacity(1)),
                      ),
                      Flexible(
                        child: Text(
                          document['services'].toString(),
                          style: TextStyle(
                              fontFamily: 'CircularStd-Medium',
                              fontSize: 20,
                              color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget services() {
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            homeHeader(),
            Padding(
              padding: const EdgeInsets.only(right: 185.0, top: 5),
              child: Column(
                children: [
                  Text(
                    'Select Services',
                    style: TextStyle(
                        fontFamily: 'CircularStd-Bold',
                        fontSize: 25,
                        color: Color(0xff000000)),
                  ),
                  Container(
                      width: 170,
                      child: Divider(
                        thickness: 3,
                        color: buttonBg,
                        height: 10,
                      )),
                ],
              ),
            ),
            serviceCheckBox(0, false),
            serviceCheckBox(1, false),
            servicesSelected[3]
                ? serviceCheckBox(2, true)
                : serviceCheckBox(2, false),
            servicesSelected[2]
                ? serviceCheckBox(3, true)
                : serviceCheckBox(3, false),
            serviceCheckBox(4, false),
            serviceCheckBox(5, false),
            SizedBox(height: 20),
            InkWell(
              onTap: () {
                if (isServicesSelected()) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SubscribeProperty(
                            widget.currentUser,
                            widget.phoneNum,
                            servicesSelected)),
                  );
                } else {
                  showDialog(
                      context: context,
                      builder: (_) => new AlertDialog(
                            title: Text(
                              "Please select at least one service!",
                              style: TextStyle(
                                fontFamily: 'CircularStd-Bold',
                                fontSize: 20,
                              ),
                            ),
                            actions: <Widget>[
                              FlatButton(
                                child: Text(
                                  'Close me!',
                                  style: TextStyle(
                                      fontFamily: 'CircularStd-Bold',
                                      fontSize: 20,
                                      color: Colors.amber),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          ));
                }
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Container(
                  height: 50,
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
                          'Subscribe Service(s)',
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
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  bool isServicesSelected() {
    if (!servicesSelected[0] &&
        !servicesSelected[1] &&
        !servicesSelected[2] &&
        !servicesSelected[3] &&
        !servicesSelected[4] &&
        !servicesSelected[5]) {
      return false;
    } else {
      return true;
    }
  }

  Padding homeHeader() {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, top: 5, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 60,
            width: 98,
            decoration: BoxDecoration(
                color: Colors.black, borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Row(
                children: [
                  Image.asset('assets/images/Group7.png'),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
          ),
          Container(
            child: FocusedMenuHolder(
              menuWidth: MediaQuery.of(context).size.width * 0.50,
              blurSize: 5.0,
              menuItemExtent: 45,
              menuBoxDecoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              duration: Duration(milliseconds: 100),
              animateMenuItems: true,
              blurBackgroundColor: Colors.black54,
              bottomOffsetHeight: 100,
              openWithTap: true,
              menuItems: <FocusedMenuItem>[
                FocusedMenuItem(
                    title: Text("Logout"),
                    trailingIcon: Icon(Icons.logout),
                    onPressed: () {
                      signOutGoogle();
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    }),
                FocusedMenuItem(
                    title: Text("Edit user info"),
                    trailingIcon: Icon(Icons.edit),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UserRegistration(
                                  widget.currentUser, widget.phoneNum)));
                    }),
              ],
              onPressed: () {},
              child: Row(
                children: [
                  Text(
                    widget.currentUser.displayName,
                    style: TextStyle(
                        fontFamily: 'CircularStd-Book',
                        fontSize: 20,
                        color: darkBg),
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.amber,
                    child: Icon(
                      Icons.person,
                      color: Colors.black,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding serviceCheckBox(int index, bool grey) {
    return Padding(
      padding: const EdgeInsets.only(left: 0.0, top: 0, bottom: 5),
      child: SafeArea(
        child: CheckboxListTile(
          tileColor: grey ? Colors.black12 : Colors.white70,
          checkColor: buttonBg,
          activeColor: Colors.black54,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  BEServices[index],
                  style: TextStyle(
                      fontFamily: 'CircularStd-Book',
                      fontSize: 20,
                      color: Color(0xff000000).withOpacity(1)),
                ),
              ),
              Container(
                height: 40,
                width: 120,
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
          subtitle: ExpandableText(
            BEServicesInfo[index],
            collapseText: 'less',
            expandText: 'more',
            maxLines: 2,
            linkColor: Colors.blue,
            style: TextStyle(
                fontFamily: 'CircularStd-Book',
                fontSize: 15,
                color: Color(0xff000000).withOpacity(1)),
          ),
          value: servicesSelected[index],
          onChanged: grey
              ? null
              : (bool val) {
                  setState(() {
                    servicesSelected[index] = val;
                  });
                },
          controlAffinity: ListTileControlAffinity.leading,
        ),
      ),
    );
  }
}
