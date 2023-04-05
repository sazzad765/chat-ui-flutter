import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:chat_poc/chats.dart';
import 'package:chat_poc/message.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RightCard extends StatefulWidget {
  const RightCard({Key? key, required this.message}) : super(key: key);
  final Message message;

  @override
  State<RightCard> createState() => _RightCardState();
}

class _RightCardState extends State<RightCard> {
  @override
  Widget build(BuildContext context) {
    final data = Provider.of<Chats>(context);
    final width = MediaQuery.of(context).size.width;
    return Container(

        constraints: BoxConstraints(maxWidth: width - 100),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        margin: EdgeInsets.only(
          bottom: 8,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey[300] ?? Colors.grey,
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Text(
          widget.message.content,
          textAlign: TextAlign.right,
          style: const TextStyle(
            fontSize: 16.0,

            fontWeight: FontWeight.bold,
          ),
        ));
  }
}
