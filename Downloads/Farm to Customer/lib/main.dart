import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appproj1/l10n/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
// import 'app_localisations.dart';
import 'auth.dart';
import 'auth_provider.dart';
import 'root_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'locale_provider.dart';
// void main() => runApp(MyApp());
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // AppLanguage appLanguage = AppLanguage();
  // await appLanguage.fetchLocale();
  runApp(MyApp(
    // appLanguage: appLanguage
  ));
}

class MyApp extends StatelessWidget {

  // static void setLocale(BuildContext context,Locale locale){
  //   _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
  //   state.setLocale(locale);
  // }
  // final AppLanguage appLanguage;
  //
  // MyApp({this.appLanguage});

//   @override
//   _MyAppState createState() => _MyAppState(this.appLanguage);
// }
//
// class _MyAppState extends State<MyApp> {
//
//   final AppLanguage appLanguage;
//   _MyAppState({this.appLanguage});
  static final String title = 'Localization';

  @override
  Widget build(BuildContext context) =>
      ChangeNotifierProvider(
          create: (context) => LocaleProvider(),
          builder: (context, child) {
            final provider = Provider.of<LocaleProvider>(context);
            // TODO: implement build
            return AuthProvider(
              auth: Auth(),
              child: MaterialApp(
                title: 'Flutter login demo',
                locale: provider.locale,
                supportedLocales: L10n.all,
                // These delegates make sure that the localization data for the proper language is loaded
                localizationsDelegates: [
                  // THIS CLASS WILL BE ADDED LATER
                  // A class which loads the translations from JSON files
                  // DemoLocalization.delegate,
                  AppLocalizations.delegate,
                  // Built-in localization of basic text for Material widgets
                  GlobalMaterialLocalizations.delegate,
                  // Built-in localization for text direction LTR/RTL
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate
                ],
                // Returns a locale which will be used by the app
                // localeResolutionCallback: (deviceLocale, supportedLocales) {
                //   for (var locale in supportedLocales) {
                //     if (locale.languageCode == deviceLocale.languageCode &&
                //         locale.countryCode == deviceLocale.countryCode) {
                //       return deviceLocale;
                //     }
                //   }
                //   return supportedLocales.first;
                // },
                theme: ThemeData(
                  primarySwatch: Colors.blue,
                ),
                home: RootPage(),
              ),
            );
          }

      );
}

  // Locale _locale = null;
  //
  // void setLocale(Locale locale)
  // {
  //   setState(() {
  //     _locale= locale;
  //   });
  // }
  //
  // @override
  // void didChangeDependencies() {
  //   // TODO: implement didChangeDependencies
  //   getLocale().then((locale){
  //     setState(() {
  //       this._locale = locale;
  //     });
  //   });
  //   super.didChangeDependencies();


  // @override
  // Widget build(BuildContext context) {
    // if(_locale == null){
    //   return AuthProvider(
    //     auth: Auth(),
    //     child: Container(
    //   child: Center(
    //   child: CircularProgressIndicator(),
    // ),
    // ),
    //   );
    //
    // }
    // else {
    //     return AuthProvider(
    //       auth: Auth(),
    //       child: MaterialApp(
    //         title: 'Flutter login demo',
    //         // locale: _locale,
    //         supportedLocales: [
    //           Locale('en', 'US'),
    //           Locale('te', 'IN'),
    //           Locale('hi', 'IN'),
    //         ],
    //         // These delegates make sure that the localization data for the proper language is loaded
    //         localizationsDelegates: [
    //           // THIS CLASS WILL BE ADDED LATER
    //           // A class which loads the translations from JSON files
    //           // DemoLocalization.delegate,
    //           AppLocalizations.delegate,
    //           // Built-in localization of basic text for Material widgets
    //           GlobalMaterialLocalizations.delegate,
    //           // Built-in localization for text direction LTR/RTL
    //           GlobalWidgetsLocalizations.delegate,
    //           GlobalCupertinoLocalizations.delegate
    //         ],
    //         // Returns a locale which will be used by the app
    //         // localeResolutionCallback: (deviceLocale, supportedLocales) {
    //         //   for (var locale in supportedLocales) {
    //         //     if (locale.languageCode == deviceLocale.languageCode &&
    //         //         locale.countryCode == deviceLocale.countryCode) {
    //         //       return deviceLocale;
    //         //     }
    //         //   }
    //         //   return supportedLocales.first;
    //         // },
    //         theme: ThemeData(
    //           primarySwatch: Colors.blue,
    //         ),
    //         home: RootPage(),
    //       ),
    //     );
    //   }
    // // }
    //
    //
