import 'package:budeng/constants/colors.dart';
import 'package:budeng/user_dashboard.dart';
//import 'package:be_app/ui/booking.dart';
//import 'package:be_app/ui/searchResult.dart';
import 'package:flutter/material.dart';

class SubscribeProperty extends StatefulWidget {
  @override
  _SubscribePropertyState createState() => _SubscribePropertyState();
}

class _SubscribePropertyState extends State<SubscribeProperty> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
            child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 27.0, top: 5, right: 27),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 18),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'Please add your Details',
                              style: TextStyle(
                                  fontFamily: 'CircularStd-Bold',
                                  fontSize: 22,
                                  color: Color(0xff000000)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 18.0),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Text(
                              'Selected Services',
                              style: TextStyle(
                                  fontFamily: 'CircularStd-Bold',
                                  fontSize: 17,
                                  color: Color(0xff000000)),
                            ),
                            Container(
                                width: 130,
                                child: Divider(
                                  thickness: 4,
                                  color: buttonBg,
                                  height: 10,
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Row(
                      children: [
                        Image.asset('assets/images/Path 64.png'),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                            child: Text(
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                          style: TextStyle(
                              fontFamily: 'CircularStd-Book',
                              fontSize: 13,
                              color: Color(0xff000000)),
                        )),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Row(
                      children: [
                        Image.asset('assets/images/Path 64.png'),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                            child: Text(
                          'Duis faucibus lacus in orci posuere imperdiet.',
                          style: TextStyle(
                              fontFamily: 'CircularStd-Book',
                              fontSize: 13,
                              color: Color(0xff000000)),
                        )),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 14.0),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Text(
                              'Basic Details',
                              style: TextStyle(
                                  fontFamily: 'CircularStd-Bold',
                                  fontSize: 17,
                                  color: Color(0xff000000)),
                            ),
                            Container(
                                width: 110,
                                child: Divider(
                                  thickness: 4,
                                  color: buttonBg,
                                  height: 10,
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 27.0, right: 27, top: 9),
              child: Row(
                children: [
                  Column(
                    children: [
                      Text(
                        'Address',
                        style: TextStyle(
                            fontFamily: 'CircularStd-Book',
                            fontSize: 17,
                            color: Color(0xff000000)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 27.0, right: 27, top: 5),
              child: Container(
                height: 80,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xffF1F1F1).withOpacity(1),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8, top: 12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Center(
                            child: Container(
                              height: 60,
                              width: 250,
                              child: TextField(
                                style: TextStyle(
                                    fontFamily: 'CircularStd-Book',
                                    fontSize: 16,
                                    color: Color(0xffA2A2A2)),
                                keyboardType: TextInputType.multiline,
                                decoration: new InputDecoration(
                                  hintText: 'Enter Address',
                                  hintStyle: TextStyle(
                                      fontFamily: 'CircularStd-Book',
                                      fontSize: 16,
                                      color: Color(0xffA2A2A2)),
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
            Padding(
              padding: const EdgeInsets.only(left: 27.0, right: 27, top: 14),
              child: Row(
                children: [
                  Column(
                    children: [
                      Text(
                        'Area',
                        style: TextStyle(
                            fontFamily: 'CircularStd-Book',
                            fontSize: 17,
                            color: Color(0xff000000)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 27.0, right: 27, top: 5),
              child: Container(
                height: 60,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xffF1F1F1).withOpacity(1),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8, top: 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Center(
                        child: Container(
                          height: 60,
                          width: 250,
                          child: TextField(
                            style: TextStyle(
                                fontFamily: 'CircularStd-Book',
                                fontSize: 16,
                                color: Color(0xffA2A2A2)),
                            keyboardType: TextInputType.multiline,
                            decoration: new InputDecoration(
                              hintText: 'Enter Address',
                              hintStyle: TextStyle(
                                  fontFamily: 'CircularStd-Book',
                                  fontSize: 16,
                                  color: Color(0xffA2A2A2)),
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      /*Column(
                                children: [
                                  Container(height: 30,child: Divider(height: 30,thickness: 23,))
                                ],
                              )*/
                      Row(
                        children: [
                          Container(
                            height: 35,
                            width: 1.5,
                            color: Colors.black,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Sqft',
                            style: TextStyle(
                                fontFamily: 'CircularStd-Book',
                                fontSize: 16,
                                color: Color(0xff000000)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 27.0, right: 27, top: 15),
              child: Row(
                children: [
                  Column(
                    children: [
                      Text(
                        'Start Date',
                        style: TextStyle(
                            fontFamily: 'CircularStd-Bold',
                            fontSize: 17,
                            color: Color(0xff000000)),
                      ),
                      Container(
                          width: 90,
                          child: Divider(
                            thickness: 4,
                            color: buttonBg,
                            height: 10,
                          )),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 27.0, right: 27, top: 5),
              child: Container(
                height: 60,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xffF1F1F1).withOpacity(1),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8, top: 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Center(
                        child: Container(
                          height: 60,
                          width: 250,
                          child: TextField(
                            style: TextStyle(
                                fontFamily: 'CircularStd-Book',
                                fontSize: 16,
                                color: Color(0xffA2A2A2)),
                            keyboardType: TextInputType.multiline,
                            decoration: new InputDecoration(
                              hintText: 'Enter Date',
                              hintStyle: TextStyle(
                                  fontFamily: 'CircularStd-Book',
                                  fontSize: 16,
                                  color: Color(0xffA2A2A2)),
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      /*Column(
                                children: [
                                  Container(height: 30,child: Divider(height: 30,thickness: 23,))
                                ],
                              )*/
                      Container(
                          height: 40,
                          width: 40,
                          child:
                              Image.asset('assets/images/calendar (10).png')),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 27.0, right: 27, top: 15),
              child: Row(
                children: [
                  Column(
                    children: [
                      Text(
                        'End Date',
                        style: TextStyle(
                            fontFamily: 'CircularStd-Bold',
                            fontSize: 17,
                            color: Color(0xff000000)),
                      ),
                      Container(
                          width: 90,
                          child: Divider(
                            thickness: 4,
                            color: buttonBg,
                            height: 10,
                          )),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 27.0, right: 27, top: 5),
              child: Container(
                height: 60,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xffF1F1F1).withOpacity(1),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8, top: 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Center(
                        child: Container(
                          height: 60,
                          width: 250,
                          child: TextField(
                            style: TextStyle(
                                fontFamily: 'CircularStd-Book',
                                fontSize: 16,
                                color: Color(0xffA2A2A2)),
                            keyboardType: TextInputType.multiline,
                            decoration: new InputDecoration(
                              hintText: 'Enter Date',
                              hintStyle: TextStyle(
                                  fontFamily: 'CircularStd-Book',
                                  fontSize: 16,
                                  color: Color(0xffA2A2A2)),
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      /*Column(
                                children: [
                                  Container(height: 30,child: Divider(height: 30,thickness: 23,))
                                ],
                              )*/
                      Container(
                          height: 40,
                          width: 40,
                          child:
                              Image.asset('assets/images/calendar (10).png')),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 18.0, bottom: 18),
              child: Container(
                height: 50,
                width: double.infinity,
                color: Colors.black,
                child: Padding(
                  padding: const EdgeInsets.only(left: 22.0, right: 22),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total Price for\nSelected Services',
                        style: TextStyle(
                            fontFamily: 'CircularStd-Medium',
                            fontSize: 14,
                            color: Color(0xffFFFFFF)),
                      ),
                      Text(
                        '70',
                        style: TextStyle(
                            fontFamily: 'CircularStd-Bold',
                            fontSize: 27,
                            color: buttonBg),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  //MaterialPageRoute(builder: (context) => Booked()),
                  MaterialPageRoute(builder: (context) => UserDashboard()),
                );
              },
              child: Padding(
                padding:
                    const EdgeInsets.only(right: 35, left: 35, bottom: 10.0),
                child: Container(
                  height: 55,
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
                          'Continue',
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
        )),
      ),
    );
  }
}
