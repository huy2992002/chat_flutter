import 'package:flutter/material.dart';

import '../models/chat_model.dart';

Widget buildMessageBox(bool isMe, BuildContext context, ChatModel chat) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: isMe ? Colors.grey.withOpacity(0.5) : Colors.grey[300],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(isMe ? 16.0 : 2.0),
          topRight: Radius.circular(isMe ? 2.0 : 16.0),
          bottomLeft: const Radius.circular(16.0),
          bottomRight: const Radius.circular(16.0),
        ),
      ),
      // width: MediaQuery.of(context).size.width * 0.8,

      constraints:
          BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.68),
      child: Text(
        (chat.isRecalled ?? false)
            ? 'Tin nhan da bi thu hoi'
            : '${chat.message}',
        style: TextStyle(
          color: isMe ? Colors.orange : Colors.brown,
          fontSize: 14.0,
        ),
      ),
    );
  }