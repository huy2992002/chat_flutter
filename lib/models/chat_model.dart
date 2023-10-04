import 'package:flutter_svg/flutter_svg.dart';

class ChatModel {
  String? id;
  String? message;
  UserModel? user;
  bool? isRecalled;
  bool? isShowFeeling;
  SvgPicture? iconFeeling;
  ChatModel? chatReply;

  ChatModel();

  factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel()
    ..id = json['id'] as String?
    ..message = json['message'] as String?
    ..isRecalled = json['isRecalled'] as bool?
    ..isShowFeeling = json['isShowFeeling'] as bool?
    ..iconFeeling = json['iconFeeling'] as SvgPicture?
    ..chatReply = json['chatReply'] as ChatModel?
    ..user = UserModel.fromJson(json['user']);
}

class UserModel {
  String? id;
  String? name;
  String? image;

  UserModel();

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] as String?;
    name = json['name'] as String?;
    image = json['image'] as String?;
  }
}

class FakeChats {
  static final chats = <ChatModel>[
    ChatModel.fromJson(libraryJson1),
    ChatModel.fromJson(libraryJson2),
    ChatModel.fromJson(libraryJson3),
    ChatModel.fromJson(libraryJson4),
    ChatModel.fromJson(libraryJson5),
    ChatModel.fromJson(libraryJson6),
    ChatModel.fromJson(libraryJson7),
  ];

  static var libraryJson1 = {
    'id': '1',
    'user': {
      'id': '1',
      'name': 'Lorem Ipsum',
      'image': 'abc',
      // 'image': 'https://picsum.photos/250?image=201',
    },
    'message':
        'Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type',
    'isRecall': false,
    'isShowFeeling': false,
    'iconFeeling': null,
    'chatReply': null,
  };

  static const libraryJson2 = {
    'id': '2',
    'user': {
      'id': '2',
      'name': 'Bibliothèque 2',
      'image': 'https://picsum.photos/250?image=202',
    },
    'message': 'Description de la bibliothèque 2',
    'isRecall': false,
    'isShowFeeling': false,
    'iconFeeling': null,
    'chatReply': null,
  };

  static const libraryJson3 = {
    'id': '3',
    'user': {
      'id': '1',
      'name': 'Bibliothèque 3',
      'image': 'https://picsum.photos/250?image=203',
    },
    'message': 'Description de la bibliothèque 3',
    'isRecall': false,
    'isShowFeeling': false,
    'iconFeeling': null,
    'chatReply': null,
  };

  static const libraryJson4 = {
    'id': '4',
    'user': {
      'id': '2',
      'name': 'Bibliothèque 2',
      'image': 'https://picsum.photos/250?image=202',
    },
    'message': 'Description de la bibliothèque 4',
    'isRecall': false,
    'isShowFeeling': false,
    'iconFeeling': null,
    'chatReply': null,
  };

  static const libraryJson5 = {
    'id': '5',
    'user': {
      'id': '1',
      'name': 'Lorem Ipsum',
      'image': 'abc',
      // 'image': 'https://picsum.photos/250?image=201',
    },
    'message':
        'Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type',
    'isRecall': false,
    'isShowFeeling': false,
    'iconFeeling': null,
    'chatReply': null,
  };

  static var libraryJson6 = {
    'id': '6',
    'user': {
      'id': '2',
      'name': 'Bibliothèque 2',
      'image': 'https://picsum.photos/250?image=202',
    },
    'message': 'Description de la bibliothèque 2',
    'isRecall': false,
    'isShowFeeling': false,
    'iconFeeling': null,
    'chatReply':  ChatModel.fromJson(libraryJson3),
  };

  static const libraryJson7 = {
    'id': '7',
    'user': {
      'id': '1',
      'name': 'Bibliothèque 3',
      'image': 'https://picsum.photos/250?image=203',
    },
    'message': 'Description de la bibliothèque 3',
    'isRecall': false,
    'isShowFeeling': false,
    'iconFeeling': null,
    'chatReply': null,
  };
}
