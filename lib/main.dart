import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_chat/screens/login.dart';
import 'package:my_chat/screens/settings.dart';
import 'package:my_chat/screens/splash_screen.dart';
import 'package:my_chat/screens/home_screen.dart';
import 'package:my_chat/settings/editname.dart';
import 'package:my_chat/settings/terms_conditions.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isAndroid) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyBjD0j_yoH5rp5SYZrbBkW6S6RKCGdSYPg",
        appId: "1:351851098778:android:297a620cc7e24f36e7a523",
        messagingSenderId: "351851098778",
        projectId: "mychat-43a59",
        storageBucket: "mychat-43a59.appspot.com",
        authDomain: "mychat-43a59.firebaseapp.com",
        measurementId: "G-8CWKV80T10",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = Locale('en'); // Default locale

  void _changeLanguage(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: Splash(),
      routes: {
        '/login': (context) => LoginPage(),
        '/home': (context) => HomeScreen(),
        '/settings': (context) => SettingsScreen(changeLanguage: _changeLanguage),
        '/editName': (context) => EditNameScreen(),
        '/termsAndConditions': (context) => TermsAndConditionsScreen(),
      },
      locale: _locale,
      supportedLocales: [Locale('en'), Locale('es')], // Add supported locales
      localizationsDelegates: [
        // Your localization delegates here
      ],
    );
  }
}
