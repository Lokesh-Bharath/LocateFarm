import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appproj1/about_us.dart';
import 'package:flutter_appproj1/customer_page.dart';
import 'package:flutter_appproj1/home_page.dart';
import 'package:flutter_appproj1/l10n/l10n.dart';
import 'package:flutter_appproj1/main.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'auth.dart';
import 'auth_provider.dart';
import 'farmers_page.dart';
import 'locale_provider.dart';
import 'profile.dart';

class Details{

  String address,mobilenumber,name,items,aadhaar,passbook_number,UID,item_type;
  Details(this.address,this.mobilenumber,this.name,this.items,this.aadhaar,this.passbook_number,this.UID,this.item_type);

}
class AccountHomePage extends StatefulWidget {
  AccountHomePage({this.onSignedOut,this.k});
  final VoidCallback onSignedOut;
  String k="welcome";
  @override
  State<StatefulWidget> createState() => _AccountHomePageState();
}
class _AccountHomePageState extends State<AccountHomePage> {

  String b="Hello",d="";
  int _currentIndex = 1;
  final databaseRef = FirebaseDatabase.instance.reference();
  final FirebaseAuth auth = FirebaseAuth.instance;
  User user;
  final List<Widget> _children = [
    FarmerPage(),
    HomePage(),
    CustomerPage()
  ];
  List<Details> det= [];
  var item=['Vegetables','Fruits','Rice','Pulses'];

  void initState() {
    super.initState();
    user = auth.currentUser;
    if (user.uid == 'eY1PErivJzaDL9LCmXJRDZ7hTZQ2') {
      det.clear();
      for(var i=0;i<4;i++) {
        databaseRef.child('admin').child('${item[i]}').once().then((
            DataSnapshot snapshot) {
          var keys = snapshot.value.keys;
          var data = snapshot.value;

          for (var individualkey in keys) {
            Details details = new Details(
              data[individualkey]['Address'],
              data[individualkey]['Mobile Number'],
              data[individualkey]['Name'],
              data[individualkey]['Items'],
              data[individualkey]['Aadhaar'],
              data[individualkey]['Pattadhar Passbook Number'],
              individualkey,
                item[i]
            );
            det.add(details);
          }
          setState(() {
            print('Length: ${det.length}');
          });
        });
      }
    }
    else
      {
        databaseRef.child('account').child('${user.uid}').child('Name').once().then((DataSnapshot snapshot){
          setState(() {
            d=snapshot.value;
            b ='Hello,'+d;
          });// refresh1();
        });

      }
  }

  Future<void> _signOut(BuildContext context) async {
    try {
      final BaseAuth auth = AuthProvider.of(context).auth;
      await auth.signOut();
      widget.onSignedOut();
    } catch (e) {
      print(e);
    }
  }
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Future<void> add_to_customer(String name,String number,String address,String aadhaar,String passbook,String selling_items,String item,String UID) async {
    databaseRef.child('user').child('${item}').child('${UID}').child('Name').set(
        '${name}');
    databaseRef.child('user').child('${item}').child('${UID}').child('Mobile Number').set(
        '${number}');
    databaseRef.child('user').child('${item}').child('${UID}').child('Address').set(
        '${address}');
    databaseRef.child('user').child('${item}').child('${UID}').child('Aadhaar').set(
        '${aadhaar}');
    databaseRef.child('user').child('${item}').child('${UID}').child('Pattadhar Passbook Number').set(
        '${passbook}');
    databaseRef.child('user').child('${item}').child('${UID}').child('Items').set(
        '${selling_items}');
  }

