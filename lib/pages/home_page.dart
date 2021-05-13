import 'package:firepost/pages/signin_page.dart';
import 'package:firepost/services/auth_servise.dart';
import 'package:flutter/material.dart';
class HomePage extends StatefulWidget {
  static final String id = "home_page";
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Center(
        child: FlatButton(
          onPressed: (){
          AuthService.signOutUser(context);
          },
          color: Colors.blue,
          child: Text("Logout", style: TextStyle(color: Colors.white),),
        )
      ) ,
    );
  }
}
