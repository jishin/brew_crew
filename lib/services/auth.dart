import 'package:brew_crew/model/user.dart';
import 'package:brew_crew/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user object based on firebase user object
  Users _userFromFireBAseUser(User user){
    return user!=null ? Users(uid: user.uid) : null ;

  }
  //Auth change user stream
  Stream<Users> get user{
    return _auth.authStateChanges()
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
  Future signInWithEmailAndPassword(String email, String password)async{
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      return _userFromFireBAseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //register with email
  Future registerWithEmailAndPassword(String email, String password)async{
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User user = result.user;

      //create a new document for the user with the uid
      await DatabaseServices(uid: user.uid).updateUserData("0", "new crew member", 100);

      return _userFromFireBAseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }





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