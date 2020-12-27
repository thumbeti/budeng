import 'package:budeng/subscribe_property.dart';
import 'package:budeng/user_dashboard.dart';
import 'package:flutter/material.dart';

class BEServices extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.blue[100], Colors.blue[400]],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              SizedBox(height: 40,),
              Center(
                child: Text("Services Page", style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepOrangeAccent
                ),),
              ),
              SizedBox(height: 10,),
              Center(
                child: Text("Service #1", style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),),
              ),
              SizedBox(height: 10,),
              Text(
                'Service # 1 details.. \n more details what it includes...',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54),
              ),
              SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                alignment: Alignment.center,
                child: SizedBox(
                  height: 100.0,
                  child: Image(
                    alignment: Alignment.center,
                    // instead of image, have less than 10 secs video about this service
                    image: AssetImage("assets/BE_logo.PNG"),
                    //fit: BoxFit.fill,
                  ),
                ),
              ),
              Text(
                '  In place of above image have very small video about this service '
                    '\n  Below Have a selectable list view',
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.normal),
              ),
              SizedBox(height: 30),
              RaisedButton(
                onPressed: () => Navigator.of(context).push(
                    //MaterialPageRoute<void>(builder: (_) => SubscribeProperty()),
                    MaterialPageRoute<void>(builder: (_) => UserDashboard()),
                ),
                color: Colors.blue[800],
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Subscribe for this service',
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ),
                ),
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}