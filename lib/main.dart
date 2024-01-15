import 'package:flutter/material.dart';
import 'package:flutter_stay/login/login.dart';
import 'package:flutter_stay/page/home_page.dart';
import 'package:flutter_stay/page/bookmark_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_stay/page/splash.dart';
// Correct the import statement

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen(), // Correct the class name here
      routes: {
        '/home': (context) => HomePage(),
        '/bookmark': (context) => BookmarkPage(),
        '/login': (context) => LoginPage(),
      },
    );
  }
}
