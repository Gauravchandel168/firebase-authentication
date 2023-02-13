import 'package:flutter/material.dart';

import '../../firebase_options.dart';
import 'bolc_and_repository_provider.dart';
import 'package:firebase_core/firebase_core.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const BlocAndRepositoryProvider());
}