// ignore_for_file: avoid_print

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
  String? _image;
  final _formKey = GlobalKey<FormState>();
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
          body: Form(
            key: _formKey,
            child: SingleChildScrollView(
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
                        //profile picture
                        _image != null
                            ?

                            //local image
                            ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(mq.height * .1),
                                child: Image.file(File(_image!),
                                    width: mq.height * .2,
                                    height: mq.height * .2,
                                    fit: BoxFit.cover))
                            :

                            //image from server
                            ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(mq.height * .1),
                                child: CachedNetworkImage(
                                  width: mq.height * .2,
                                  height: mq.height * .2,
                                  fit: BoxFit.cover,
                                  imageUrl: widget.user.Image,
                                  errorWidget: (context, url, error) =>
                                      const CircleAvatar(
                                          child: Icon(CupertinoIcons.person)),
                                ),
                              ),
                        // edit image button
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: MaterialButton(
                            elevation: 1,
                            onPressed: () {
                              _showBottomSheet();
                            },
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
                      onSaved: (val) => APIs.me.Name = val ?? '',
                      validator: (val) => val != null && val.isNotEmpty
                          ? null
                          : 'Required Field',
                      decoration: InputDecoration(
                          prefixIcon:
                              const Icon(Icons.person, color: Colors.blue),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)),
                          hintText: 'ex: Your Full Name',
                          label: const Text('Name')),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      initialValue: widget.user.About,
                      onSaved: (val) => APIs.me.About = val ?? '',
                      validator: (val) => val != null && val.isNotEmpty
                          ? null
                          : 'Required Field',
                      decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.info_outline,
                              color: Colors.blue),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)),
                          hintText: 'ex: About Yourself',
                          label: const Text('About')),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          shape: const StadiumBorder(),
                          minimumSize: Size(mq.width * .5, mq.height * .06)),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          APIs.updateUserInfo().then((value) {
                            Dialogs.showSnackbar(
                                context, 'Profile Updated Successfully!');
                          });
                        }
                      },
                      icon: const Icon(Icons.edit, size: 28),
                      label:
                          const Text('UPDATE', style: TextStyle(fontSize: 16)),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }

  void _showBottomSheet() {
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        builder: (_) {
          return ListView(
            shrinkWrap: true,
            padding:
                EdgeInsets.only(top: mq.height * .03, bottom: mq.height * .05),
            children: [
              //pick profile picture label
              const Text('Pick Profile Picture',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),

              //for adding some space
              SizedBox(height: mq.height * .02),

              //buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //pick from gallery button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: const CircleBorder(),
                      fixedSize: Size(mq.width * .3, mq.height * .15),
                    ),
                    onPressed: () async {
                      final ImagePicker picker = ImagePicker();

                      // Pick an image
                      try {
                        final XFile? image = await picker.pickImage(
                          source: ImageSource.gallery,
                          // imageQuality: 80,
                        );

                        if (image != null) {
                          print('Image Path: ${image.path}');
                          setState(() {
                            _image = image.path;
                          });
                        }
                      } catch (e) {
                        print('Error picking image: $e');
                      }
                      APIs.updateProfilePicture(File(_image!));
                      //for hiding bottom sheet after image selection
                      // ignore: use_build_context_synchronously
                      Navigator.pop(context);
                    },
                    child: Image.asset('assets/images/images.png'),
                  ),

                  //take picture from camera button
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: const CircleBorder(),
                          fixedSize: Size(mq.width * .3, mq.height * .15)),
                      onPressed: () async {
                        final ImagePicker picker = ImagePicker();

                        // Pick an image
                        try {
                          final XFile? photo = await picker.pickImage(
                              source: ImageSource.camera);

                          if (photo != null) {
                            setState(() {
                              _image = photo.path;
                            });
                          }
                        } catch (e) {
                          print('Error picking image: $e');
                        }
                        APIs.updateProfilePicture(File(_image!));
                        //for hiding bottom sheet after image selection
                        // ignore: use_build_context_synchronously
                        Navigator.pop(context);
                      },
                      child: Image.asset('assets/images/camera.png')),
                ],
              )
            ],
          );
        });
  }
}
