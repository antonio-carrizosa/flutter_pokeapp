import 'package:flutter/material.dart';

final theme = ThemeData.light().copyWith(
    scaffoldBackgroundColor: Colors.grey.shade200,
    primaryColor: const Color(0XFF0A285F),
    errorColor: const Color(0XFFFB1B1B),
    disabledColor: const Color(0XFFDFDFDF),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: Color(0XFF0A285F),
      titleTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: Color(0XFFFFCC00),
      linearTrackColor: Color(0XFF0A285F),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color(0XFFFFCC00),
      elevation: 0,
    ));
