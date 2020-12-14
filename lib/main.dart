import 'package:flutter/material.dart';
import 'login_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
      routes: {
        '/LoginPage': (context)=>LoginPage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 50,),
            Center(
              child: Text("Welcome To", style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),),
            ),
            SizedBox(height: 50,),
            Container(
              padding: EdgeInsets.all(10),
              child: Image.asset('assets/BE_logo.PNG'),
            ),
            SizedBox(height: 50,),
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width*0.8,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.yellow, Colors.black],
                  stops: [0,1],
                ),
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
            ),
            SizedBox(height: 20,),
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width*0.8,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.yellow, Colors.black],
                  stops: [0,1],
                ),
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: InkWell(
                onTap: openLogin,
                child: Center(
                  child: Text("Log In", style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 25,
                  ),),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void openLogin()
  {
    Navigator.pushNamed(context, '/LoginPage');
  }
}
