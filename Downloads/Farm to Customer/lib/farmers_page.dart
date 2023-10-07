import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'auth.dart';
import 'auth_provider.dart';

class FarmerPage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => _FarmerPageState();
}

class StringValidator {
  static String validate(String value) {
    return value.isEmpty ? 'This field can\'t be empty' : null;
  }
}
class PassbookValidator {
  static String validate(String value) {
    Pattern pattern =
        r'^\d{13}$';
    // r'^[2-9]{1}[0-9]{3}\\s[0-9]{4}\\s[0-9]{4}$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Passbook Number';
    else
      return null;
  }
}
class _FarmerPageState extends State<FarmerPage> {

  String _farmer_name;
  String _farmer_number;
  String _farmer_address;
  String _farmer_aadhaar;
  String _farmer_passbook;
  String _farmer_selling_items;
  final _formKey = GlobalKey<FormState>();

  bool validateAndSave() {
    final FormState form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  String _phoneNumberValidator(String value) {
    Pattern pattern =
    r'^(\+\d{1,2}\s)?\(?\d{3}\)?[\s.-]?\d{3}[\s.-]?\d{4}$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Phone Number';
    else
      return null;
  }
  String _aadhaarNumberValidator(String value) {
    Pattern pattern =
    r'^\d{4}\s\d{4}\s\d{4}$';
    // r'^[2-9]{1}[0-9]{3}\\s[0-9]{4}\\s[0-9]{4}$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Aadhaar Number';
    else
      return null;
  }

  Future<void> validateAndSubmit(String item) async {
    final FormState form = _formKey.currentState;
    if (validateAndSave()) {
      try {
        final BaseAuth auth = AuthProvider.of(context).auth;
        await auth.storefarmerdata(_farmer_name,_farmer_number,_farmer_address,_farmer_aadhaar,_farmer_passbook,_farmer_selling_items,item);
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                // set your custom alert dialog here
                title: Text('AlertDialog Title'),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      Text('Successfully updated'),
                    ],
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: Text('Ok'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            });
        form.reset();
      } catch (e) {
        print('Error: $e');
        // return Alert(context: context, title: "${e.code}");
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                // set your custom alert dialog here
                title: Text('AlertDialog Title'),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      Text('${e.code}'),
                    ],
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: Text('Ok'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            });
      }
    }
  }
  void form(String item)
  {
    showDialog(
        context: context,
        // barrierDismissible: false,
        builder: (BuildContext context) {
          return  AlertDialog(
            titlePadding: EdgeInsets.zero,
            title: Container(
              height: 60,
                child: Center(
                  child: Text(AppLocalizations.of(context).fillurdetails),
                ),
                decoration: BoxDecoration(color: Colors.red[100]),
              ),
              content: SingleChildScrollView(
              child:Stack(
              overflow: Overflow.visible,
              children: <Widget>[
                Positioned(
                  right: -40.0,
                  top: -100.0,

                  child: InkResponse(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: CircleAvatar(
                      child: Icon(Icons.close),
                      backgroundColor: Colors.red,
                    ),
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextFormField(
                          key: Key('farmer_name'),
                          decoration: InputDecoration(
                            hintText: AppLocalizations.of(context).name
                          ),
                          validator: StringValidator.validate,
                          onSaved: (value) => _farmer_name = value.trim(),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextFormField(
                          key: Key('farmer_number'),
                          decoration: InputDecoration(
                              hintText: AppLocalizations.of(context).mobilenumber
                          ),
                          validator: _phoneNumberValidator,
                          onSaved: (value) => _farmer_number = value.trim(),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextFormField(
                          key: Key('farmer_address'),
                          decoration: InputDecoration(
                              hintText: AppLocalizations.of(context).address
                          ),
                          validator: StringValidator.validate,
                          onSaved: (value) => _farmer_address = value.trim(),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextFormField(
                          key: Key('farmer_aadhaar'),
                          decoration: InputDecoration(
                              hintText: AppLocalizations.of(context).aadhaar+" (XXXX XXXX XXXX)"
                          ),
                          validator: _aadhaarNumberValidator,
                          onSaved: (value) => _farmer_aadhaar = value.trim(),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextFormField(
                          key: Key('farmer_pattadhar_passbook'),
                          decoration: InputDecoration(
                              hintText: AppLocalizations.of(context).passbook
                          ),
                          validator: PassbookValidator.validate,
                          onSaved: (value) => _farmer_passbook = value.trim(),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextFormField(
                          key: Key('farmer_selling_items'),
                          decoration: InputDecoration(
                              hintText: AppLocalizations.of(context).items
                          ),
                          validator: StringValidator.validate,
                          onSaved: (value) => _farmer_selling_items = value.trim(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RaisedButton(
                          color: Colors.redAccent,
                          child: Text(AppLocalizations.of(context).submit,style: TextStyle(color: Colors.white),),
                          onPressed: (){
                            validateAndSubmit(item);
                          }
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            )
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
     return Scaffold(
       appBar: AppBar(
         title: Center(
           child:Text(AppLocalizations.of(context).sellerszone,
             style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),
           ),
         ),
         backgroundColor: Colors.orange,
       ),
       backgroundColor: Colors.orange[50],
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
                               margin: EdgeInsets.fromLTRB(0, 16, 0, 8),
                                 padding: EdgeInsets.fromLTRB(12,12,12,12),
                                 key: Key('vegatables'),
                                 decoration: BoxDecoration(color:Colors.white,
                                   borderRadius: BorderRadius.circular(10)
                                 ),
                                 child:Row(
                                     mainAxisAlignment: MainAxisAlignment.center,
                                     crossAxisAlignment: CrossAxisAlignment.center,
                                     children:[
                                       Container(
                                           margin:EdgeInsets.fromLTRB(12, 0, 0, 0),
                                           child: Center(
                                             child: Text(AppLocalizations.of(context).vegetables,style :TextStyle(fontSize: 20,fontStyle: FontStyle.italic)),
                                           ),
                                       ),
                                       Expanded(
                                         child: SizedBox(
                                           child: Center(
                                             child: Container(
                                               color: Colors.grey,
                                               height: 100,
                                               width: 2,
                                             ),
                                           ),
                                         ),
                                         flex: 1,
                                       ),
                                       Container(
                                         height: 100,
                                         width: 200,
                                         decoration: BoxDecoration(
                                             borderRadius: BorderRadius.circular(15),
                                             image: DecorationImage(
                                                 image: AssetImage("images/vegatables.jpeg"),
                                                 fit: BoxFit.fill)),
                                       )
                                     ]
                                 )

                             ),
                             onTap: () {
                               form('Vegetables');
                               print("Click event on Vegetables");
                             },
                           ),
                           InkWell(
                             child: Container(
                                 key: Key('fruits'),
                                 margin: EdgeInsets.fromLTRB(0, 16, 0, 8),
                                 padding: EdgeInsets.fromLTRB(12,12,12,12),
                                 decoration: BoxDecoration(color:Colors.white,
                                     borderRadius: BorderRadius.circular(10)
                                 ),
                                 child:Row(
                                     crossAxisAlignment: CrossAxisAlignment.center,
                                     mainAxisAlignment: MainAxisAlignment.center,
                                     children:[
                                       Container(
                                         margin:EdgeInsets.fromLTRB(12, 0, 50, 0),
                                         child:Center(
                                              child: Text(AppLocalizations.of(context).fruits,style :TextStyle(fontSize: 20,fontStyle: FontStyle.italic)),
                                         ),
                                      ),
                                       Expanded(
                                         child: SizedBox(
                                           child: Center(
                                             child: Container(
                                               color: Colors.grey,
                                               height: 100,
                                               width: 2,
                                             ),
                                           ),
                                         ),
                                         flex: 1,
                                       ),
                                       Container(
                                         height: 100,
                                         width: 200,
                                         // width: double.infinity,
                                         decoration: BoxDecoration(
                                             borderRadius: BorderRadius.circular(15),
                                             image: DecorationImage(
                                                 image: AssetImage("images/fruits.jpeg"),
                                                 fit: BoxFit.fill)),
                                       )
                                     ]
                                 )

                             ),
                             onTap: () {
                               form('Fruits');
                               print("Click event on Fruits");
                             },
                           ),
                           InkWell(
                             child: Container(
                                 key: Key('rice'),
                                 margin: EdgeInsets.fromLTRB(0, 16, 0, 8),
                                 padding: EdgeInsets.fromLTRB(12,12,12,12),
                                 decoration: BoxDecoration(color:Colors.white,
                                     borderRadius: BorderRadius.circular(10)
                                 ),
                                 child:Row(
                                     crossAxisAlignment: CrossAxisAlignment.center,
                                     mainAxisAlignment: MainAxisAlignment.center,
                                     children:[
                                       Container(
                                         child:Center(
                                                child: Text(AppLocalizations.of(context).rice,style :TextStyle(fontSize: 20,fontStyle: FontStyle.italic)),
                                         ),
                                         margin:EdgeInsets.fromLTRB(12, 0, 60, 0),
                                       ),
                                       Expanded(
                                         child: SizedBox(
                                           child: Center(
                                             child: Container(
                                               color: Colors.grey,
                                               height: 100,
                                               width: 2,
                                             ),
                                           ),
                                         ),
                                         flex: 1,
                                       ),
                                       Container(
                                         height: 100,
                                         width: 200,
                                         decoration: BoxDecoration(
                                             borderRadius: BorderRadius.circular(15),
                                             image: DecorationImage(
                                                 image: AssetImage("images/Rice.jpeg"),
                                                 fit: BoxFit.fill)),
                                       )
                                     ]
                                 )

                             ),
                             onTap: () {
                               form('Rice');
                               print("Click event on Rice");
                             },
                           ),
                           InkWell(
                             child: Container(
                                 key: Key('pulses'),
                                 margin: EdgeInsets.fromLTRB(0, 16, 0, 8),
                                 padding: EdgeInsets.fromLTRB(12,12,12,12),
                                 decoration: BoxDecoration(color:Colors.white,
                                     borderRadius: BorderRadius.circular(10)
                                 ),
                                 child:Row(
                                     crossAxisAlignment: CrossAxisAlignment.center,
                                     mainAxisAlignment: MainAxisAlignment.center,
                                     children:[
                                       Container(
                                         margin:EdgeInsets.fromLTRB(12, 0, 44, 0),
                                         child: Center(
                                               child:Text(AppLocalizations.of(context).pulses,style :TextStyle(fontSize: 20,fontStyle: FontStyle.italic)) ,
                                            ),
                                       ),
                                       Expanded(
                                         child: SizedBox(
                                           child: Center(
                                             child: Container(
                                               color: Colors.grey,
                                               height: 100,
                                               width: 2,
                                             ),
                                           ),
                                         ),
                                         flex: 1,
                                       ),
                                       Container(
                                         height: 100,
                                         width: 200,
                                         decoration: BoxDecoration(
                                             borderRadius: BorderRadius.circular(15),
                                             image: DecorationImage(
                                                 image: AssetImage("images/pulses.jpeg"),
                                                 fit: BoxFit.fill)),
                                       )
                                     ]
                                 )

                             ),
                             onTap: () {
                               form('Pulses');
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
