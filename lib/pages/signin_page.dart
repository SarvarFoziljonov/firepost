import 'package:firebase_auth/firebase_auth.dart';
import 'package:firepost/pages/home_page.dart';
import 'package:firepost/pages/signup_page.dart';
import 'package:firepost/services/auth_servise.dart';
import 'package:firepost/services/prefs_service.dart';
import 'package:firepost/services/utils_service.dart';
import 'package:flutter/material.dart';
class SignInPage extends StatefulWidget {
  static final String id = "signin_page";
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  var isLoading = false;

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  _doLogin () {
    String email = emailController.text.toString().trim();
    String password = passwordController.text.toString().trim();
    if(email.isEmpty || password.isEmpty) return;
    setState(() {
      isLoading = true;
    });

    AuthService.signInUser(context, email, password).then((firebaseUser) => {
      _getFirebaseUser(firebaseUser),
    });
    Navigator.pushReplacementNamed(context, HomePage.id);
  }
  _getFirebaseUser (FirebaseUser firebaseUser) async{
    setState(() {
      isLoading = false;
    });
    if (firebaseUser !=null){
      await Prefs.saveUserId(firebaseUser.uid);
      Navigator.pushReplacementNamed(context, HomePage.id);
    } else {
      Utils.fireToast("Check you email or password");
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                    onPressed: _doLogin,
                    color: Colors.blue,
                    child: Text("Sign In", style: TextStyle(color: Colors.white)),
                  ),
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("Don't have an account?", style: TextStyle(color: Colors.black),),
                    SizedBox(width: 10,),
                    GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, SignUpPage.id);
                      },
                      child: Text("Sign Up", style: TextStyle(color: Colors.black),),

                    ),
                  ],
                )
              ],
            ),
          ),
          isLoading?
          Center(
            child: CircularProgressIndicator(),
          ): SizedBox.shrink(),
        ],
      )
    );
  }
}

