import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokeapp/presentation/splash/splash_screen.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(
    const ProviderScope(child: PokeApp()),
  );
}

class PokeApp extends StatelessWidget {
  const PokeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
        systemNavigationBarColor: Colors.black,
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark));

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      theme: ThemeData.light().copyWith(
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
      ),
    );
  }
}
