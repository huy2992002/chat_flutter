import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../models/chat_model.dart';

Widget buildAvatar(ChatModel chat) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(16.0),
    child: CachedNetworkImage(
      imageUrl: chat.user?.image ?? '',
      width: 32.0,
      height: 32.0,
      fit: BoxFit.cover,
      placeholder: (context, url) => const Center(
        child: SizedBox.square(
          dimension: 24.0,
          child: CircularProgressIndicator(strokeWidth: 2.6),
        ),
      ),
      errorWidget: (context, url, error) => const CircleAvatar(
        radius: 16.0,
        backgroundColor: Colors.orange,
        child: Icon(Icons.error_outline, color: Colors.white),
      ),
    ),
  );
}
