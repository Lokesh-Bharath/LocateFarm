import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomerPage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => _CustomerPageState();
}
class StringValidator {
  static String validate(String value) {
    return value.isEmpty ? 'This field can\'t be empty' : null;
  }
}
class _CustomerPageState extends State<CustomerPage> {



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child:Text(AppLocalizations.of(context).buyerszone,
              style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),
            ),
          ),
          backgroundColor: Colors.amber,
        ),
        backgroundColor: Colors.amber[50],
        body:  Container(
          margin: EdgeInsets.fromLTRB(16, 0, 16, 0) ,
          child: SingleChildScrollView(
            child:Column(
              children: [
                Container(
                  child:Column(
                    children: [
                      InkWell(
                        child: Container(
                            key: Key('vegatables'),
                            child:Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children:[
                                  Container(
                                    child:Text(AppLocalizations.of(context).vegetables,style :TextStyle(fontSize: 20,fontStyle: FontStyle.italic)),
                                    padding: EdgeInsets.fromLTRB(0, 16, 0, 8),
                                  ),
                                  Container(
                                    height: 200,
                                    // width: double.infinity,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage("images/vegatables.jpeg"),
                                            fit: BoxFit.fill)),
                                  )
                                ]
                            )

                        ),
                        onTap: () {
                          // farmerdetailspage('Vegetables');
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => FarmerDetailsPage('Vegetables')),
                          );
                          print("Click event on Vegetables");
                        },
                      ),
                      InkWell(
                        child: Container(
                            key: Key('fruits'),
                            child:Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children:[
                                  Container(
                                    child:Text(AppLocalizations.of(context).fruits,style :TextStyle(fontSize: 20,fontStyle: FontStyle.italic)),
                                    padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                                  ),
                                  Container(
                                    height: 200,
                                    // width: double.infinity,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage("images/fruits.jpeg"),
                                            fit: BoxFit.fill)),
                                  )
                                ]
                            )

                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => FarmerDetailsPage('Fruits')),
                          );
                          print("Click event on Fruits");
                        },
                      ),
                      InkWell(
                        child: Container(
                            key: Key('rice'),
                            child:Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children:[
                                  Container(
                                    child:Text(AppLocalizations.of(context).rice,style :TextStyle(fontSize: 20,fontStyle: FontStyle.italic)),
                                    padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                                  ),
                                  Container(
                                    height: 200,
                                    // width: double.infinity,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage("images/Rice.jpeg"),
                                            fit: BoxFit.fill)),
                                  )
                                ]
                            )

                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => FarmerDetailsPage('Rice')),
                          );
                          print("Click event on Rice");
                        },
                      ),
                      InkWell(
                        child: Container(
                            key: Key('pulses'),
                            child:Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children:[
                                  Container(
                                    child: Text(AppLocalizations.of(context).pulses,style :TextStyle(fontSize: 20,fontStyle: FontStyle.italic)),
                                    padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                                  ),
                                  Container(
                                    height: 200,
                                    // width: double.infinity,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage("images/pulses.jpeg"),
                                            fit: BoxFit.fill)),
                                  )
                                ]
                            )

                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => FarmerDetailsPage('Pulses')),
                          );
                          print("Click event on Pulses");
                        },
                      )
                    ],
                  ),
                )


              ],
            ),


          ),
        )
    );
  }

}

class Details{

  String address,mobilenumber,name,items;
  Details(this.address,this.mobilenumber,this.name,this.items);

}
class FarmerDetailsPage extends StatefulWidget{
  FarmerDetailsPage(this.item);
  String item;
  @override
  State<StatefulWidget> createState() => _FarmerDetailsPageState(this.item);
}

class _FarmerDetailsPageState extends State<FarmerDetailsPage> {
  final databaseRef = FirebaseDatabase.instance.reference();
  _FarmerDetailsPageState(this.item);
  String item;

  List<Details> det= [];
  @override
  void initState()
  {
    super.initState();
    databaseRef.child('user').child('${item}').once().then((DataSnapshot snapshot) {
       var keys = snapshot.value.keys;
       var data = snapshot.value;

       det.clear();

       for(var individualkey in keys)
         {
           Details details = new Details(
             data[individualkey]['Address'],
             data[individualkey]['Mobile Number'],
             data[individualkey]['Name'],
             data[individualkey]['Items'],
           );
           det.add(details);
         }
       setState(() {
         print('Length: ${det.length}');
       });
    });
  }
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).farmerdetails),
      ),
      body: new Container(
        child: det.length == 0 ? new Center(child:Text(AppLocalizations.of(context).farmernotavailable) ) : new ListView.builder(
          itemCount: det.length,
          itemBuilder: (_,index){
            return CardUI(det[index].address,det[index].mobilenumber,det[index].name,det[index].items,index);
          },
        ),
      ),
    );
  }
  _launchUrl(String phoneNumber) async {
    try {
      if (phoneNumber != null) {
        phoneNumber = phoneNumber.replaceAll(" ", "");
        if (await UrlLauncher.canLaunch(phoneNumber)) {
          await UrlLauncher.launch(phoneNumber);
        }
      }
    } catch(e){
      print('Cannot launch url');
    }
  }
  Widget CardUI(String address,String mobilenumber,String name,String items,int index) {
    return Column(
      children: [
        Divider(height: 10.0),
        ListTile(
          contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          horizontalTitleGap: 10,
          title: Text(
            '${name}',
            style: TextStyle(
              fontSize: 22.0,
              color: Colors.deepOrangeAccent,
            ),
          ),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${mobilenumber}',
                    style: new TextStyle(
                      color: Colors.blue,
                      fontSize: 18.0,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  Container(
                    width: 250,
                    child: Text(
                      '${items}',
                      style: new TextStyle(
                        fontSize: 18.0,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  )

                ],
              ),
              // Expanded(
              //   child: SizedBox(
              //
              //   ),
              //   flex: 1,
              // ),

            ],
          ),

          leading: Column(
            children: [
              Padding(padding: EdgeInsets.all(10.0)),
              CircleAvatar(
                backgroundColor: Colors.blueAccent,
                radius: 15.0,
                child: Text(
                  '${index + 1}',
                  style: TextStyle(
                    fontSize: 22.0,
                    color: Colors.white,
                  ),
                ),
              ),
              // IconButton(
              //     icon: const Icon(Icons.remove_circle_outline),
              //     // onPressed: () => _deleteNote(context, items[position], position)
              //        ),
            ],
          ),
         trailing:  IconButton(
           icon: const Icon(Icons.phone),
           color: Colors.blue,
           onPressed: () => _launchUrl('tel:${mobilenumber}'),
         ),
          // RaisedButton(
          //   onPressed: () => _launchUrl('tel:${mobilenumber}'),
          //   child: Text('Call'),
          //   textColor: Colors.black,
          //   padding: const EdgeInsets.all(5.0),
          // ),,
        ),
      ],
    );
  }
}

