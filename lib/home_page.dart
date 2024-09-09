import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:talk2me_gpt_flutter/theme_notifier.dart';
import 'message.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final TextEditingController _controller = TextEditingController();
  final List<Message> _message = [];

  bool _isLoading = false;

  callGeminiModel() async {
    try {
      if (_controller.text.isNotEmpty) {
        _message.add(Message(text: _controller.text, isUser: true));
        _isLoading = true;
      }
      final model = GenerativeModel(
          model: 'gemini-pro', apiKey: dotenv.env['GOOGLE_API_KEY']!);
      final prompt = _controller.text.trim();
      final content = [Content.text(prompt)];
      final response = await model.generateContent(content);

      setState(() {
        _isLoading = false;
        _message.add(Message(text: response.text!, isUser: false));
      });

      _controller.clear();
    } catch (e) {
      print("Error : $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentTheme = ref.watch(themeProvider);

    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          elevation: 1,
          centerTitle: false,
          backgroundColor: Theme.of(context).colorScheme.surface,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset('assets/gpt-robot.png'),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Talk2Me',
                    style: Theme.of(context).textTheme.titleLarge,
                  )
                ],
              ),
              GestureDetector(
                child: (currentTheme == ThemeMode.dark)
                    ? const Icon(
                        Icons.light_mode,
                        color: Colors.white,
                      )
                    : const Icon(
                        Icons.dark_mode,
                        color: Colors.black,
                      ),
                onTap: () {
                  ref.read(themeProvider.notifier).toggleTheme();
                },
              )
            ],
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _message.length,
                itemBuilder: (context, index) {
                  final messege = _message[index];
                  return ListTile(
                    title: Align(
                      alignment: messege.isUser
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: messege.isUser
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).colorScheme.secondary,
                          borderRadius: messege.isUser
                              ? const BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20),
                                  bottomLeft: Radius.circular(20))
                              : const BorderRadius.only(
                                  topRight: Radius.circular(20),
                                  bottomRight: Radius.circular(20),
                                  bottomLeft: Radius.circular(20),
                                ),
                        ),
                        child: Text(messege.text,
                            style: messege.isUser
                                ? Theme.of(context).textTheme.bodyMedium
                                : Theme.of(context).textTheme.bodySmall),
                      ),
                    ),
                  );
                },
              ),
            ),

            // text input
            Padding(
              padding:
                  const EdgeInsets.only(bottom: 32, top: 16, left: 16, right: 16),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(32),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 5,
                          offset: const Offset(0, 3)),
                    ]),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        style: Theme.of(context).textTheme.titleSmall,
                        decoration: InputDecoration(
                            hintText: "Write your message",
                            hintStyle: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(color: Colors.grey),
                            border: InputBorder.none,
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 20)),
                      ),
                    ),
                    const SizedBox(width: 8),
                    _isLoading
                        ? const Padding(
                            padding: EdgeInsets.all(8),
                            child: SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: GestureDetector(
                              onTap: callGeminiModel,
                              child: Image.asset('assets/send.png'),
                            ),
                          )
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
