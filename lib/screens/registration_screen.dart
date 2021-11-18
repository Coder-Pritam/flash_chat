import 'package:flash_chat_app2/screens/chat_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat_app2/components/RoundedMaterialButton.dart';
import 'package:flash_chat_app2/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegistrationScreen extends StatefulWidget
{
  static String id = 'registration_screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {

  late String email;
  late String password;
  final _auth = FirebaseAuth.instance;
  bool showSpinner=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                onChanged: (value) {
                  email=value;
                },
                keyboardType: TextInputType.emailAddress,
                decoration: KtextFieldDecoration.copyWith(
                  hintText: 'Enter Your E-mail',
                  prefixIcon: Icon(Icons.email),
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                onChanged: (value) {
                  password=value;
                },
                obscureText: true,
                decoration: KtextFieldDecoration.copyWith(
                  hintText: 'Enter Your Password',
                  prefixIcon: Icon(Icons.vpn_key),
                ),
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(title: 'Register', colour: Colors.blueAccent, onPressed: ()async
              {
                setState(() {
                  showSpinner=true;
                });
                 try {
                   await Firebase.initializeApp();
                   final newUser = await _auth.createUserWithEmailAndPassword(
                       email: email, password: password);
                   if(newUser!=null)
                     {
                       Navigator.pushNamed(context, ChatScreen.id);
                     }
                   setState(() {
                     showSpinner=false;
                   });
                 }
                 catch(e)
                  {
                    print(e);
                  }
              }
              ),
            ],
          ),
        ),
      ),
    );
  }
}