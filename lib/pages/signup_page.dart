import 'package:firebase_auth/firebase_auth.dart';
import 'package:firepost/pages/home_page.dart';
import 'package:firepost/pages/signin_page.dart';
import 'package:firepost/services/auth_servise.dart';
import 'package:firepost/services/prefs_service.dart';
import 'package:firepost/services/utils_service.dart';
import 'package:flutter/material.dart';
class SignUpPage extends StatefulWidget {
  static final String id = "signup_page";
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();

  _doSignUp (){
    String name = nameController.text.toString().trim();
    String email = emailController.text.toString().trim();
    String password = passwordController.text.toString().trim();
    if(name.isEmpty||email.isEmpty||password.isEmpty) return
    AuthService.signUpUser(context, name, email, password).then((firebaseUser) => {
      _getFirebaseUser(firebaseUser),
    });
  }

  void _getFirebaseUser (FirebaseUser firebaseUser) async{
    if (firebaseUser !=null){
      await Prefs.saveUserId(firebaseUser.uid);
      Navigator.pushReplacementNamed(context, HomePage.id);
    } else {
      Utils.fireToast("Check your information");
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                hintText: "Fullname",
              ),
            ),
            SizedBox(height: 10,),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: "Email",
              ),
            ),
            SizedBox(height: 10,),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                hintText: "Password",
              ),
            ),
            SizedBox(height: 30,),
            Container(
              height: 45,
              width: double.infinity,
              child: FlatButton(
                onPressed: _doSignUp,
                color: Colors.blue,
                child: Text("Sign Up", style: TextStyle(color: Colors.white)),
              ),
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("Already have an account?", style: TextStyle(color: Colors.black),),
                SizedBox(width: 10,),
                GestureDetector(
                  onTap: (){
                    Navigator.pushReplacementNamed(context, SignInPage.id);
                  },
                  child: Text("Sign In", style: TextStyle(color: Colors.black),),

                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
