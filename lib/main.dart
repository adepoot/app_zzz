import 'package:app_zzz/utils/colors.dart';
import 'package:app_zzz/widget/navigation_drawer.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'De Zwarte Zeverzwijnen',
      theme: ThemeData(primarySwatch: primaryBlack),
      home: const MyHomePage(title: 'De Zwarte Zeverzwijnen'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(title)),
        body: const Center(
          child: Text(
            'Welcome to the home page of \n\'De Zwarte Zeverzwijnen\'',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18.0),
          ),
        ),
        drawer: const NavigationDrawerWidget());
  }
}