  Widget CardUI(String address,String mobilenumber,String name,String items,String aadhaar,String passbook_number,int index) {
        return Card(
          margin: EdgeInsets.fromLTRB(16,0,16,0),
          child: Container(
            padding: EdgeInsets.all(16),
            child :Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child:  Container(
                        child: Text('Name',style: TextStyle(fontSize: 20),),
                        padding:EdgeInsets.fromLTRB(4, 4, 4, 4) ,
                      ),

                    flex: 1,
                  ),
                  Expanded(
                      child:Container(
                            child: Text('$name',style: TextStyle(fontSize: 20),),
                            padding:EdgeInsets.fromLTRB(4, 4, 4, 4) ,
                         ),
                    flex: 1,
                  )
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child:  Container(
                      child: Text('Mobile Number',style: TextStyle(fontSize: 20),),
                      padding:EdgeInsets.fromLTRB(4, 4, 4, 4) ,
                    ),

                    flex: 1,
                  ),
                  Expanded(
                    child:Container(
                      child: Text('$mobilenumber',style: TextStyle(fontSize: 20),),
                      padding:EdgeInsets.fromLTRB(4, 4, 4, 4) ,
                    ),
                    flex: 1,
                  )
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child:  Container(
                      child: Text('Address',style: TextStyle(fontSize: 20),),
                      padding:EdgeInsets.fromLTRB(4, 4, 4, 4) ,
                    ),

                    flex: 1,
                  ),
                  Expanded(
                    child:Container(
                      child: Text('$address',style: TextStyle(fontSize: 20),),
                      padding:EdgeInsets.fromLTRB(4, 4, 4, 4) ,
                    ),
                    flex: 1,
                  )
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child:  Container(
                      child: Text('Aadhaar',style: TextStyle(fontSize: 20),),
                      padding:EdgeInsets.fromLTRB(4, 4, 4, 4) ,
                    ),

