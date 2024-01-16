import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login/api/apis.dart';
import 'package:login/auth/loginscreen.dart';
import 'package:login/constants/strings.dart';
import 'package:login/dialogs/dialogs.dart';
import 'package:login/main.dart';
import 'package:login/model/chat_user_model.dart';
import 'package:login/screens/homescreen.dart';

class ProfileScreen extends StatefulWidget {
  final ChatUser user;
  const ProfileScreen({super.key, required this.user});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
          appBar: AppBar(
            title: const Text(
              StringConstants.profilescreen,
              textAlign: TextAlign.center,
            ),
            backgroundColor: Colors.lightBlue,
            leading: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomePage(),
                  ),
                );
              },
              child: const Icon(
                CupertinoIcons.chevron_back,
                color: Colors.white,
              ),
            ),
          ),
          floatingActionButton: Container(
            height: 70,
            width: 110,
            padding: const EdgeInsets.only(bottom: 16.0, right: 16.0),
            child: FloatingActionButton(
              backgroundColor: Colors.lightBlue,
              onPressed: () async {
                Dialogs.showProgressBar(context);
                await APIs.auth.signOut().then((value) async {
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
                      (route) => false);
                });
              },
              child: const Row(
                children: [
                  SizedBox(
                    width: 5,
                  ),
                  Text('LogOut'),
                  SizedBox(
                    width: 5,
                  ),
                  Icon(
                    Icons.exit_to_app,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: mq.width * .05,
              ),
              child: Column(
                children: [
                  SizedBox(
                    width: mq.width,
                    height: mq.height * .03,
                  ),
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(mq.height * .3),
                        child: CachedNetworkImage(
                          width: mq.height * .3,
                          height: mq.height * .3,
                          imageUrl: widget.user.Image,
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              const CircleAvatar(
                            child: Icon(CupertinoIcons.person),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: MaterialButton(
                          elevation: 1,
                          onPressed: () {},
                          color: Colors.white,
                          shape: const CircleBorder(),
                          child: const Icon(
                            Icons.edit,
                            color: Colors.blue,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    width: mq.width,
                    height: mq.height * .03,
                  ),
                  Text(
                    widget.user.Email,
                    style: const TextStyle(
                      fontWeight: FontWeight.w200,
                      fontSize: 16,
                    ),
                  ),
                  TextFormField(
                    initialValue: widget.user.Name,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.person,
                        color: Colors.blue,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            color:
                                Colors.blueAccent), // Set the border color here
                      ),
                      hintText: 'ex: Your Full Name',
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    initialValue: widget.user.About,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.info_outline,
                        color: Colors.blue,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            color: Colors.blue), // Set the border color here
                      ),
                      hintText: 'ex: About Yourself',
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      // Add your update logic here
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: const StadiumBorder(),
                        minimumSize: Size(mq.width * .5,
                            mq.height * .06) // Set the background color to blue
                        ),
                    icon: const Icon(
                      Icons.update, // Replace with the icon you want to use
                      color: Colors.white, // Set the icon color to white
                    ),
                    label: const Text(
                      'Update',
                      style: TextStyle(
                        color: Colors.white, // Set the text color to white
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
