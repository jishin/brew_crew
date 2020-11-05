import 'package:brew_crew/services/auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text("Sign into Brew Crew"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        child: RaisedButton(
          child: Text('sign in anon'),
          onPressed: ()async{

           dynamic result = await _auth.signInAnon();

           if(result==null){
             print('error signing in');
           }
           else{
             print('signed in');
             print(result.uid);
           }

          },
        ),
      ),
    );
  }
}
