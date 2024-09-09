import 'package:flutter/material.dart';
import 'package:talk2me_gpt_flutter/onboarding.dart';
import 'package:talk2me_gpt_flutter/themes.dart';

import 'home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightMode,
      darkTheme: darkMode,
      home: Onboarding(),
    );
  }
}
