import 'package:budeng/constants/colors.dart';
import 'package:budeng/user_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:budeng/constants/service_tasks.dart';
import 'package:budeng/subscribe_property.dart';
import 'package:expandable_text/expandable_text.dart';

class Home extends StatefulWidget {
  final User currentUser;
  const Home(this.currentUser);
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

  void initState() {
    // TODO: implement initState
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
                                  width: isHome ? 120 : 60,
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
                                            : Text('')
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
                                  width: isService ? 140 : 60,
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
                                            : Text('')
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
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 27.0, top: 18, right: 27),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Welcome David',
                    style: TextStyle(
                        fontFamily: 'CircularStd-Book',
                        fontSize: 16,
                        color: Color(0xff707070)),
                  ),
                  CircleAvatar(
                    child: Icon(
                      Icons.person,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 27.0, top: 18),
              child: Row(
                children: [
                  Text(
                    'Find all\nyour Properties',
                    style: TextStyle(
                        fontFamily: 'CircularStd-Bold',
                        fontSize: 32,
                        color: Color(0xff000000)),
                  ),
                ],
              ),
            ),
            Container(
              height: 550,
              child: ListView.builder(
                  itemCount: 8,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding:
                          const EdgeInsets.only(top: 27, left: 27, right: 27),
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: Container(
                          height: 295,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Color(0xffFFFFFF),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 18.0, top: 0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Luxury Duplex House',
                                      style: TextStyle(
                                          fontFamily: 'CircularStd-Bold',
                                          fontSize: 21,
                                          color:
                                              Color(0xff000000).withOpacity(1)),
                                    ),
                                    Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                        color: buttonBg,
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: Center(
                                        child: Text(
                                          '01',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 22),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 5.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        'Woodroad, Manchester, IG4',
                                        style: TextStyle(
                                            fontFamily: 'CircularStd-Book',
                                            fontSize: 14,
                                            color: Color(0xffA2A2A2)),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10.0, bottom: 10),
                                  child: Row(
                                    children: [
                                      Text(
                                        'Maintanence Started on',
                                        style: TextStyle(
                                            fontFamily: 'CircularStd-Medium',
                                            fontSize: 14,
                                            color: Color(0xff000000)
                                                .withOpacity(1)),
                                      ),
                                      Text(
                                        '  10-06-2020',
                                        style: TextStyle(
                                            fontFamily: 'CircularStd-Medium',
                                            fontSize: 14,
                                            color: buttonBg),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      height: 80,
                                      width: 150,
                                      child: Image.asset(
                                          'assets/images/pexels-photo-971001.png'),
                                    ),
                                    Container(
                                      height: 80,
                                      width: 150,
                                      child: Image.asset(
                                          'assets/images/pexels-photo-271624.png'),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 8.0, top: 10),
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 50,
                                        width: 50,
                                        child: Image.asset(
                                            'assets/images/pexels-photo-271639.png'),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Container(
                                        height: 50,
                                        width: 50,
                                        child: Image.asset(
                                            'assets/images/pexels-photo-271618.png'),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Container(
                                        height: 50,
                                        width: 50,
                                        child: Image.asset(
                                            'assets/images/pexels-photo-1743555.png'),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Container(
                                        height: 50,
                                        width: 50,
                                        child: Image.asset(
                                            'assets/images/pexels-photo-4119832.png'),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Container(
                                        height: 50,
                                        width: 50,
                                        color: Color(0xffB7B7B7)
                                            .withOpacity(0.20000000298023224),
                                        child: Center(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                '+6',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                'photos',
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 14.0, right: 18),
                                  child: Container(
                                    height: 30,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Color(0xffF8F9FB).withOpacity(1),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                              'assets/images/Ellipse 2@1X.png'),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            'Maintanence till ',
                                            style: TextStyle(
                                              fontFamily: 'CircularStd-Medium',
                                              fontSize: 16,
                                            ),
                                          ),
                                          Text(
                                            '01-01-2021',
                                            style: TextStyle(
                                                fontFamily:
                                                    'CircularStd-Medium',
                                                fontSize: 16,
                                                color: buttonBg),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Image.asset(
                                              'assets/images/Ellipse 2@1X.png'),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  shrinkWrap: true),
            ),
          ],
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
            Padding(
              padding: const EdgeInsets.only(left: 27.0, top: 5, right: 27),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    widget.currentUser.displayName,
                    style: TextStyle(
                        fontFamily: 'CircularStd-Book',
                        fontSize: 20,
                        color: Colors.black),
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
            Padding(
              padding: const EdgeInsets.only(right: 150.0, top: 5),
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
            serviceCheckBox(0),
            serviceCheckBox(1),
            servicesSelected[3] ? Container() : serviceCheckBox(2),
            servicesSelected[2] ? Container() : serviceCheckBox(3),
            serviceCheckBox(4),
            serviceCheckBox(5),
            SizedBox(height: 30),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          SubscribeProperty(widget.currentUser, servicesSelected)),
                );
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
                          'Subscribe Property',
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

  Padding serviceCheckBox(int index) {
    return Padding(
      padding: const EdgeInsets.only(left: 0.0, top: 5, bottom: 5),
      child: SafeArea(
        child: CheckboxListTile(
          tileColor: Colors.white10,
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
                width: 110,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: buttonBg,
                ),
                child: Center(
                  child: Text(
                    BEServicesCharges[index],
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              )
              /*
              Text(
                BEServicesCharges[index],
                style: TextStyle(
                    fontFamily: 'CircularStd-Book',
                    fontSize: 20,
                    color: Colors.black.withOpacity(1)),
              ),

               */
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
          onChanged: (bool val) {
            print('Siva....before ' + servicesSelected[index].toString());
            setState(() {
              servicesSelected[index] = val;
            });
            print('Siva....after ' + servicesSelected[index].toString());
          },
          controlAffinity: ListTileControlAffinity.leading,
        ),
      ),
    );
  }
}
