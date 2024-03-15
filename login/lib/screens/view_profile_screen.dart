import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login/dialogs/my_date_util.dart';
import 'package:login/main.dart';
import 'package:login/model/chat_user_model.dart';

//view profile screen -- to view profile of user
class ViewProfileScreen extends StatefulWidget {
  final ChatUser user;

  const ViewProfileScreen({super.key, required this.user});

  @override
  State<ViewProfileScreen> createState() => _ViewProfileScreenState();
}

class _ViewProfileScreenState extends State<ViewProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // for hiding keyboard
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
          //app bar
          // appBar: AppBar(title: Text(widget.user.Name)),
          // floatingActionButton: //user about
          //     Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     const Text(
          //       'Joined On: ',
          //       style: TextStyle(
          //           color: Colors.black87,
          //           fontWeight: FontWeight.w500,
          //           fontSize: 15),
          //     ),
          //     Text(
          //         MyDateUtil.getLastMessageTime(
          //             context: context,
          //             time: widget.user.CreatedAt,
          //             showYear: true),
          //         style: const TextStyle(color: Colors.black54, fontSize: 15)),
          //   ],
          // ),

          //body
          body: Container(
        decoration: const BoxDecoration(
          //gradient: LinearGradient(colors: Colors.white ),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromRGBO(0, 248, 248, 1),
              Color.fromRGBO(0, 57, 89, 1),
            ],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: mq.width * .05),
          child: Column(
            children: [
              50.verticalSpace,
              Text(
                widget.user.Name,
                style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
              // for adding some space
              20.verticalSpace,
              //user profile picture
              ClipRRect(
                borderRadius: BorderRadius.circular(mq.height * .1),
                child: CachedNetworkImage(
                  width: mq.height * .2,
                  height: mq.height * .2,
                  fit: BoxFit.cover,
                  imageUrl: widget.user.Image,
                  errorWidget: (context, url, error) =>
                      const CircleAvatar(child: Icon(CupertinoIcons.person)),
                ),
              ),

              // user email label

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Email: ',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 16.sp,
                    ),
                  ),
                  Text(widget.user.Email,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                      )),
                ],
              ),
              20.verticalSpace,

              //user about
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'About: ',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 18.sp,
                    ),
                  ),
                  Text(widget.user.About,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
                      )),
                ],
              ),
              20.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Joined On: ',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 18.sp),
                  ),
                  Text(
                      MyDateUtil.getLastMessageTime(
                          context: context,
                          time: widget.user.CreatedAt,
                          showYear: true),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
                      )),
                ],
              ),
            ],
          ),
        ),
      )),
    );
  }
}
