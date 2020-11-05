import 'package:brew_crew/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user object based on firebase user object
  Users _userFromFireBAseUser(User user){
    return user!=null ? Users(uid: user.uid) : null ;

  }
  //Auth change user stream
  Stream<Users> get user{
    return _auth.onAuthStateChanged
        //.map((User user) => _userFromFireBAseUser(user));
        .map(_userFromFireBAseUser);
  }

  //sign in anonymously
  Future signInAnon() async{
    try{
      UserCredential result= await _auth.signInAnonymously();
      User user = result.user;
      return _userFromFireBAseUser(user);

    }catch(e){
      print(e.toString());
      return null;
    }
  }

  // sign in with email

  //register with email

  // sign out
  Future signOut() async{
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }

}