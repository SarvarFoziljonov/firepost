import 'package:firepost/pages/home_page.dart';
import 'package:firepost/pages/signin_page.dart';
import 'package:firepost/pages/signup_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: SignInPage(),
      routes: {
        SignInPage.id: (context) => SignInPage (),
        HomePage.id: (context) => HomePage (),
        SignUpPage.id: (context) => SignUpPage (),

      },
    );
  }
}

