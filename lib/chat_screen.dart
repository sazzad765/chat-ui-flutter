import 'package:chat_poc/chats.dart';
import 'package:chat_poc/left_card.dart';
import 'package:chat_poc/message.dart';
import 'package:chat_poc/right_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  FocusNode focusNode = FocusNode();
  bool sendButton = false;

  TextEditingController _controller = TextEditingController();
  ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<Chats>(context);
    final messages = data.messages;
    return Column(
      children: [
        Expanded(
          // height: MediaQuery.of(context).size.height - 150,
          child: ListView.builder(
            // controller: _scrollController,
            padding: EdgeInsets.all(16),
            dragStartBehavior: DragStartBehavior.down,
            reverse: true,
            itemCount: messages.length,
            itemBuilder: (context, index) {
              final item = messages[index];
              if (item.sender == 1) {
                return Align(
                    alignment: Alignment.centerRight,
                    child: RightCard(message: item));
              }
              return Align(
                  alignment: Alignment.centerLeft,
                  child: LeftCard(key:ValueKey(item.id) ,message: item));
            },
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Card(
                      margin: EdgeInsets.only(left: 10, right: 2, bottom: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: TextFormField(
                        controller: _controller,
                        focusNode: focusNode,
                        textAlignVertical: TextAlignVertical.center,
                        keyboardType: TextInputType.multiline,
                        maxLines: 5,
                        minLines: 1,
                        onChanged: (value) {
                          // if (value.length > 0) {
                          //   setState(() {
                          //     sendButton = true;
                          //   });
                          // } else {
                          //   setState(() {
                          //     sendButton = false;
                          //   });
                          // }
                        },
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Type a message",
                            hintStyle: TextStyle(color: Colors.grey),
                            // prefixIcon: IconButton(
                            //   icon: Icon(
                            //     show
                            //         ? Icons.keyboard
                            //         : Icons.emoji_emotions_outlined,
                            //   ),
                            //   onPressed: () {
                            //     if (!show) {
                            //       focusNode.unfocus();
                            //       focusNode.canRequestFocus = false;
                            //     }
                            //     setState(() {
                            //       show = !show;
                            //     });
                            //   },
                            // ),
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 16)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 8,
                      right: 2,
                      left: 2,
                    ),
                    child: CircleAvatar(
                      radius: 25,
                      backgroundColor: Color(0xFF128C7E),
                      child: IconButton(
                        icon: Icon(
                          Icons.send,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          data.setMessage(Message(
                              content: _controller.text,
                              images: [],
                              sender: 1));
                          data.setMessage(Message.fromJson(demo));

                          print(_controller.text);
                          setState(() {});
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

var demo = {
  "content":
      "It's urgent, but we don't have time in the next two years to test it, but we must prioritize it. At least we don't need to obfuscate it. You must rethink the whole process. We will give you a slice of pizza if you finish the code until yesterday. Make it pop remember, the entirety is equal or better.  We must build a queue system to ensure it gets the data from our API so this will result in a delay. How does this indicator should look? Also please answer to question from the next mail. Kind reminder. Please inform us where we are on this. After the release, we will need to test it individually. This was the last time when you are allowed to promote something urgent in the production when you was asked for.<br>",
  "images": [
    {
      "thumbnail":
          "https://images.shajgoj.com/wp-content/uploads/2018/10/himalaya-fach-wash-purifying-neem-100ml.jpg_1_800.jpg",
      "product_url":
          "https://shop.shajgoj.com/product/himalaya-purifying-neem-face-wash-2/",
      "product_name": "Himalaya Purifying Neem Face Wash"
    },
    {
      "thumbnail":
          "https://images.shajgoj.com/wp-content/uploads/2020/01/Himalaya-Clear-Complexion-Whitening-Face-wash-100-ml.jpg",
      "product_url":
          "https://shop.shajgoj.com/product/himalaya-clear-complexion-whitening-face-wash/",
      "product_name": "Himalaya's Clear Complexion Whitening Face Wash"
    },
    {
      "thumbnail":
          "https://images.shajgoj.com/wp-content/uploads/2020/10/Himalaya-Fresh-Start-Oil-Clear-Bluebery-Face-Wash-50ml-2.jpg",
      "product_url":
          "https://shop.shajgoj.com/product/himalaya-fresh-start-oil-clear-face-wash-blueberry-100-0-ml-pack-of-2/",
      "product_name": "Himalaya Fresh Start Oil Clear Face Wash Blueberry"
    }
  ]
};
