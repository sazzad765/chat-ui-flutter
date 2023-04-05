import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:chat_poc/chats.dart';
import 'package:chat_poc/message.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class LeftCard extends StatefulWidget {
  const LeftCard({Key? key, required this.message}) : super(key: key);
  final Message message;

  @override
  State<LeftCard> createState() => _LeftCardState();
}

class _LeftCardState extends State<LeftCard> {
  final List<ImageUrl> _images = [];
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();

  Future<void> _launchUrl(String url) async {
    final Uri _url = Uri.parse(url);
    if (!await launchUrl(_url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $_url');
    }
  }

  Future<void> addImage() async {
    int index = 0;
    for (final element in widget.message.images ?? []) {
      if (index == 0) {
        _images.insert(0, element);
      } else {
        await Future.delayed(
          const Duration(milliseconds: 900),
          () {
            _images.insert(0, element);
          },
        );
      }
      index++;
      listKey.currentState!
          .insertItem(0, duration: const Duration(milliseconds: 500));
    }
    ;
  }

  @override
  void initState() {
    if (widget.message.isSeen) _images.addAll(widget.message.images ?? []);
    super.initState();
  }

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
        child: Column(
          children: [
            if (widget.message.isSeen)
              Text(
                widget.message.content,
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            if (!widget.message.isSeen)
              AnimatedTextKit(
                onFinished: () {
                  addImage();
                  data.setSeen(widget.message.id);
                },
                animatedTexts: [
                  TyperAnimatedText(
                    widget.message.content,
                    textStyle: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                    speed: const Duration(milliseconds: 10),
                  ),
                ],
                totalRepeatCount: 1,
                pause: const Duration(milliseconds: 1000),
                displayFullTextOnTap: true,
                stopPauseOnTap: true,
              ),
            AnimatedList(
              key: listKey,
              reverse: true,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              initialItemCount: _images.length,
              itemBuilder: (context, index, animation) {
                final imageUrl = _images[index].thumbnail ?? '';
                final url = _images[index].productUrl ?? '';
                final title = _images[index].productName ?? '';
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(-1, 0),
                    end: Offset(0, 0),
                  ).animate(animation),
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      _launchUrl(url);
                    },
                    child: Row(
                      children: [
                        Image.network(imageUrl, height: 80),
                        Expanded(
                            child: Text(
                          title,
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                      ],
                    ),
                  ),
                );
              },
            )
          ],
        ));
  }
}
