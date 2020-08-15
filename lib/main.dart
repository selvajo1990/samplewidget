import 'package:flutter/material.dart';
import 'package:widget_samples/screen/_stream.dart';
import 'package:provider/provider.dart';
import '_logindecider.dart';
import 'package:overlay_support/overlay_support.dart';

void main() {
  runApp(MyApp());
}

// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(home: MainPage());
//   }
// }

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return OverlaySupport(
      child: StreamProvider<GetUserState>.value(
          value: AuthService().onAuthStateChanged,
          builder: (context, snapshot) {
            return MaterialApp(
              home: LoginDecider(),
            );
          }),
    );
  }
}
