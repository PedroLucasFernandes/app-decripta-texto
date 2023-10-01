import 'package:app_decripta_texto/pages/cifradecesar.dart';
import 'package:app_decripta_texto/pages/cifradevigenere.dart';
import 'package:app_decripta_texto/pages/homepage.dart';
import 'package:flutter/material.dart';

void main () => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/homepage",
      routes: {
        "/cifradecesar" : (context) => CesarPage(),
        "/cifradevigenere" : (context) => VigenerePage(),
      },
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}