import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'WebPage.dart';
// import 'app_localisations.dart';

class HomePage extends StatefulWidget{
  
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // var appLanguage = Provider.of<AppLanguage>(context);

    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child:Text(AppLocalizations.of(context).homepage,
              style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),
            ),
          ),
          backgroundColor: Colors.red,
        ),
        body: Container(
            padding: EdgeInsets.all(16),
            child:SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children : [
                  Padding(padding: EdgeInsets.fromLTRB(0,8,0,8),child: Image.asset('images/home_page.jpeg')),
                  Padding(padding: EdgeInsets.fromLTRB(0,16,0,16),child: Text(AppLocalizations.of(context).hometext1,style: TextStyle(fontSize: 16)) ,),
                  Padding(padding: EdgeInsets.fromLTRB(0,4,0,16),child: Center(child: ElevatedButton(child: Text(AppLocalizations.of(context).website),onPressed: () {  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => WebPage())
                  ); },style: ElevatedButton.styleFrom(primary: Colors.red),))),
                  Padding(padding: EdgeInsets.fromLTRB(0,8,0,16), child: Center(child:Text(AppLocalizations.of(context).directions,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold))),),
                  Padding( padding: EdgeInsets.fromLTRB(0,4,0,12), child:Text(AppLocalizations.of(context).instructions,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w300,fontStyle: FontStyle.italic)),),
                  Padding(padding: EdgeInsets.fromLTRB(0,0,0,16), child:Text(AppLocalizations.of(context).instructionshead+"\n1)"+ AppLocalizations.of(context).instructionshead1+"\n2)" +AppLocalizations.of(context).instructionshead2+"\n3"+AppLocalizations.of(context).instructionshead3,style: TextStyle(fontSize: 16))),
                  Padding( padding: EdgeInsets.fromLTRB(0,8,0,12), child:Text(AppLocalizations.of(context).instructionsb,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w300,fontStyle: FontStyle.italic)),),
                  Padding(padding: EdgeInsets.fromLTRB(0,0,0,16), child:Text(AppLocalizations.of(context).instructionsheadb+"\n1)"+AppLocalizations.of(context).instructionsheadb1+"\n2)"+AppLocalizations.of(context).instructionsheadb2+"\n3)"+AppLocalizations.of(context).instructionsheadb3,style: TextStyle(fontSize: 16))),
                  Padding(padding: EdgeInsets.fromLTRB(0,12,0,0), child:Center(child:Text(AppLocalizations.of(context).moreinf,textAlign: TextAlign.center,))),
                  Padding(padding: EdgeInsets.fromLTRB(16,16,16,12), child: Container(height: 2,color: Colors.grey,))
                ],
              ),
            )


        ),
      backgroundColor: Colors.red[50],
    );
  }
  
}
