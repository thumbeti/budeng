import 'package:budeng/constants/colors.dart';
import 'package:budeng/user_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:budeng/constants/service_tasks.dart';
import 'package:budeng/subscribe_property.dart';

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

  List<bool> svs_inputs = [];
  //List svs_inputs = new List<bool>();
  List<bool> mvs_inputs = [];
  //List mvs_inputs = new List<bool>();
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
      for (int i = 0; i < svs_items.length; i++) {
        svs_inputs.add(false);
      };
      for (int j = 0; j < mvs_items.length; j++) {
        mvs_inputs.add(false);
      };
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
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
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
                      InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Container(
                            child: Row(
                              children: [
                                Container(
                                  height: 70,
                                  width: 70,
                                  child:
                                      Image.asset('assets/images/menu (8).png'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
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
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 27.0, top: 18, right: 27),
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
                    child: Icon(
                      Icons.person,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 27.0, top: 5),
              child: Row(
                children: [
                  Text(
                    'Choose A Service',
                    style: TextStyle(
                        fontFamily: 'CircularStd-Bold',
                        fontSize: 32,
                        color: Color(0xff000000)),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 5.0, left: 27, right: 27, bottom: 5),
              child: Row(
                children: [
                  Container(
                    width: 300,
                    child: TabBar(
                      controller: _controller,
                      indicatorWeight: 5,
                      indicatorColor: buttonBg,
                      tabs: [
                        Tab(
                          child: Text(
                            ' Secure Site',
                            style: TextStyle(
                                fontFamily: 'CircularStd-Bold',
                                fontSize: 14,
                                color: Color(0xff000000)),
                          ),
                        ),
                        Tab(
                          child: Text(
                            'Maintanance Site',
                            style: TextStyle(
                                fontFamily: 'CircularStd-Bold',
                                fontSize: 14,
                                color: Color(0xff000000)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18.0, right: 18),
              child: Container(
                height: 500,
                child: TabBarView(
                  controller: _controller,
                  children: [
                    Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Container(
                        height: 295,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Color(0xffFFFFFF),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 0,
                          ),
                          child: Column(
                            children: [
                              Container(
                                height: 130,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/home-security-ai.png'),
                                        fit: BoxFit.fill)),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 18.0, top: 8),
                                child: Row(
                                  children: [
                                    Text(
                                      'Secure Site',
                                      style: TextStyle(
                                          fontFamily: 'CircularStd-Bold',
                                          fontSize: 21,
                                          color:
                                              Color(0xff000000).withOpacity(1)),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 5.0, left: 18),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                      'Secure your property from any corner of the world!\n \n'
                                      'It includes video tour of site with market Information. - Rs 1 /sqft/year',
                                      style: TextStyle(
                                          fontFamily: 'CircularStd-Book',
                                          fontSize: 14,
                                          color: Colors.black),
                                    ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 18.0, top: 14, right: 18),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Optional tasks',
                                      style: TextStyle(
                                          fontFamily: 'CircularStd-Bold',
                                          fontSize: 14,
                                          color:
                                              Color(0xff000000).withOpacity(1)),
                                    ),
                                    Container(
                                      height: 40,
                                      width: 70,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: Colors.black),
                                      child: Center(
                                        child: Text(
                                          "70",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Divider(height: 4),
                              Expanded(
                                child: ListView.builder(
                                    //shrinkWrap: true,
                                    //physics: NeverScrollableScrollPhysics(),
                                    itemCount: svs_items.length,
                                    itemBuilder:
                                        (BuildContext ctxt, int index) {
                                      return SizedBox(
                                        height: 36,
                                        child: new CheckboxListTile(
                                          checkColor: buttonBg,
                                          activeColor: Colors.white,
                                          title: Text(
                                            "${svs_items[index]}",
                                            style: TextStyle(
                                                fontFamily: 'CircularStd-Book',
                                                fontSize: 14,
                                                color: Color(0xff000000)
                                                    .withOpacity(1)),
                                          ),

                                          value: svs_inputs[index],
                                          onChanged: (bool val) {
                                            setState(() {
                                              svs_inputs[index] = val;
                                            });
                                          },
                                          controlAffinity:
                                              ListTileControlAffinity.leading,

                                          //  <-- leading Checkbox
                                        ),
                                      );
                                    }),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        //builder: (context) => AddDetail()),
                                        builder: (context) => SubscribeProperty()),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Container(
                                    height: 40,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: buttonBg,
                                      borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(15),
                                          bottomLeft: Radius.circular(15)),
                                    ),
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            'Subscribe',
                                            style: TextStyle(
                                                fontFamily:
                                                    'CircularStd-Medium',
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
                    Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Container(
                        height: 295,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Color(0xffFFFFFF),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 0,
                          ),
                          child: Column(
                            children: [
                              Container(
                                height: 130,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/home-security-ai.png'),
                                        fit: BoxFit.fill)),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 18.0, top: 8),
                                child: Row(
                                  children: [
                                    Text(
                                      'Maintanance Site',
                                      style: TextStyle(
                                          fontFamily: 'CircularStd-Bold',
                                          fontSize: 21,
                                          color:
                                              Color(0xff000000).withOpacity(1)),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 5.0, left: 18),
                                child: Row(
                                  children: [
                                    Text(
                                      'It is a long established fact that a reader will be\ndistracted by the readable content of a page\nwhen looking at its layout.',
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
                                    left: 18.0, top: 14, right: 18),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Package Cost',
                                      style: TextStyle(
                                          fontFamily: 'CircularStd-Bold',
                                          fontSize: 14,
                                          color:
                                              Color(0xff000000).withOpacity(1)),
                                    ),
                                    Container(
                                      height: 40,
                                      width: 70,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: Colors.black),
                                      child: Center(
                                        child: Text(
                                          "70",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Divider(height: 4),
                              Expanded(
                                child: ListView.builder(
                                    itemCount: svs_items.length,
                                    itemBuilder:
                                        (BuildContext ctxt, int index) {
                                      return SizedBox(
                                        height: 36,
                                        child: new CheckboxListTile(
                                          checkColor: buttonBg,
                                          activeColor: Colors.white,
                                          title: Text(
                                            "${svs_items[index]}",
                                            style: TextStyle(
                                                fontFamily: 'CircularStd-Book',
                                                fontSize: 14,
                                                color: Color(0xff000000)
                                                    .withOpacity(1)),
                                          ),

                                          value: svs_inputs[index],
                                          onChanged: (bool val) {
                                            setState(() {
                                              svs_inputs[index] = val;
                                            });
                                          },
                                          controlAffinity:
                                              ListTileControlAffinity.leading,

                                          //  <-- leading Checkbox
                                        ),
                                      );
                                    }),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        //builder: (context) => AddDetail()),
                                        builder: (context) => UserDashboard()),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Container(
                                    height: 55,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: buttonBg,
                                      borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(15),
                                          bottomLeft: Radius.circular(15)),
                                    ),
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            'Subscribe',
                                            style: TextStyle(
                                                fontFamily:
                                                    'CircularStd-Medium',
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
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
