import 'package:flutter/material.dart';

import 'message.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _controller = TextEditingController();
  final List<Message> _message = [
    Message(text: "Hi", isUser: true),
    Message(text: "Hello", isUser: false),
    Message(text: "what's up", isUser: true),
    Message(text: "Bla bla", isUser: false),
  ];

  @override
  Widget build(BuildContext context) {
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
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Talk2Me',
                    style: Theme.of(context).textTheme.titleLarge,
                  )
                ],
              ),
              Image.asset(
                'assets/volume-high.png',
                color: Colors.blue[700],
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
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: messege.isUser
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).colorScheme.secondary,
                          borderRadius: messege.isUser
                              ? BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20),
                                  bottomLeft: Radius.circular(20))
                              : BorderRadius.only(
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
                  EdgeInsets.only(bottom: 32, top: 16, left: 16, right: 16),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(32),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 5,
                          offset: Offset(0, 3)),
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
                                EdgeInsets.symmetric(horizontal: 20)),
                      ),
                    ),
                    SizedBox(width: 8),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: GestureDetector(
                        child: Image.asset('assets/send.png'),
                        onTap: () {},
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
