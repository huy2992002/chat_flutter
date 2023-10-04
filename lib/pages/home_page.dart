import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../components/build_avatar.dart';
import '../components/build_mesage_box.dart';
import '../components/build_select_box.dart';
import '../models/chat_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController messageController = TextEditingController();
  ScrollController scollController = ScrollController();
  bool isSwitch = false;
  bool isShowReply = false;
  ChatModel? chatReplyInit;

  List<SvgPicture> icons = [
    SvgPicture.asset(
      'assets/icons/like.svg',
      width: 23.0,
      height: 23.0,
    ),
    SvgPicture.asset(
      'assets/icons/love.svg',
      width: 23.0,
      height: 23.0,
    ),
    SvgPicture.asset(
      'assets/icons/haha.svg',
      width: 23.0,
      height: 23.0,
    ),
    SvgPicture.asset(
      'assets/icons/soaked.svg',
      width: 23.0,
      height: 23.0,
    ),
    SvgPicture.asset(
      'assets/icons/sad.svg',
      width: 23.0,
      height: 23.0,
    ),
    SvgPicture.asset(
      'assets/icons/angry.svg',
      width: 23.0,
      height: 23.0,
    ),
    SvgPicture.asset(
      'assets/icons/cancel.svg',
      width: 23.0,
      height: 23.0,
    ),
  ];



  @override
  void initState(){
    super.initState();
    
  }

  void _sendMessage(String message) {
    if (message.isEmpty) {
      return;
    }

    final user = UserModel.fromJson({
      'id': '2',
      'name': 'Bibliothèque 2',
      'image': 'https://picsum.photos/250?image=202',
    });
    final newChat = ChatModel()
      ..id = '2'
      ..message = message
      ..chatReply = chatReplyInit
      ..user = user;
    FakeChats.chats.add(newChat);
    chatReplyInit = null;
    messageController.clear();
    scollController.animateTo(
      scollController.position.maxScrollExtent + 80.0,
      duration: const Duration(milliseconds: 10),
      curve: Curves.easeOut,
    );
    isShowReply = false;
    setState(() {});
  }

  void deleteMessage(String id) {
    FakeChats.chats.removeWhere((element) => element.id == id);
    setState(() {});
  }

  void closeFeeling() {
    for (ChatModel chat in FakeChats.chats) {
      chat.isShowFeeling = false;
    }
    setState(() {});
  }

  void closeFeelingNotMe(ChatModel chatMe) {
    for (ChatModel chat in FakeChats.chats) {
      if (chat.id != chatMe.id) {
        chat.isShowFeeling = false;
      }
    }
    setState(() {});
  }

  void _replyMessage(ChatModel chat) {
    isShowReply = true;
    chatReplyInit = chat;
    scollController.animateTo(
      scollController.position.maxScrollExtent + 80.0,
      duration: const Duration(milliseconds: 10),
      curve: Curves.easeOut,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        closeFeeling();
      },
      child: Scaffold(
        backgroundColor: isSwitch ? Colors.blueAccent : const Color(0xff191970),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0).copyWith(
                top: MediaQuery.of(context).padding.top + 6.0,
                bottom: 12.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset('assets/images/avt.png', width: 44.0),
                  const Text(
                    'Virtusl Coach',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    width: 122.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      color: const Color(0xffFFFFFF).withOpacity(0.3),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 7.6, horizontal: 16.0),
                          child: Image.asset('assets/images/bird.png',
                              width: 42.0, height: 36.0),
                        ),
                        GestureDetector(
                          onTap: () => setState(() => isSwitch = !isSwitch),
                          child: Container(
                            width: 38.0,
                            height: 22.0,
                            padding: const EdgeInsets.all(2.4),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(11.6),
                            ),
                            child: Align(
                              alignment: !isSwitch
                                  ? Alignment.centerLeft
                                  : Alignment.centerRight,
                              child: Container(
                                width: 18.0,
                                decoration: BoxDecoration(
                                  color: isSwitch ? Colors.blueAccent : Colors.white,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: SlidableAutoCloseBehavior(
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0)
                      .copyWith(top: 16.0, bottom: 20.0),
                  controller: scollController,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 14.0),
                  itemBuilder: (context, index) {
                    final chat = FakeChats.chats[index];
                    bool isMe = ((chat.user ?? UserModel()).id ?? '') == '2';
                    return GestureDetector(
                      onLongPress: () {
                        scollController.animateTo(
                          scollController.position.maxScrollExtent + 80.0,
                          duration: const Duration(milliseconds: 10),
                          curve: Curves.easeOut,
                        );

                        chat.isShowFeeling = true;
                        closeFeelingNotMe(chat);
                        setState(() {});
                      },
                      child: Slidable(
                        startActionPane:
                            isMe ? null : _buildActionPaneOne(chat),
                        endActionPane: isMe
                            ? (chat.isRecalled ?? false)
                                ? _buildActionPaneThree(chat)
                                : _buildActionPaneTwo(chat)
                            : null,
                        child: Column(
                          crossAxisAlignment: isMe
                              ? CrossAxisAlignment.end
                              : CrossAxisAlignment.start,
                          children: [
                            if (chat.chatReply != null)
                              Container(
                                padding: const EdgeInsets.all(8.0),
                                margin: EdgeInsets.only(
                                  left: !isMe ? 32.0 + 8.0 : 0.0,
                                  right: isMe ? 32.0 + 8.0 : 0.0,
                                ),
                                decoration: BoxDecoration(
                                    color: const Color(0xff383D3F)
                                        .withOpacity(0.4),
                                    borderRadius: BorderRadius.circular(10)),
                                constraints: BoxConstraints(
                                  maxWidth:
                                      MediaQuery.of(context).size.width * 0.6,
                                ),
                                child: Text(
                                  chat.chatReply?.message ?? '',
                                  style: const TextStyle(color: Colors.white),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: isMe
                                  ? MainAxisAlignment.end
                                  : MainAxisAlignment.start,
                              children: [
                                if (!isMe) ...[
                                  buildAvatar(chat),
                                  const SizedBox(width: 8.0),
                                ],
                                if (isMe) _iconReply(chat),
                                Stack(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                        bottom: (chat.iconFeeling == null)
                                            ? 4.0
                                            : 10.0,
                                      ),
                                      child:
                                          buildMessageBox(isMe, context, chat),
                                    ),
                                    if (chat.iconFeeling != null)
                                      Positioned(
                                        right: 0,
                                        bottom: 0,
                                        child: CircleAvatar(
                                          radius: 12,
                                          backgroundColor: Colors.white,
                                          child: GestureDetector(
                                            onTap: () {},
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(2.0),
                                              child: chat.iconFeeling,
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                                if (!isMe) _iconReply(chat),
                                if (isMe) ...[
                                  const SizedBox(width: 8.0),
                                  buildAvatar(chat),
                                ],
                              ],
                            ),
                            const SizedBox(height: 2.0),
                            if (chat.isShowFeeling ?? false)
                              Container(
                                width: MediaQuery.of(context).size.width * 0.55,
                                margin: EdgeInsets.only(
                                  left: !isMe ? 32.0 + 8.0 : 0.0,
                                  right: isMe ? 32.0 + 8.0 : 0.0,
                                ),
                                height: 30,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ...List.generate(
                                      icons.length,
                                      (index) => GestureDetector(
                                        onTap: () {
                                          if (index == icons.length - 1) {
                                            chat.iconFeeling = null;
                                          } else {
                                            chat.iconFeeling = icons[index];
                                          }

                                          chat.isShowFeeling = false;
                                          setState(() {});
                                        },
                                        child: icons[index],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            if (chat.isShowFeeling ?? false)
                              Container(
                                width: MediaQuery.of(context).size.width * 0.35,
                                margin: EdgeInsets.only(
                                  top: 4.0,
                                  left: !isMe ? 32.0 + 8.0 : 0.0,
                                  right: isMe ? 32.0 + 8.0 : 0.0,
                                ),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 6.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Column(
                                  children: [
                                    BuildSelectBox(
                                      onPressed: () {
                                        _replyMessage(chat);
                                        chat.isShowFeeling = false;
                                        setState(() {});
                                      },
                                      text: 'Trả lời',
                                      icon: const Icon(
                                        Icons.reply,
                                        size: 16,
                                      ),
                                    ),
                                    if (isMe)
                                      BuildSelectBox(
                                        onPressed: () {
                                          chat.isRecalled =
                                              !(chat.isRecalled ?? false);
                                          chat.isShowFeeling = false;
                                          setState(() {});
                                        },
                                        text: (chat.isRecalled ?? false)
                                            ? 'Phục hồi'
                                            : 'Thu hồi',
                                        icon: const Icon(
                                          Icons.beach_access,
                                          size: 16,
                                        ),
                                      ),
                                    BuildSelectBox(
                                      onPressed: () {
                                        deleteMessage(chat.id ?? '');
                                        chat.isShowFeeling = false;
                                        setState(() {});
                                      },
                                      text: 'Xóa',
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                        size: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: FakeChats.chats.length,
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
          ).copyWith(bottom: MediaQuery.of(context).viewInsets.bottom + 24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (isShowReply)
                Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 8.0),
                      decoration: BoxDecoration(
                        color: const Color(0xff383D3F).withOpacity(0.4),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(24.0),
                          topRight: Radius.circular(24.0),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            (chatReplyInit?.user?.id) == '2'
                                ? 'Phản hồi từ tôi'
                                : 'Phản hồi từ ${chatReplyInit?.user?.name}',
                            style: const TextStyle(
                                color: Colors.orange, fontSize: 12),
                          ),
                          const SizedBox(height: 4.0),
                          Text(
                            chatReplyInit?.message ?? '',
                            style: const TextStyle(color: Colors.white),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 4,
                      right: 4,
                      child: GestureDetector(
                        onTap: () {
                          isShowReply = false;
                          chatReplyInit = null;
                          setState(() {});
                        },
                        child: const CircleAvatar(
                          radius: 6,
                          child: Icon(Icons.close, size: 12),
                        ),
                      ),
                    )
                  ],
                ),
              Container(
                decoration: BoxDecoration(
                  color: isShowReply
                      ? const Color(0xff383D3F).withOpacity(0.4)
                      : null,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(24.0),
                    bottomRight: Radius.circular(24.0),
                  ),
                ),
                child: TextField(
                  controller: messageController,
                  onTap: () {
                    Timer(const Duration(milliseconds: 500), () {
                      scollController.animateTo(
                        scollController.position.maxScrollExtent + 80.0,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeOut,
                      );
                    });
                  },
                  style: const TextStyle(color: Colors.orange),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xff383D3F).withOpacity(0.4),
                    hintStyle: const TextStyle(
                        color: Color(0xffB7B8BA), fontSize: 14.0),
                    hintText: 'Lorem ipsum bla blu blo',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                    suffixIcon: GestureDetector(
                      onTap: () => _sendMessage(messageController.text.trim()),
                      child: const Icon(Icons.send, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _iconReply(ChatModel chat) {
    return GestureDetector(
      onTap: () {
        _replyMessage(chat);
      },
      child: const Icon(
        Icons.reply,
        size: 16.0,
        color: Colors.white,
      ),
    );
  }

  ActionPane _buildActionPaneOne(ChatModel chat) {
    return ActionPane(
      motion: const DrawerMotion(),
      children: [
        SlidableAction(
          onPressed: (context) {
            deleteMessage(chat.id ?? '');
          },
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
          icon: Icons.delete,
        ),
        SlidableAction(
          onPressed: (context) {},
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          icon: Icons.cancel,
        ),
      ],
    );
  }

  ActionPane _buildActionPaneTwo(ChatModel chat) {
    return ActionPane(
      motion: const DrawerMotion(),
      children: [
        SlidableAction(
          onPressed: (context) {
            deleteMessage(chat.id ?? '');
          },
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
          icon: Icons.delete,
        ),
        SlidableAction(
          onPressed: (context) {
            chat.isRecalled = true;
            setState(() {});
          },
          backgroundColor: Colors.yellow,
          foregroundColor: Colors.white,
          icon: Icons.beach_access,
        ),
        SlidableAction(
          onPressed: (context) {},
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          icon: Icons.cancel,
        ),
      ],
    );
  }

  ActionPane _buildActionPaneThree(ChatModel chat) {
    return ActionPane(
      motion: const DrawerMotion(),
      children: [
        SlidableAction(
          onPressed: (context) {
            deleteMessage(chat.id ?? '');
          },
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
          icon: Icons.delete,
        ),
        SlidableAction(
          onPressed: (context) {
            chat.isRecalled = false;
            setState(() {});
          },
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          icon: Icons.replay,
        ),
        SlidableAction(
          onPressed: (context) {},
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          icon: Icons.cancel,
        ),
      ],
    );
  }

  

  
}


