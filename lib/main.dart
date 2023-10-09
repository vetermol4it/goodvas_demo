import 'package:flutter/material.dart';
import 'package:goodvas_demo/di/get_it.dart';
import 'package:goodvas_demo/features/whats_new/widget/whats_new_screen.dart';

void main() {
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WhatsNewScreen(),
    );
  }
}
