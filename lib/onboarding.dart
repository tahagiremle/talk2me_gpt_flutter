import 'package:flutter/material.dart';
import 'package:talk2me_gpt_flutter/home_page.dart';

class Onboarding extends StatelessWidget {
  const Onboarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Text(
                  "Your AI Assistant",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[700]),
                ),
                const SizedBox(width: 16),
                const Text(
                    "Using this application, you can ask the AI assistant questions and receive detailed articles.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ))
              ],
            ),
            const SizedBox(height: 32),
            Image.asset('assets/onboard.png'),
            const SizedBox(height: 32),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomePage(),
                    ),
                    (route) => false,
                  );
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[700],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding:
                        const EdgeInsets.symmetric(vertical: 16, horizontal: 32)),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Continue',
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(height: 8),
                    Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
