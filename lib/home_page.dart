import 'package:flutter/material.dart';

import 'message.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Message> _message = [
    Message(text: "Hi", isUser: true),
    Message(text: "Hello", isUser: false),
    Message(text: "what's up", isUser: true),
    Message(text: "Bla bla", isUser: false),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
      itemCount: _message.length,
      itemBuilder: (context, index) {
        final messege = _message[index];
        return ListTile(
          title: Align(
            alignment:
                messege.isUser ? Alignment.centerRight : Alignment.centerLeft,
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: messege.isUser ? Colors.blue[700] : Colors.grey[300],
                  borderRadius: messege.isUser
                      ? BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20))
                      : BorderRadius.only(
                          topRight: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20))),
              child: Text(
                messege.text,
                style: TextStyle(
                    color: messege.isUser ? Colors.white : Colors.black),
              ),
            ),
          ),
        );
      },
    ));
  }
}
