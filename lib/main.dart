import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:talk2me_gpt_flutter/onboarding.dart';
import 'package:talk2me_gpt_flutter/theme_notifier.dart';
import 'package:talk2me_gpt_flutter/themes.dart';


Future<void> main() async {
  await dotenv.load(fileName: "assets/.env");

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);

    return MaterialApp(
      theme: lightMode,
      darkTheme: darkMode,
      themeMode: themeMode,
      home: const Onboarding(),
    );
  }
}
