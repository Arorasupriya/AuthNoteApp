import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:login_note_fb/firebase_options.dart';
import 'package:login_note_fb/screens/drawer.dart';
import 'package:login_note_fb/screens/sign_up.dart';
import 'package:login_note_fb/screens/splash.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ANote App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  SignUp(),
    );
  }
}



