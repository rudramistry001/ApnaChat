import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login/model/chat_user_model.dart';

import '../../main.dart';

import '../../screens/view_profile_screen.dart';

class ProfileDialog extends StatelessWidget {
  const ProfileDialog({super.key, required this.user});

  final ChatUser user;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      backgroundColor: Colors.white.withOpacity(.9),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      content: SizedBox(
        width: mq.width * .6,
        height: mq.height * .35,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10.sp),
              child: Row(
                children: [
                  //user name
                  Expanded(
                    child: Text(
                      user.Name,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),

                  //info button
                  MaterialButton(
                    onPressed: () {
                      //for hiding image dialog
                      Navigator.pop(context);

                      //move to view profile screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ViewProfileScreen(user: user),
                        ),
                      );
                    },
                    minWidth: 0,
                    padding: const EdgeInsets.all(0),
                    shape: const CircleBorder(),
                    child: const Icon(Icons.info_outline,
                        color: Colors.blue, size: 30),
                  ),
                ],
              ),
            ),
            // //user profile picture
            // ClipRRect(
            //   borderRadius: BorderRadius.circular(100),
            //   child: CachedNetworkImage(
            //     width: mq.width * .2,
            //     height: mq.height * .2,
            //     fit: BoxFit.contain,
            //     imageUrl: user.Image,
            //     errorWidget: (context, url, error) => const CircleAvatar(
            //       child: Icon(CupertinoIcons.person),
            //     ),
            //   ),
            // ),
            15.verticalSpace,

            ClipRRect(
              borderRadius: BorderRadius.circular(mq.height * 1),
              child: CachedNetworkImage(
                width: mq.height * .22,
                height: mq.height * .22,
                fit: BoxFit.cover,
                imageUrl: user.Image,
                errorWidget: (context, url, error) =>
                    const CircleAvatar(child: Icon(CupertinoIcons.person)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
