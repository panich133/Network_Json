import 'package:flutter/material.dart';
import 'package:my_authen_jsonfeed/home.dart';
import 'package:my_authen_jsonfeed/login.dart';
import 'package:my_authen_jsonfeed/services/AuthService.dart';

Future main() async { WidgetsFlutterBinding.ensureInitialized();
  AuthService authService = AuthService();

  Widget page = Login();

  final _route = <String, WidgetBuilder>{
    '/login': (context) => Login(),
    '/home': (context) => Home(),
  };

  if (await authService.isLogin()) {
    page = Home();
  }
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Feed json',
      home: page,
      routes: _route,
    ),
  );
}

