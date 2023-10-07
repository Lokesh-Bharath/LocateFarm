import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

abstract class BaseAuth {
  Future<String> signInWithEmailAndPassword(String email, String password);
  Future<String> createUserWithEmailAndPassword(String email, String password);
  Future<String> currentUser();
  Future<void> signOut();
  Future<void> storedata(String name,String email,String number,String userID);
  Future<void> storefarmerdata(String name,String number,String address,String aadhaar,String passbook,String selling_items,String item);
  Future<String> currentUser1();
}

class Auth implements BaseAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final databaseRef = FirebaseDatabase.instance.reference();

  @override
  Future<String> signInWithEmailAndPassword(String email,
      String password) async {
    final UserCredential user = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return user.user.uid;
  }

  @override
  Future<String> createUserWithEmailAndPassword(String email,
      String password) async {
    final UserCredential user = await _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);
    return user.user.uid;
  }

  @override
  Future<String> currentUser() async {
    final User user = await _firebaseAuth.currentUser;
    return user?.uid;
  }

  @override
  Future<String> currentUser1() async {
    final User user = await _firebaseAuth.currentUser;
    final uid = user.uid;
    String k;
    databaseRef.child('all').child('${user?.uid}').once().then((
        DataSnapshot snapshot) {
      k = snapshot.value;
    });
    // while(k==null)
    //   {
    //
    //   };
    return k;
  }

  @override
  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }

  @override
  Future<void> storedata(String name, String email,String number, String userId) async {
    databaseRef.child('account').child('${userId}').child('Name').set(
        '${name}');
    databaseRef.child('account').child('${userId}').child('Email ID').set(
        '${email}');
    databaseRef.child('account').child('${userId}').child('Mobile Number').set(
        '${number}');
  }

  @override
  Future<void> storefarmerdata(String name,String number,String address,String aadhaar,String passbook,String selling_items,String item) async {
    final User user = await _firebaseAuth.currentUser;
    databaseRef.child('admin').child('${item}').child('${user.uid}').child('Name').set(
        '${name}');
    databaseRef.child('admin').child('${item}').child('${user.uid}').child('Mobile Number').set(
        '${number}');
    databaseRef.child('admin').child('${item}').child('${user.uid}').child('Address').set(
        '${address}');
    databaseRef.child('admin').child('${item}').child('${user.uid}').child('Aadhaar').set(
        '${aadhaar}');
    databaseRef.child('admin').child('${item}').child('${user.uid}').child('Pattadhar Passbook Number').set(
        '${passbook}');
    databaseRef.child('admin').child('${item}').child('${user.uid}').child('Items').set(
        '${selling_items}');
  }

}