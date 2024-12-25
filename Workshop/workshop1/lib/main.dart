import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:workshop3/firebase_options.dart';


import 'package:workshop3/otp.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(
    MaterialApp(home: MyApp1(),));
}