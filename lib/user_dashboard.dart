import 'package:budeng/be_services.dart';
import 'package:flutter/material.dart';
import 'package:budeng/login_page.dart';
import 'package:budeng/sign_in.dart';

class UserDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      persistentFooterButtons: <Widget>[
        new IconButton(
          icon: new Icon(Icons.work),
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute<void>(builder: (_) => BEServices()),
          ),
        ),
      ],
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
            children: <Widget>[              SizedBox(height: 40,),
              Center(
                child: Text("Dashboard Page", style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepOrangeAccent
                ),),
              ),
              SizedBox(height: 10,),
              Center(
                child: Text("Property #1", style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),),
              ),
              SizedBox(height: 10,),
              Text(
                'Property # 1 details.. \n more details what it includes...',
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
                    image: AssetImage("assets/BE_logo.PNG"),
                    //fit: BoxFit.fill,
                  ),
                ),
              ),
              Text(
                'More details in less than 5 seconds video',
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.normal),
              ),
            ],
          ),
        ),
      ),
    );
  }
}