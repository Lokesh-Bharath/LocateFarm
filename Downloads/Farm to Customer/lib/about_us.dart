import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class AboutPage extends StatefulWidget {
  AboutPage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  int _counter = 0;

  openSite(String url)
  async {
    if (await canLaunch(url)) {
      await launch(
        url,
        universalLinksOnly: true,
      );
    } else {
      throw 'There was a problem to open the url: $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(AppLocalizations.of(context).aboutus),
          centerTitle: true,
          actions: [

          ],
        ),
        body: Container(
            // color: Colors.green[100],
            padding: EdgeInsets.all(16),
            child:SingleChildScrollView(
              child: Column(
                children : [
                  Padding(padding: EdgeInsets.fromLTRB(0,16,0,16), child: Center(child : CircleAvatar(backgroundColor: Colors.green,radius: 84,child:CircleAvatar(backgroundImage : AssetImage('images/clg.jpeg'),radius: 80,)))),
                  Padding(padding: EdgeInsets.fromLTRB(0,16,0,16),child: Text(AppLocalizations.of(context).aboutusp1,style: TextStyle(fontSize: 16)) ,),
                  Padding(padding: EdgeInsets.fromLTRB(0,0,0,16), child:Text(AppLocalizations.of(context).aboutusp2,style: TextStyle(fontSize: 16)),),
                  Padding(padding: EdgeInsets.fromLTRB(0,0,0,16), child:Text(AppLocalizations.of(context).aboutusp3,style: TextStyle(fontSize: 16))),
                  Padding(padding: EdgeInsets.fromLTRB(16,16,16,12), child: Container(height: 2,color: Colors.grey,)),
                  Padding(padding: EdgeInsets.fromLTRB(0,0,0,16), child: Center(child: Text(AppLocalizations.of(context).image),), ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                    child : Row(
                      children: [Container(child: Padding(padding: EdgeInsets.fromLTRB(0,0,20,16),child: Container(height: 180,width: 280,child : Image.asset('images/clg.jpeg',fit: BoxFit.fill) ),) ),
                        Container(child: Padding(padding: EdgeInsets.fromLTRB(0,0,20,16),child: Container(height: 180,width: 280,child : Image.asset('images/clg.jpeg',fit: BoxFit.fill,)))),
                        Container(child: Padding(padding: EdgeInsets.fromLTRB(0,0,0,16),child: Container(height: 180,width: 280,child : Image.asset('images/clg.jpeg',fit: BoxFit.fill,)))),],
                    ),
                  ),
                  Padding(padding: EdgeInsets.fromLTRB(16,16,16,12), child: Container(height: 2,color: Colors.grey,)),
                  Padding(padding: EdgeInsets.fromLTRB(0,0,0,16), child: Center(child: Text(AppLocalizations.of(context).followus),), ),
                  Row(
                    children: [Expanded(flex : 2,child: Padding(padding: EdgeInsets.fromLTRB(0,0,0,16),child: Container(height: 30,width: 30))),
                      Expanded(flex : 1,child: Padding(padding: EdgeInsets.fromLTRB(0,0,0,16),child: Container(height: 35,width: 35,child: GestureDetector(onTap: () => openSite("https://www.youtube.com/channel/UCMVmpd4gFZjhK5ImX6y4nww"),child : Image.asset('images/Youtube.jpeg',) ),) )),
                      Expanded(flex : 1,child: Padding(padding: EdgeInsets.fromLTRB(0,0,0,16),child: Container(height: 30,width: 30,child: GestureDetector(onTap: () => openSite("https://www.instagram.com/locate_farm/"),child : Image.asset('images/Instagram.jpeg',),)))),
                      Expanded(flex : 2,child: Padding(padding: EdgeInsets.fromLTRB(0,0,0,16),child: Container(height: 30,width: 30) ))],
                  )

                ],
              ),
            )


        )
    );
  }
}
