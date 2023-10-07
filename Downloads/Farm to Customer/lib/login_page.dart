import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'auth.dart';
import 'auth_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'l10n/l10n.dart';
import 'locale_provider.dart';

class EmailFieldValidator {
  static String validate(String value) {
    return value.isEmpty ? 'Email can\'t be empty' : null;
  }
}

class PasswordFieldValidator {
  static String validate(String value) {
    return value.isEmpty ? 'Password can\'t be empty' : null;
  }
}

class StringValidator {
  static String validate(String value) {
    return value.isEmpty ? 'This field can\'t be empty' : null;
  }
}
class LoginPage extends StatefulWidget {
  const LoginPage({this.onSignedIn});
  final VoidCallback onSignedIn;
  @override
  State<StatefulWidget> createState() => _LoginPageState();
}


enum FormType {
  login,
  register,
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String _email;
  String _create_password;
  String _number;
  String _name;
  String _confirm_password;
  FormType _formType = FormType.login;
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();

  bool validateAndSave() {
    final FormState form = formKey.currentState;
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

  Future<void> validateAndSubmit() async {
    if (validateAndSave()) {
      try {
        final BaseAuth auth = AuthProvider.of(context).auth;
        if (_formType == FormType.login) {
          final String userId = await auth.signInWithEmailAndPassword(_email, _create_password);
          print('Signed in: $userId');
        }
        else
          {
            final String userId = await auth.createUserWithEmailAndPassword(_email, _create_password);
            print('Registered farmer: $userId');
            await auth.storedata(_name,_email,_number,userId);
          }
        widget.onSignedIn();
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

  void moveToRegister() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.register;
    });
  }


  void moveToLogin() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.login;
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocaleProvider>(context);
    final locale = provider.locale ?? Locale('en');
    return Scaffold(
      floatingActionButton: Padding(
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
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      body: Stack(
        children: <Widget>[
          Opacity(opacity: 0.8,child:
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("images/Ramkumar Radhakrishnan, Wikimedia-1569929663.jpeg"),
                    fit: BoxFit.fitHeight)),
          ),
          ),
             Form(
              key: formKey,
              child: Container(
                  margin: EdgeInsets.fromLTRB(0, 150, 0, 0),
                  padding: EdgeInsets.all(16.0),
                  child : SingleChildScrollView(
                    child:new Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:
                      // buildInputs()  +
                      // <Widget>[]+
                      buildSubmitButtons(),
                    ) ,
                  )
              ),
            ),
        ],
      )

    );
  }


  List<Widget> buildSubmitButtons() {
    if (_formType == FormType.login) {
      return <Widget>[
        TextFormField(
          key: Key('email'),
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(labelText: AppLocalizations.of(context).email,labelStyle: TextStyle(color: Colors.white,fontSize: 25),enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),  ),
          validator: EmailFieldValidator.validate,
          cursorColor: Colors.blue,
          onSaved: (String value) => _email = value.trim(),
        ),
        TextFormField(
          key: Key('password'),
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(labelText: AppLocalizations.of(context).password,labelStyle :TextStyle(color: Colors.white,fontSize: 25),enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.red),),),
          obscureText: true,
          cursorColor: Colors.blue,
          validator: PasswordFieldValidator.validate,
          onSaved: (String value) => _create_password = value,
        ),
        SizedBox(height: 40),
        RaisedButton(
          key: Key('signIn'),
          child: Text(AppLocalizations.of(context).login, style: TextStyle(fontSize: 20.0)),
          onPressed: validateAndSubmit,
        ),
        FlatButton(
          child: Text(AppLocalizations.of(context).createaccount, style: TextStyle(fontSize: 20.0)),
          textColor: Colors.white,
          onPressed: moveToRegister,
        ),
      ];
    }
    else
      {
        return <Widget>[
          TextFormField(
            key: Key('name'),
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(labelText: AppLocalizations.of(context).name,labelStyle: TextStyle(color: Colors.white,fontSize: 25),enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.red),),),
            cursorColor: Colors.blue,
            validator: StringValidator.validate,
            onSaved: (String value) => _name = value ,
          ),

          TextFormField(
            key: Key('email'),
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(labelText: AppLocalizations.of(context).email,labelStyle: TextStyle(color: Colors.white,fontSize: 25),enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.red),),),
            validator: EmailFieldValidator.validate,
            cursorColor: Colors.blue,
            onSaved: (String value) => _email = value.trim(),
          ),
          TextFormField(
              key: Key('number'),
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(labelText: AppLocalizations.of(context).mobilenumber,labelStyle: TextStyle(color: Colors.white,fontSize: 25),enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.red),),),
              validator: _phoneNumberValidator,
              onSaved: (value) => _number = value.trim(),
            ),
          TextFormField(
            key: Key('createpassword'),
            controller: _pass,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(labelText: AppLocalizations.of(context).createpassword,labelStyle :TextStyle(color: Colors.white,fontSize: 25),enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.red),),),
            obscureText: true,
            cursorColor: Colors.blue,
            validator: PasswordFieldValidator.validate,
            onSaved: (String value) => _create_password = value,
          ),
          TextFormField(
            key: Key('confirmpassword'),
            controller: _confirmPass,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(labelText: AppLocalizations.of(context).confirmpassword,labelStyle :TextStyle(color: Colors.white,fontSize: 25),enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.red),),),
            cursorColor: Colors.blue,
            obscureText: true,
            onSaved: (String value) => _confirm_password = value,
            validator:(val){
              if(val.isEmpty)
                return 'Empty';
              if(val != _pass.text)
                return 'Not Match';
              return null;
            },
          ),
          SizedBox(height: 40),
          RaisedButton(
            child: Text(AppLocalizations.of(context).createaccount, style: TextStyle(fontSize: 20.0)),
            onPressed: validateAndSubmit,
          ),
          FlatButton(
            child: Text(AppLocalizations.of(context).haveaccount, style: TextStyle(fontSize: 20.0)),
            textColor: Colors.white,
            onPressed: moveToLogin,
          ),
        ];
      }
  }
}
