import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
class Auth
{
  final _auth=FirebaseAuth.instance;
  //this method to sign up
  Future<UserCredential>signUp(String email , String password) async
  {
    final usercredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    return usercredential;
  }
  //this method to sign in
  Future<UserCredential>signIn(String email , String password) async
  {
    final usercredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
    return usercredential;
  }
  //this method to reset password of user
  Future<void>resetPassword(String email) async
  {
    final usercredential = await _auth.sendPasswordResetEmail(email: email);
    return usercredential;
  }

  //this method to get current user
  Future<UserCredential> getUser () async
  {
     await _auth.currentUser ;
  }

  //this method to sign out
  Future <void> signOut() async
  {
    await _auth.signOut();
  }


}