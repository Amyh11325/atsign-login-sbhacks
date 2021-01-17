import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Welcome',
        home: Scaffold(
          appBar: AppBar(
            title: Text('Welcome'),
            centerTitle: true,
          ),
          body: Center(
            child: RaisedButton(
              onPressed: (){print("clicked");},
              child: Text("Login"),
              color: Colors.purple,
            ),
          ),
        )
    );

    _login() async {
      FocusScope.of(context).unfocus();
      setState(() {
        showSpinner = true;
      });
      if (atSign != null) {
        String jsonData = clientSdkService.encryptKeyPairs(atSign);
        clientSdkService.onboard().then((value) async {
          if (await checkIfCorrectAtSign()) {
            Navigator.pushReplacementNamed(context, SecondScreen.id);
          } else {
            setState(() {
              showSpinner = false;
              displayErrorMessage = true;
            });
          }
        }).catchError((error) async {
          await clientSdkService.authenticate(atSign,
              jsonData: jsonData, decryptKey: at_demo_data.aesKeyMap[atSign]);
          Navigator.pushReplacementNamed(context, SecondScreen.id);
        });
      }
  }


}