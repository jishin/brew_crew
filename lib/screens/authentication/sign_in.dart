import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/shared/constants.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  bool loading = false;

  //text field state
  String email = "";
  String password = "";
  String error="";

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return loading? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text("Sign into Brew Crew"),
        actions: [
          FlatButton.icon(
              onPressed: (){
                widget.toggleView();
              },
              icon: Icon(Icons.person),
              label: Text('Register'))
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 20,),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: "Email"),
                  validator: (val) => val.isEmpty ? 'Enter an email' : null,
                onChanged: (val){

                  setState(() {
                    email=val;
                  });

                },
              ),
              SizedBox(height: 20,),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: "Password"),
                validator: (val){
                  return val.length < 6 ? "Enter a password 6+ char long" : null;
                },
                obscureText: true,
                onChanged: (val){
                  setState(() {
                    password=val;
                  });
                },
              ),
              SizedBox(height: 20,),
              RaisedButton(
                color: Colors.pink[400],
                  onPressed: ()async{
                    if(_formKey.currentState.validate()){
                      setState(() {
                        loading=true;
                      });
                      //print("valid");
                      dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                      if(result==null){
                        setState(() {
                          loading=false;
                          error="Could not sign in with those credential";
                        });
                      }
                    }
                  },
                child: Text(
                    "Sign In",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: 12,),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
