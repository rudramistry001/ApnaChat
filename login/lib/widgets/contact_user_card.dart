import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login/main.dart';
import 'package:login/model/chat_user_model.dart';

class ContactUserCard extends StatefulWidget {
  final ChatUser user;
  const ContactUserCard({super.key, required this.user});

  @override
  State<ContactUserCard> createState() => _ContactUserCardState();
}

class _ContactUserCardState extends State<ContactUserCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blue.shade50,
      margin: EdgeInsets.symmetric(horizontal: mq.width * .04, vertical: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        onTap: () {},
        child: ListTile(
          // leading: const CircleAvatar(
          //   child: Icon(CupertinoIcons.person),
          // ),
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(mq.height * .3),
            child: CachedNetworkImage(
              width: mq.height * .055,
              height: mq.height * .055,
              imageUrl: widget.user.Image,
              //placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const CircleAvatar(
                child: Icon(CupertinoIcons.person),
              ),
            ),
          ),
          title: Text(widget.user.Name),
          subtitle: Text(
            widget.user.About,
            maxLines: 1,
          ),
          // trailing: const Text('12:00 PM'),
          trailing: IconButton(
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => ProfileScreen(
                //       user: APIs.me,
                //     ),
                //   ),
                // );
              },
              icon: const Icon(
                Icons.more_vert,
                color: Colors.white,
              )),
        ),
      ),
    );
  }
}
