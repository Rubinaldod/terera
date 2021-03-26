import 'package:terera/screens/add_playlist.dart';
import 'package:terera/screens/home_screen.dart';
import 'package:terera/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:terera/screens/other_screen.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: WelcomeScreen.id,
        routes: {
          WelcomeScreen.id: (context) => WelcomeScreen(),
          HomeScreen.id: (context) => HomeScreen(),
          DishScreen.id: (context) => DishScreen(),
          OtherScreen.id: (context) => OtherScreen(),
        });
  }
}
