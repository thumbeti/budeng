import 'package:budeng/constants/colors.dart';
import 'package:budeng/home.dart';
import 'package:budeng/sign_in.dart';
import 'package:budeng/user_registration.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:budeng/constants/service_tasks.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:toast/toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

import 'login_page.dart';

class SubscribeProperty extends StatefulWidget {
  final User currentUser;
  final String phoneNum;
  final List<bool> servicesSelected;
  const SubscribeProperty(
      this.currentUser, this.phoneNum, this.servicesSelected);
  @override
  _SubscribePropertyState createState() => _SubscribePropertyState();
}

class _SubscribePropertyState extends State<SubscribeProperty> {
  Razorpay razorpay;
  double totalPrice;
  var items = ['Bangalore', 'Chennai', 'Hyderabad'];
  var yearsItems = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

  @override
  void initState() {
    super.initState();

    razorpay = new Razorpay();

    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerPaymentFailure);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);

    totalPrice = 0.0;
    getYears(yearsItems[0]);
    getCity(items[0]);
  }

  @override
  void dispose() {
    super.dispose();
    razorpay.clear();
  }

  void openCheckout() {
    var options = {
      "key": "rzp_test_iN0mm4sTh9A0YI",
      "amount": totalPrice * 100,
      "name": "BE App",
      "description": "Payment for the subscribed services",
      "prefill": {
        "contact": widget.phoneNum,
        "email": widget.currentUser.email
      },
      "external": {
        "wallets": ["paytm"]
      }
    };

    try {
      razorpay.open(options);
    } catch (e) {
      print(e.toString());
      debugPrint(e);
    }
  }

  void handlerPaymentSuccess(PaymentSuccessResponse response) {
    addSubscriptionDetails(response);
    print("Payment success");
    Toast.show("Payment success, paymentId: " + response.paymentId, context);
    Navigator.of(context).push(
      MaterialPageRoute<void>(
          builder: (_) => Home(widget.currentUser, widget.phoneNum)),
    );
  }

  void handlerPaymentFailure(PaymentFailureResponse response) {
    print("Payment error");
    Toast.show(
        "Payment error." + response.code.toString() + " - " + response.message,
        context);
  }

  void handlerExternalWallet(ExternalWalletResponse response) {
    print("External Wallet");
    Toast.show("External Wallet: " + response.walletName, context);
  }

  String propertyAddress, city, country;
  int area, years;

  getProperyAddress(propertyAddress) {
    this.propertyAddress = propertyAddress;
  }

  getCity(city) {
    this.city = city;
  }

  getCountry(country) {
    this.country = country;
  }

  getArea(area) {
    this.area = area;
  }

  getYears(years) {
    this.years = years;
  }

  addSubscriptionDetails(PaymentSuccessResponse response) {
    DocumentReference ds = FirebaseFirestore.instance
        .collection('users')
        .doc(widget.currentUser.email);

    Map<String, dynamic> subscription = {
      'subscriptionDate': DateTime.now(),
      'propertyAddress': propertyAddress,
      'City': city,
      'Area': area,
      'noYears': years,
      'PropertyType': 'Regular',
      'paymentId': response.paymentId,
      'orderId': response.orderId,
      'signature': response.signature,
      'services' : [
        widget.servicesSelected[vigilance]? "Vigilance" : "",
        widget.servicesSelected[cleaning]? "Cleaning" : "",
        widget.servicesSelected[fencing]? "Fencing" : "",
        widget.servicesSelected[compound]? "Compound wall" : "",
        widget.servicesSelected[ec_khatha]? "EC / Khatha" : "",
        widget.servicesSelected[rent]? "Rent" : "",
      ],
    };

    ds.collection('subscriptions').add(subscription).whenComplete(() {
      Text("Subscription Added");
      print("Subcription added..!");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 27.0, top: 10, right: 27),
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 27.0, top: 10, right: 27),
                    child: FocusedMenuHolder(
                      menuWidth: MediaQuery.of(context).size.width * 0.50,
                      blurSize: 5.0,
                      menuItemExtent: 45,
                      menuBoxDecoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius:
                              BorderRadius.all(Radius.circular(15.0))),
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
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginPage()));
                            }),
                        FocusedMenuItem(
                            title: Text("Edit user info"),
                            trailingIcon: Icon(Icons.edit),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => UserRegistration(
                                          widget.currentUser,
                                          widget.phoneNum)));
                            }),
                      ],
                      onPressed: () {},
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
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10, top: 10.0),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Text(
                              'Selected Services',
                              style: TextStyle(
                                  fontFamily: 'CircularStd-Bold',
                                  fontSize: 20,
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
                      ],
                    ),
                  ),
                  widget.servicesSelected[0] ? selectedService(0) : Container(),
                  widget.servicesSelected[1] ? selectedService(1) : Container(),
                  widget.servicesSelected[2] ? selectedService(2) : Container(),
                  widget.servicesSelected[3] ? selectedService(3) : Container(),
                  widget.servicesSelected[4] ? selectedService(4) : Container(),
                  widget.servicesSelected[5] ? selectedService(5) : Container(),
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Provide Property Details',
                              style: TextStyle(
                                  fontFamily: 'CircularStd-Bold',
                                  fontSize: 20,
                                  color: Color(0xff000000)),
                            ),
                            Container(
                                width: 220,
                                child: Divider(
                                  thickness: 3,
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
                                  color: Colors.black,
                                ),
                                keyboardType: TextInputType.streetAddress,
                                decoration: new InputDecoration(
                                  hintText: 'Enter Property Address',
                                  hintStyle: TextStyle(
                                    fontFamily: 'CircularStd-Book',
                                    fontSize: 16,
                                    color: Color(0xffA2A2A2),
                                  ),
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                ),
                                onChanged: (String propertyAddress) {
                                  getProperyAddress(propertyAddress);
                                },
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
              padding: const EdgeInsets.only(right: 300, top: 15),
              child: Text(
                'City',
                style: TextStyle(
                    fontFamily: 'CircularStd-Bold',
                    fontSize: 17,
                    color: Color(0xff000000)),
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
                  child: Container(
                    height: 60,
                    width: 250,
                    child: DropdownButton<String>(
                      value: city,
                      icon: Icon(Icons.arrow_downward, size: 24),
                      elevation: 16,
                      style: TextStyle(color: Colors.black, fontSize: 18),
                      onChanged: (String newValue) {
                        setState(() {
                          getCity(newValue);
                        });
                      },
                      items:
                          items.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 300, top: 15),
              child: Text(
                'Area',
                style: TextStyle(
                    fontFamily: 'CircularStd-Bold',
                    fontSize: 17,
                    color: Color(0xff000000)),
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
                            onChanged: (String sqft) {
                              getArea(num.tryParse(sqft));
                              updateTotalPrice();
                            },
                            style: TextStyle(
                                fontFamily: 'CircularStd-Book',
                                fontSize: 16,
                                color: Colors.black),
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9]')),
                            ],
                            decoration: new InputDecoration(
                              hintText: 'Enter Area size',
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
            widget.servicesSelected[vigilance]
                ? (Column(children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 27.0, right: 27, top: 15),
                      child: Row(
                        children: [
                          Column(
                            children: [
                              Text(
                                'Number of Years to Subscribe',
                                style: TextStyle(
                                    fontFamily: 'CircularStd-Bold',
                                    fontSize: 17,
                                    color: Color(0xff000000)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 27.0, right: 27, top: 5),
                      child: Container(
                        alignment: AlignmentDirectional(0.0, 0.0),
                        height: 60,
                        //width: double.infinity,
                        decoration: BoxDecoration(
                          color: Color(0xffF1F1F1).withOpacity(1),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: DropdownButton<int>(
                          value: years,
                          icon: Icon(Icons.arrow_downward, size: 24),
                          elevation: 16,
                          style: TextStyle(color: Colors.black, fontSize: 18),
                          onChanged: (int newValue) {
                            setState(() {
                              getYears(newValue);
                            });
                          },
                          items: yearsItems
                              .map<DropdownMenuItem<int>>((int value) {
                            return DropdownMenuItem<int>(
                              value: value,
                              child: Text(value.toString()),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ]))
                : Container(),
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
                        'Total Price',
                        style: TextStyle(
                            fontFamily: 'CircularStd-Medium',
                            fontSize: 20,
                            color: Color(0xffFFFFFF)),
                      ),
                      Text(
                        '\u{20B9} ' + totalPrice.toString(),
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
                openCheckout();
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
                          'Checkout',
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

  void updateTotalPrice() {
    double t_total = 0;

    t_total = t_total +
        ((widget.servicesSelected[vigilance])
            ? (BEServicesCharges[vigilance] * area * years)
            : 0);
    t_total = t_total +
        ((widget.servicesSelected[cleaning])
            ? (BEServicesCharges[cleaning] * area)
            : 0);
    t_total = t_total +
        ((widget.servicesSelected[fencing])
            ? (BEServicesCharges[fencing] * area)
            : 0);
    t_total = t_total +
        ((widget.servicesSelected[compound])
            ? (BEServicesCharges[compound] * area)
            : 0);
    t_total = t_total +
        ((widget.servicesSelected[ec_khatha])
            ? (BEServicesCharges[ec_khatha] * area)
            : 0);
    t_total = t_total +
        ((widget.servicesSelected[rent])
            ? (BEServicesCharges[rent] * area)
            : 0);

    print('Total price .. ' + t_total.toString());
    setState(() {
      totalPrice = t_total.toDouble();
    });
    print('Total price .... ' + totalPrice.toString());
    return;
  }

  Padding selectedService(int index) {
    print('select services test..');
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        children: [
          Image.asset('assets/images/Path 64.png'),
          SizedBox(
            width: 15,
          ),
          Expanded(
              child: Text(
            BEServices[index],
            style: TextStyle(
                fontFamily: 'CircularStd-Book',
                fontSize: 15,
                color: Color(0xff000000)),
          )),
        ],
      ),
    );
  }
}
