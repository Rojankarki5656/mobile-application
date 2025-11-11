import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lab2nd/firebase_options.dart';
import 'package:lab2nd/pages/chatapp/conversations.dart';
import 'package:lab2nd/pages/demo/view.dart';
import 'package:lab2nd/pages/maps/maps.dart';
import 'package:lab2nd/pages/pages/dashboard.dart';
import 'package:lab2nd/pages/chatapp/chats.dart';
import 'package:lab2nd/payments/esewa_payment.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await  Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo PCPS',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: dashboard(),
    );
  }
}