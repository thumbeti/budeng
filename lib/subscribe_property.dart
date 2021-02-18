import 'dart:math';

import 'package:budeng/constants/colors.dart';
import 'package:budeng/home.dart';
import 'package:budeng/sign_in.dart';
import 'package:budeng/user_registration.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:budeng/constants/service_tasks.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:mailer/smtp_server/gmail.dart';
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
  final _formKey = GlobalKey<FormState>();
  Razorpay razorpay;
  double totalPrice;
  double priceInPaise;
  var items = ['Bangalore', 'Chennai', 'Hyderabad'];
  var yearsItems = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  List<String> selectedServicesStr = [];

  @override
  void initState() {
    super.initState();

    razorpay = new Razorpay();

    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerPaymentFailure);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);

    totalPrice = 0.0;
    priceInPaise = 0.0;
    getYears(yearsItems[0]);
    getCity(items[0]);

    if (widget.servicesSelected[vigilance])
      selectedServicesStr.add("Vigilance");
    if (widget.servicesSelected[cleaning]) selectedServicesStr.add("Cleaning");
    if (widget.servicesSelected[fencing]) selectedServicesStr.add("Fencing");
    if (widget.servicesSelected[compound])
      selectedServicesStr.add("Compound wall");
    if (widget.servicesSelected[ec_khatha])
      selectedServicesStr.add("EC / Khatha");
    if (widget.servicesSelected[rent]) selectedServicesStr.add("Rent");
  }

  @override
  void dispose() {
    super.dispose();
    razorpay.clear();
  }

  void openCheckout() {
    setState(() {
      int fac = pow(10, 2);
      priceInPaise = (totalPrice * 100 * fac).round() / fac;
    });

    var options = {
      "key": "rzp_test_iN0mm4sTh9A0YI",
      "amount": priceInPaise,
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
      print('Amount: ' + priceInPaise.toString());
      razorpay.open(options);
    } catch (e) {
      print(e.toString());
      debugPrint(e);
    }
  }

  void handlerPaymentSuccess(PaymentSuccessResponse response) {
    print("Payment success");
    Toast.show("Payment success, paymentId: " + response.paymentId, context);
    addSubscriptionDetails(response);
    setState(() {
      getPaymentId(response.paymentId);
    });
    Toast.show("Sending Email...", context);
    sendEmail();
    //sendEmail_2();
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

  sendEmail() async {
    String username = 'budgetengineers1980@gmail.com';
    String password = 'Zaq1@wsx';

    final smtpServer = gmail(username, password);
    // Use the SmtpServer class to configure an SMTP server:
    // final smtpServer = SmtpServer('smtp.domain.com');
    // See the named arguments of SmtpServer for further configuration
    // options.

    // Create our message.
    final message = Message()
      ..from = Address(username, 'Budget Engineers')
      ..recipients.add(widget.currentUser.email)
      ..ccRecipients.addAll(['budgetengineers1980@gmail.com'])
      ..bccRecipients.add(Address('thumbeti@gmail.com'))
      ..subject = 'Thanks for connecting Budget Engineers :: ${DateTime.now()}'
      ..html = "<h3>Hi ${widget.currentUser.displayName},</h3>\n"
          "<p>Your property is subscribed."
          "<br><br>   Address: ${propertyAddress},"
          "<br>   Subscribed for: ${years} years,"
          "<br>   Subscribed services: ${selectedServicesStr}."
          "<br>   PaymentId: ${paymentId}"
          "<br><br>"
          "Thanks,<br>Budget Engineers team.</p>";

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
    } on MailerException catch (e) {
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
  }

  sendEmail_2() async {
    String username = 'budgetengineers1980@gmail.com';
    String password = 'Zaq1@wsx';

    //final smtpServer = gmail(username, password);
    SmtpServer smtpServer;

    // Use the SmtpServer class to configure an SMTP server:
    // final smtpServer = SmtpServer('smtp.domain.com');
    // See the named arguments of SmtpServer for further configuration
    // options.

    // Create our message.
    final message = Message()
      ..from = Address(username, 'Budget Engineers attempt 2')
      ..recipients.add(widget.currentUser.email)
      ..ccRecipients.addAll(['budgetengineers1980@gmail.com'])
      ..bccRecipients.add(Address('thumbeti@gmail.com'))
      ..subject = 'Thanks for connecting Budget Engineers :: ${DateTime.now()}'
      ..html = "<h3>Hi ${widget.currentUser.displayName},</h3>\n"
          "<p>Your property is subscribed."
          "<br><br>   Address: ${propertyAddress},"
          "<br>   Subscribed for: ${years} years,"
          "<br>   Subscribed services: ${selectedServicesStr}."
          "<br>   PaymentId: ${paymentId}"
          "<br><br>"
          "Thanks,<br>Budget Engineers team.</p>";

    try {
      // Setting up Google SignIn
      final googleSignIn = GoogleSignIn.standard(scopes: [
        'email',
        'https://www.googleapis.com/auth/gmail.send'
      ]);
      // Signing in
      final account = await googleSignIn.signIn();

      if (account == null) {
        // User didn't authorize
        return;
      }

      final auth = await account.authentication;

      // Creating SMTP server from the access token
      smtpServer = gmailXoauth2(auth.accessToken);

      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
    } on MailerException catch (e) {
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
  }

  String propertyAddress, city, pinCode, country;
  int area, years;
  String paymentId;
  var expectingRent;

  getProperyAddress(propertyAddress) {
    this.propertyAddress = propertyAddress;
  }

  getCity(city) {
    this.city = city;
  }

  getPinCode(pinCode) {
    this.pinCode = pinCode;
  }

  getCountry(country) {
    this.country = country;
  }

  getArea(area) {
    this.area = area;
  }

  getExpectedRent(expectingRent) {
    this.expectingRent = expectingRent;
  }

  getYears(years) {
    this.years = years;
  }

  getPaymentId(paymentId) {
    this.paymentId = paymentId;
  }

  addSubscriptionDetails(PaymentSuccessResponse response) {
    DocumentReference ds = FirebaseFirestore.instance
        .collection('users')
        .doc(widget.currentUser.email);

    Map<String, dynamic> subscription = {
      'subscriptionDate': DateTime.now(),
      'propertyAddress': propertyAddress,
      'City': city,
      'PINCode': pinCode,
      'Area': area,
      'Monthly expecting rent': expectingRent,
      'noYears': years,
      'PropertyType': 'Regular',
      'paymentId': response.paymentId,
      'orderId': response.orderId,
      'signature': response.signature,
      'services': selectedServicesStr,
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
          child: Builder(
            builder: (context) => Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 27.0, top: 10, right: 27),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 27.0, top: 10, right: 27),
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
                                            builder: (context) =>
                                                UserRegistration(
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
                        widget.servicesSelected[0]
                            ? selectedService(0)
                            : Container(),
                        widget.servicesSelected[1]
                            ? selectedService(1)
                            : Container(),
                        widget.servicesSelected[2]
                            ? selectedService(2)
                            : Container(),
                        widget.servicesSelected[3]
                            ? selectedService(3)
                            : Container(),
                        widget.servicesSelected[4]
                            ? selectedService(4)
                            : Container(),
                        widget.servicesSelected[5]
                            ? selectedService(5)
                            : Container(),
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
                  //Address
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 27.0, right: 27, top: 9),
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
                    padding:
                        const EdgeInsets.only(left: 27.0, right: 27, top: 5),
                    child: Container(
                      height: 80,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Color(0xffF1F1F1).withOpacity(1),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 8.0, right: 8, top: 12),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Container(
                                height: 70,
                                width: 250,
                                child: TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter property address';
                                    }
                                    return null;
                                  },
                                  style: TextStyle(
                                    fontFamily: 'CircularStd-Book',
                                    fontSize: 20,
                                    color: Colors.black,
                                  ),
                                  keyboardType: TextInputType.streetAddress,
                                  decoration: new InputDecoration(
                                    hintText: 'Enter Property Address',
                                    hintStyle: TextStyle(
                                      fontFamily: 'CircularStd-Book',
                                      fontSize: 20,
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
                      ),
                    ),
                  ),
                  //City
                  Column(children: [
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
                      padding:
                          const EdgeInsets.only(left: 27.0, right: 200, top: 5),
                      child: Container(
                        height: 60,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Color(0xffF1F1F1).withOpacity(1),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, right: 8, top: 2),
                          child: Container(
                            height: 60,
                            width: 250,
                            child: DropdownButton<String>(
                              value: city,
                              icon: Icon(Icons.arrow_downward, size: 24),
                              elevation: 16,
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18),
                              onChanged: (String newValue) {
                                setState(() {
                                  getCity(newValue);
                                });
                              },
                              items: items.map<DropdownMenuItem<String>>(
                                  (String value) {
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
                  ]),

                  //Pincode
                  Column(children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 250, top: 15),
                      child: Text(
                        'PIN code',
                        style: TextStyle(
                            fontFamily: 'CircularStd-Bold',
                            fontSize: 17,
                            color: Color(0xff000000)),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 27.0, right: 200, top: 5),
                      child: Container(
                        height: 60,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Color(0xffF1F1F1).withOpacity(1),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, right: 8, top: 12),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Container(
                                  height: 70,
                                  width: 120,
                                  child: TextFormField(
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter PIN';
                                      }
                                      return null;
                                    },
                                    maxLines: 1,
                                    //maxLength: 6,
                                    inputFormatters: [
                                      new LengthLimitingTextInputFormatter(6),// for mobile
                                    ],
                                    style: TextStyle(
                                      fontFamily: 'CircularStd-Book',
                                      fontSize: 20,
                                      color: Colors.black,
                                    ),
                                    keyboardType: TextInputType.number,
                                    decoration: new InputDecoration(
                                      hintText: 'PIN code',
                                      hintStyle: TextStyle(
                                        fontFamily: 'CircularStd-Book',
                                        fontSize: 15,
                                        color: Color(0xffA2A2A2),
                                      ),
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                    ),
                                    onChanged: (String pinCode) {
                                      getPinCode(pinCode);
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ]),
                  //Area
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
                    padding:
                        const EdgeInsets.only(left: 27.0, right: 100, top: 5),
                    child: Container(
                      height: 60,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Color(0xffF1F1F1).withOpacity(1),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 8.0, right: 8, top: 2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Center(
                              child: Container(
                                height: 60,
                                width: 200,
                                child: TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter Area size';
                                    }
                                    return null;
                                  },
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
                            padding: const EdgeInsets.only(
                                left: 27.0, right: 27, top: 15),
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
                            padding: const EdgeInsets.only(
                                left: 27.0, right: 200, top: 5),
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
                                style: TextStyle(
                                    color: Colors.black, fontSize: 18),
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
                  //Expecting rent
                  widget.servicesSelected[rent]
                      ? Column(children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 27.0, right: 27, top: 15),
                            child: Row(
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      'Monthly expecting Rent',
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
                      const EdgeInsets.only(left: 27.0, right: 150, top: 5),
                      child: Container(
                        height: 60,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Color(0xffF1F1F1).withOpacity(1),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding:
                          const EdgeInsets.only(left: 8.0, right: 3, top: 2),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                '\u{20B9}',
                                style: TextStyle(
                                    fontFamily: 'CircularStd-Book',
                                    fontSize: 25,
                                    color: Color(0xff000000)),
                              ),
                              SizedBox(width: 5,),
                              Center(
                                child: Container(
                                  height: 60,
                                  width: 150,
                                  child: TextFormField(
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter expecting rent';
                                      }
                                      return null;
                                    },
                                    onChanged: (String expectingRentStr) {
                                      getExpectedRent(num.tryParse(expectingRentStr));
                                      updateTotalPrice();
                                    },
                                    style: TextStyle(
                                        fontFamily: 'CircularStd-Book',
                                        fontSize: 16,
                                        color: Colors.black),
                                    keyboardType: TextInputType.number,
                                    decoration: new InputDecoration(
                                      hintText: 'Amount',
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
                        ),
                      ),
                    )
                        ])
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
                              '\u{20B9} ' + totalPrice.toStringAsFixed(2),
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
                      if (_formKey.currentState.validate()) {
                        openCheckout();
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                          right: 35, left: 35, bottom: 10.0),
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
              ),
            ),
          ),
        ),
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
        ((widget.servicesSelected[rent]) && area != null && expectingRent != null
            ? (BEServicesCharges[rent] * area) + expectingRent / 2
            : 0);

    print('Total price t_total .. ' + t_total.toString());
    setState(() {
      int fac = pow(10, 2);
      totalPrice = (t_total * fac).round() / fac;
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
