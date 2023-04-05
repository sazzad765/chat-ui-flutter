import 'package:chat_poc/message.dart';
import 'package:flutter/cupertino.dart';
import 'package:collection/collection.dart';

class Chats extends ChangeNotifier {
  List<Message> _messages = [];

  List<Message> get messages => _messages;

  void setMessage(Message message) {
    message = message.copyWith(id: _messages.length + 1, isSeen: false);
    _messages = [message, ..._messages];
    notifyListeners();
  }

  void setSeen(int id){
    _messages.firstWhereOrNull((element) => element.id ==  id)?.isSeen = true;
    notifyListeners();
  }
}
