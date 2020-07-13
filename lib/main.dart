import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sistema_lanchonete/splash_screen.dart';

const red = Colors.red;
const green = Colors.green;
var brown = Colors.brown[800];
const white = Colors.white;
var grey = Colors.grey[300];
var yellow = Colors.yellow[800];

void main() => runApp(GetMaterialApp(
  debugShowCheckedModeBanner: false,
  theme: ThemeData(
    accentColor: Colors.white,
    primaryColor: Colors.brown[800],

  ),
  home: SplashScreen()//Home(),
));