                    flex: 1,
                  ),
                  Expanded(
                    child:Container(
                      child: Text('$aadhaar',style: TextStyle(fontSize: 20),),
                      padding:EdgeInsets.fromLTRB(4, 4, 4, 4) ,
                    ),
                    flex: 1,
                  )
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child:  Container(
                      child: Text('Passbook Number',style: TextStyle(fontSize: 20),),
                      padding:EdgeInsets.fromLTRB(4, 4, 4, 4) ,
                    ),

                    flex: 1,
                  ),
                  Expanded(
                    child:Container(
                      child: Text('$passbook_number',style: TextStyle(fontSize: 20),),
                      padding:EdgeInsets.fromLTRB(4, 4, 4, 4) ,
                    ),
                    flex: 1,
                  )
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child:  Container(
                      child: Text('Items',style: TextStyle(fontSize: 20),),
                      padding:EdgeInsets.fromLTRB(4, 4, 4, 4) ,
                    ),

                    flex: 1,
                  ),
                  Expanded(
                    child:Container(
                      child: Text('$items',style: TextStyle(fontSize: 20),),
                      padding:EdgeInsets.fromLTRB(4, 4, 4, 4) ,
                    ),
                    flex: 1,
                  )
                ],
              ),
             Container(
               padding: EdgeInsets.fromLTRB(4,12,4,4),
               child: Center(
                      child:Text('Swipe right to approve and left to reject',style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12
                      ),)
                    ),
             )
            ]
          ),
          )
        );
  }

  @override
  Widget build(BuildContext context) {
    // var appLanguage = Provider.of<AppLanguage>(context);
    final provider = Provider.of<LocaleProvider>(context);
    final locale = provider.locale ?? Locale('en');
    if(user.uid == 'eY1PErivJzaDL9LCmXJRDZ7hTZQ2')
      {
        return Scaffold(
          appBar: AppBar(
            title: Text('Hello,Admin'),
            actions: <Widget>[
              Padding(
                  padding: EdgeInsets.all(8.0),
                  child :DropdownButtonHideUnderline(
                    child: DropdownButton(
                      // value: locale,
                      icon: Icon(Icons.language,color: Colors.white,size: 26,),
                      items: L10n.all.map(
                            (locale) {
                          final flag = L10n.getFlag(locale.languageCode);

                          return DropdownMenuItem(
                            child: Center(
                              child: Text(
                                flag,
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                            value: locale,
                            onTap: () {
                              final provider =
                              Provider.of<LocaleProvider>(context, listen: false);

                              provider.setLocale(locale);
                            },
                          );
                        },
                      ).toList(),
                      onChanged: (_) {},
                    ),
                  )
              ),
              FlatButton(
                child: Text(AppLocalizations.of(context).logout, style: TextStyle(fontSize: 17.0, color: Colors.white)),
                onPressed: () => _signOut(context),
              )
            ],
          ),
          body: new Container(
            color: Colors.cyan[50],
            padding: EdgeInsets.fromLTRB(0, 16, 0,0),
            child: det.length == 0 ? new Center(child:Text('No farmers available') ) : new ListView.separated(
                  itemCount: det.length,
                  separatorBuilder: (BuildContext context, int index) => Divider(),
                  itemBuilder: (BuildContext context, int index) {
                    final item = det[index];
                    return Dismissible(
                      // Each Dismissible must contain a Key. Keys allow Flutter to
                      // uniquely identify widgets.
                      key: Key(item.aadhaar+item.items),
                      // Provide a function that tells the app
                      // what to do after an item has been swiped away.
                      onDismissed: (Direction) {
                        // Remove the item from the data source.
                        print('${det[index].UID}');
                        // print('${item.UID}');
                        if(Direction == DismissDirection.startToEnd)
                        {
                          add_to_customer(det[index].name,det[index].mobilenumber,det[index].address,det[index].aadhaar,det[index].passbook_number,det[index].items,det[index].item_type,det[index].UID);
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(content: Text("Approved")));
                        }
                        else
                        {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(content: Text("Rejected")));
                        }
                        databaseRef.child('admin').child('${det[index].item_type}').child('${det[index].UID}').remove();
                        setState(() {
                          det.removeAt(index);
                        });
                        // Then show a snackbar.

                      },
                      child:CardUI(det[index].address,det[index].mobilenumber,det[index].name,det[index].items,det[index].aadhaar,det[index].passbook_number,index)
                    );
                  },
            ),
          )
        );
      }
    else
      {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            leading: IconButton(
              icon: Image.asset('images/Locate_Farm.jpeg'),
              onPressed: () {},
            ),
            title: Text('${b}',style: TextStyle(color: Colors.black),),
            actions: <Widget>[
              Padding(
                  padding: EdgeInsets.all(8.0),
                  child :DropdownButtonHideUnderline(
                    child: DropdownButton(
                      // value: locale,
                      icon: Icon(Icons.language,color: Colors.black,size: 26,),
                      items: L10n.all.map(
                            (locale) {
                          final flag = L10n.getFlag(locale.languageCode);

                          return DropdownMenuItem(
                            child: Center(
                              child: Text(
                                flag,
                                style: TextStyle(fontSize: 20,color: Colors.black),
                              ),
                            ),
                            value: locale,
                            onTap: () {
                              final provider =
                              Provider.of<LocaleProvider>(context, listen: false);

                              provider.setLocale(locale);
                            },
                          );
                        },
                      ).toList(),
                      onChanged: (_) {},
                    ),
                  )
              ),
              const SizedBox(height: 32),
              FlatButton(
                child: Text('Logout', style: TextStyle(fontSize: 17.0, color: Colors.black)),
                onPressed: () => _signOut(context),
              )
            ],
          ),
          drawer: Drawer(
            // Add a ListView to the drawer. This ensures the user can scroll
            // through the options in the drawer if there isn't enough vertical
            // space to fit everything.
            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      image: DecorationImage(
                          image: AssetImage("images/Ramkumar Radhakrishnan, Wikimedia-1569929663.jpeg"),
                          fit: BoxFit.fill
                      )
                  ),
                ),
                ListTile(
                  title: Text(AppLocalizations.of(context).home),
                  leading: Icon( Icons.home),
                  onTap: () {
                    Navigator.pop(context);
                    // Update the state of the app
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
                    // ...
                    // Then close the drawer
                  },
                ),
                ListTile(
                  title: Text(AppLocalizations.of(context).farmer),
                  leading: Icon(Icons.shopping_basket),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FarmerPage()),
                    );
                  },
                ),
                ListTile(
                  title: Text(AppLocalizations.of(context).customer),
                  leading: Icon(Icons.person),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CustomerPage()),
                    );
                  },
                ),

                ListTile(
                  title: Text(AppLocalizations.of(context).profile),
                  leading: Icon(Icons.verified),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProfilePage()),
                    );
                  },
                ),
                ListTile(
                  title: Text(AppLocalizations.of(context).aboutus),
                  leading: Icon(Icons.info),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AboutPage())
                    );
                  },
                ),
              ],
            ),
          ),
          body: _children[_currentIndex], // new
          bottomNavigationBar: BottomNavigationBar(
            onTap: onTabTapped, // new
            currentIndex: _currentIndex, // new
            items: [
              new BottomNavigationBarItem(
                icon: Icon(Icons.shopping_basket),
                title: Text(AppLocalizations.of(context).farmer),
              ),
              new BottomNavigationBarItem(
                icon: Icon(Icons.home),
                title: Text(AppLocalizations.of(context).home),
              ),
              new BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  title: Text(AppLocalizations.of(context).customer)
              )
            ],
          ),
        );
      }

  }

}
