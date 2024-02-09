// ignore_for_file: avoid_print

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login/api/apis.dart';
import 'package:login/main.dart';
import 'package:login/model/chat_user_model.dart';
import 'package:login/model/messages.dart';
import 'package:login/screens/view_profile_screen.dart';
import 'package:login/widgets/message_card.dart';

class UserChatScreen extends StatefulWidget {
  final ChatUser user;
  const UserChatScreen({super.key, required this.user});

  @override
  State<UserChatScreen> createState() => _UserChatScreenState();
}

class _UserChatScreenState extends State<UserChatScreen> {
  List<Message> _newList = [];
  bool _isUploading = false;
  @override
  void initState() {
    super.initState();
    // Scroll to the bottom when the screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });
  }

  //for scrolling down to end of chat by default
  final ScrollController _scrollController = ScrollController();
  // After adding a new item to the list, scroll to the bottom
  _scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 30),
      curve: Curves.easeOut,
    );
  }

  //for storing all messages
  List<Message> _list = [];
//for handling message text controlling
  final _textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            title: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ViewProfileScreen(user: widget.user)),
                );
              },
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back, color: Colors.black54),
                  ),
                  10.horizontalSpace,
                  ClipRRect(
                    borderRadius: BorderRadius.circular(mq.height * .03),
                    child: CachedNetworkImage(
                      width: mq.height * .05,
                      height: mq.height * .05,
                      imageUrl: widget.user.Image,
                      errorWidget: (context, url, error) => const CircleAvatar(
                          child: Icon(CupertinoIcons.person)),
                    ),
                  ),
                  10.horizontalSpace,
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.user.Name,
                        style: TextStyle(
                            fontSize: 16.sp, fontWeight: FontWeight.w400),
                      ),
                      Text(
                        "last seen not avaiable till now",
                        style: TextStyle(
                            fontSize: 16.sp, fontWeight: FontWeight.w400),
                      ),
                    ],
                  )
                ],
              ),
            )),
        backgroundColor: const Color.fromARGB(255, 234, 248, 255),
        body: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: APIs.getAllMessages(widget.user),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    // if data s loading
                    case ConnectionState.waiting:
                    case ConnectionState.none:
                      return const Center(
                        child: CircularProgressIndicator(),
                      );

                    //if some or all data is loaded then show it
                    case ConnectionState.active:
                    case ConnectionState.done:
                      final data = snapshot.data?.docs;

                      _newList = data
                              ?.map((e) => Message.fromJson(e.data()))
                              .toList() ??
                          [];

                      var _list = _newList.reversed.toList();

                      if (_list.isNotEmpty) {
                        return ListView.builder(
                          reverse: true,
                          controller:
                              _scrollController, // Assign the ScrollController
                          itemCount: _list.length,
                          padding: EdgeInsets.only(top: mq.height * .01),
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return MessageCard(
                              message: _list[index],
                            );
                          },
                        );
                      } else {
                        return Center(
                          child: Text(
                            "Say Hii 👋",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20.sp, fontWeight: FontWeight.w400),
                          ),
                        );
                      }
                  }
                },
              ),
            ),
            _chatInput(),
          ],
        ),
      ),
    );
  }

  Widget _chatInput() {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: mq.height * .01, horizontal: mq.width * .025),
      child: Row(
        children: [
          Expanded(
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.emoji_emotions,
                        color: Colors.blueAccent),
                  ),
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Type Something...",
                          hintStyle: TextStyle(
                              color: Colors.blueAccent,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w300)),
                    ),
                  ),
                  IconButton(
                      onPressed: () async {
                        final ImagePicker picker = ImagePicker();

                        // Picking multiple images
                        final List<XFile> images =
                            await picker.pickMultiImage(imageQuality: 70);

                        // uploading & sending image one by one
                        for (var i in images) {
                          print('Image Path: ${i.path}');
                          setState(() => _isUploading = true);
                          await APIs.sendChatImage(widget.user, File(i.path));
                          setState(() => _isUploading = false);
                        }
                      },
                      icon: const Icon(Icons.image,
                          color: Colors.blueAccent, size: 26)),
                  //take image from camera button
                  IconButton(
                      onPressed: () async {
                        final ImagePicker picker = ImagePicker();

                        // Pick an image
                        final XFile? image = await picker.pickImage(
                            source: ImageSource.camera, imageQuality: 70);
                        if (image != null) {
                          print('Image Path: ${image.path}');
                          setState(() => _isUploading = true);

                          await APIs.sendChatImage(
                              widget.user, File(image.path));
                          setState(() => _isUploading = false);
                        }
                      },
                      icon: const Icon(Icons.camera_alt_rounded,
                          color: Colors.blueAccent, size: 26)),
                ],
              ),
            ),
            //send message button
          ),
          IconButton(
              onPressed: () {
                if (_textController.text.isNotEmpty) {
                  //simply send message
                  APIs.sendMessage(
                      widget.user, _textController.text, Type.text);
                  _textController.clear();
                }
              },
              icon: const Icon(Icons.send)),
        ],
      ),
    );
  }
}
