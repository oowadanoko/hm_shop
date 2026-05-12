import 'package:flutter/material.dart';
import 'package:hm_shop/pages/login/index.dart';
import 'package:hm_shop/pages/main/index.dart';

Widget getRootWidget() {
  return MaterialApp(initialRoute: "/", routes: getRootRotes());
}

Map<String, Widget Function(BuildContext)> getRootRotes() {
  return {"/": (context) => MainPage(), "/login": (context) => LoginPage()};
}
