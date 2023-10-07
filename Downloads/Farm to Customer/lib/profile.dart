import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfilePage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  final databaseRef = FirebaseDatabase.instance.reference();
  final FirebaseAuth auth = FirebaseAuth.instance;
  User user;
  String name="";
  String email="";
  String uid="";
  String number="";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    user = auth.currentUser;
    databaseRef.child('account').child('${user.uid}').child('Name').once().then((DataSnapshot snapshot){
      setState(() {
        name = snapshot.value;
      });
    });
    databaseRef.child('account').child('${user.uid}').child('Email ID').once().then((DataSnapshot snapshot){
      setState(() {
        email = snapshot.value;
      });
    });
    databaseRef.child('account').child('${user.uid}').child('Mobile Number').once().then((DataSnapshot snapshot){
      setState(() {
        number = snapshot.value;
      });
    });
    setState(() {
      uid = user.uid;
    });
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: profileView()// This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget profileView() {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(30, 50, 30, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(height: 50, width: 50 ,child: IconButton(icon:Icon(Icons.arrow_back_ios, size: 24,color: Colors.black54,),onPressed:() => Navigator.pop(context),), decoration: BoxDecoration(border: Border.all(color: Colors.black54), borderRadius: BorderRadius.all(Radius.circular(10))),),
              Padding(padding: EdgeInsets.fromLTRB(0,20,0,0),
              child: Center(
                child: Text(AppLocalizations.of(context).profiledetails, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              ),
        ),
              Container(height: 24,width: 24)
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0,0 ,50),
          child: Stack(
            children: <Widget>[
              CircleAvatar(
                radius: 70,
                child: ClipOval(
                  child: Icon(Icons.person,size: 100,)),
              ),
            ],
          ),
        ),
        Expanded(
           flex: 1,
            child: Container(
              height: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [Colors.black54, Color.fromRGBO(0, 41, 102, 1)]
              ),
          ),
          child:Center(
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 25, 20, 8),
                  child: Container(
                    height: 60,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(AppLocalizations.of(context).name+' : ${name}', style: TextStyle(color: Colors.white70),),
                      ),
                    ), decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)),border: Border.all(width: 1.0, color: Colors.white70)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                  child: Container(
                    height: 60,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(AppLocalizations.of(context).email+' : ${email}', style: TextStyle(color: Colors.white70),),
                      ),
                    ), decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)),border: Border.all(width: 1.0, color: Colors.white70)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                  child: Container(
                    height: 60,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(AppLocalizations.of(context).uid+' : ${uid}',
                            style: TextStyle(color: Colors.white70)
                        ),
                      ),
                    ), decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)),border: Border.all(width: 1.0, color: Colors.white70)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                  child: Container(
                    height: 60,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(AppLocalizations.of(context).mobilenumber+' : ${number}',
                            style: TextStyle(color: Colors.white70)
                        ),
                      ),
                    ), decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)),border: Border.all(width: 1.0, color: Colors.white70)),
                  ),
                ),
              ],
            ) ,
          )
        )

        )
      ],
    );
  }
}
