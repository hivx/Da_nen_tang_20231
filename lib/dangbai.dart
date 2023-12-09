import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:fb_project/dangbai/post_picture.dart';
import 'package:fb_project/home.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import 'dangbai/popup.dart';
import 'main.dart';

class DangBai extends StatefulWidget {
  @override
  _DangBaiWidgetState createState() => _DangBaiWidgetState();
}

class _DangBaiWidgetState extends State<DangBai> {
  get confirm => null;
  bool isColumnVisible = true;
  bool expanded = false;

  late File videoFile ;
  List<XFile> imageFileList = [];
  String described = 'hôm nay đẹp quá';
  String status = '';

  String imagePath = "";

  FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // videoFile = File("https://www.youtube.com/watch?v=4Cry85KUzzU");
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        setState(() {
          isColumnVisible = false;
        });
      } else if (!_focusNode.hasFocus && imagePath.isNotEmpty) {
        setState(() {
          // isColumnVisible = true;
        });
      }
    });
  }

  final ImagePicker imagePicker = ImagePicker();

  final String apiUrl = 'https://it4788.catan.io.vn/add_post';

  final String authToken =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Mzc1LCJkZXZpY2VfaWQiOiIxMTIyMzMiLCJpYXQiOjE3MDIxMzM4MjV9.PhQuDrC67mXFCX1qEyleqN4K_BlZMhgYsEl3Q72sNbQ';

  Future postData() async {
    var url = Uri.parse(apiUrl);
    var formData = http.MultipartRequest('POST', url);
    List<String> images = [];
    if(imageFileList.isNotEmpty) {
      for(XFile file in imageFileList) {
        images.add(file.path);
      }
    }
    formData.headers['Authorization'] = 'Bearer $authToken';
    formData.fields.addAll({
      'described': described,
      'status': status,
      'image': jsonEncode(images),
    });
    // if(videoFile != null) {
    //   formData.files.add(
    //       await http.MultipartFile.fromPath('file', videoFile.path));
    // }
    try {
      final response = await formData.send();
      if (response.statusCode == 200) {
        print('Success: ${await response.stream.bytesToString()}');
      } else {
        throw Exception('Failed to post data. Status code: ${response.statusCode} ${response.stream.bytesToString()}');
      }
    } catch (e) {
      print('Error4: $e');
      throw Exception('Failed to post data');
    }
  }

  void selectImages() async {
    setState(() {
      isColumnVisible = false;
    });
    debugPrint("choose image");
    final List<XFile> selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages!.isNotEmpty) {
      setState(() {
        imageFileList = selectedImages;
      });
    }
    for (XFile file in imageFileList) {
      String path = file.path;
    }
  }

  void onDeleteImage(int index) {
    setState(() {
      imageFileList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                width: double.infinity,
                height: 70,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const Align(
                      alignment: AlignmentDirectional(-1, 0),
                      child: Text(
                        'Tạo bài viết',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: postData,
                      child: const Text(
                        'Đăng',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ], // Text(widget.title),
          ),
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(1.0),
            child: Divider(
              color: Colors.black12,
              height: 1.0,
            ),
          ),
        ),
        body: WillPopScope(
          onWillPop: () async {
            bool shouldExit =
                await ExitConfirmationDialog.showExitConfirmationDialog(
                    context);
            return shouldExit;
          },
          child: Stack(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    isColumnVisible = !isColumnVisible;
                  });
                },
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                            color: Colors.white,
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    color: Colors.white,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        CircleAvatar(
                                          radius: 30.0,
                                          child: Icon(
                                            Icons.person_rounded,
                                            size: 60.0,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 8,
                                  child: Container(
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            alignment: Alignment.bottomLeft,
                                            child: const Text(
                                              'Hai Dinh',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        Expanded(
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              ElevatedButton(
                                                onPressed: () {},
                                                style: ElevatedButton.styleFrom(
                                                  foregroundColor: Colors.grey,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  elevation: 5,
                                                ),
                                                child: const Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    Icon(Icons.people,
                                                        size: 12),
                                                    SizedBox(width: 8),
                                                    Text(
                                                      'Bạn bè',
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                    SizedBox(width: 8),
                                                    Icon(Icons.arrow_drop_down,
                                                        size: 16),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                              ElevatedButton(
                                                onPressed: () {},
                                                style: ElevatedButton.styleFrom(
                                                  foregroundColor: Colors.grey,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  elevation: 5,
                                                ),
                                                child: const Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    Icon(Icons.add, size: 12),
                                                    SizedBox(width: 8),
                                                    Text(
                                                      'Album',
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                    SizedBox(width: 8),
                                                    Icon(Icons.arrow_drop_down,
                                                        size: 16),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )),
                      ),
                      Expanded(
                          flex: 8,
                          child: Stack(
                            children: [
                              Container(
                                padding: EdgeInsets.all(8.0),
                                child: TextField(
                                  focusNode: _focusNode,
                                  maxLines: null,
                                  expands: true,
                                  decoration: InputDecoration(
                                    hintText: "Bạn đang nghĩ gì?",
                                    hintStyle: TextStyle(fontSize: 20),
                                    border: InputBorder.none,
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      status = value;
                                    });
                                  },
                                ),
                              ),
                              if (imageFileList.isNotEmpty)
                                PostPicture(
                                  imageFileList: imageFileList,
                                  onDeleteImage: onDeleteImage,
                                )

                              // Positioned(
                              //   top: 80,
                              //   child: Row(
                              //     mainAxisSize: MainAxisSize.max,
                              //     crossAxisAlignment: CrossAxisAlignment.start,
                              //     children: [
                              //       Column(
                              //         children: [
                              //           Container(
                              //             width:
                              //                 MediaQuery.of(context).size.width /
                              //                     2,
                              //             height: 150,
                              //             decoration: BoxDecoration(
                              //               shape: BoxShape.rectangle,
                              //               color: Colors.greenAccent,
                              //               image: imageFileList[0] != null
                              //                   ? DecorationImage(
                              //                       image: FileImage(
                              //                         File(imageFileList[0].path),
                              //                       ),
                              //                       fit: BoxFit.cover,
                              //                     )
                              //                   : null,
                              //             ),
                              //           ),
                              //           Container(
                              //             width: MediaQuery.of(context).size.width / 2,
                              //             height: 150,
                              //             decoration: BoxDecoration(
                              //               shape: BoxShape.rectangle,
                              //               color: Colors.greenAccent,
                              //               image: imageFileList[2] != null
                              //                   ? DecorationImage(
                              //                       image: FileImage(
                              //                         File(imageFileList[2].path),
                              //                       ),
                              //                       fit: BoxFit.cover,
                              //                     )
                              //                   : null,
                              //             ),
                              //           ),
                              //         ],
                              //       ),
                              //       Column(
                              //         children: [
                              //           Container(
                              //             width:
                              //                 MediaQuery.of(context).size.width /
                              //                     2,
                              //             height: 150,
                              //             decoration: BoxDecoration(
                              //               shape: BoxShape.rectangle,
                              //               color: Colors.redAccent,
                              //               image: imageFileList[1].path != null
                              //                   ? DecorationImage(
                              //                       image: FileImage(
                              //                         File(imageFileList[1].path),
                              //                       ),
                              //                       fit: BoxFit.cover,
                              //                     )
                              //                   : null,
                              //             ),
                              //           ),
                              //           Container(
                              //             width:
                              //                 MediaQuery.of(context).size.width /
                              //                     2,
                              //             height: 150,
                              //             decoration: BoxDecoration(
                              //               shape: BoxShape.rectangle,
                              //               color: Colors.greenAccent,
                              //               image: imageFileList[3] != null
                              //                   ? DecorationImage(
                              //                       image: FileImage(
                              //                         File(imageFileList[3].path),
                              //                       ),
                              //                       fit: BoxFit.cover,
                              //                     )
                              //                   : null,
                              //             ),
                              //           ),
                              //         ],
                              //       )
                              //     ],
                              //   ),
                              // )
                            ],
                          )),
                    ],
                  ),
                ),
              ),
              if (isColumnVisible)
                AnimatedOpacity(
                  opacity: isColumnVisible ? 1.0 : 0.0,
                  duration: Duration(milliseconds: 500),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height / 2,
                      color: Colors.white,
                      child: SingleChildScrollView(
                        physics: AlwaysScrollableScrollPhysics(),
                        child: Column(
                          children: [
                            ItemVertical(
                                icon: Icons.image_outlined,
                                iconColor: Colors.green,
                                text: "Ảnh/Video",
                                onTap: selectImages),
                            ItemVertical(
                                icon: Icons.person_add_alt_1_sharp,
                                iconColor: Colors.blue,
                                text: "Gắn thẻ bạn bè",
                                onTap: () {}),
                            ItemVertical(
                                icon: Icons.sentiment_very_satisfied,
                                iconColor: Colors.orangeAccent,
                                text: "Cảm xúc/Hoạt động",
                                onTap: () {}),
                            ItemVertical(
                                icon: Icons.pin_drop,
                                text: "Vị trí",
                                iconColor: Colors.redAccent,
                                onTap: () {}),
                            ItemVertical(
                                icon: Icons.text_fields_sharp,
                                iconColor: Colors.green,
                                text: "Màu nền",
                                onTap: () {}),
                            ItemVertical(
                                icon: Icons.camera_alt,
                                text: "Camera",
                                iconColor: Colors.blueAccent,
                                onTap: () {}),
                            ItemVertical(
                                icon: Icons.video_call_outlined,
                                iconColor: Colors.redAccent,
                                text: "Video trực tiếp",
                                onTap: () {}),
                            ItemVertical(
                                icon: Icons.music_note_outlined,
                                iconColor: Colors.greenAccent,
                                text: "Nhạc",
                                onTap: () {}),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              if (!isColumnVisible)
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(children: [
                      ItemHorizontal(
                          icon: Icons.image_outlined,
                          iconColor: Colors.green,
                          onTap: selectImages),
                      ItemHorizontal(
                          icon: Icons.person_add_alt_1_sharp,
                          iconColor: Colors.blue,
                          onTap: () {}),
                      ItemHorizontal(
                          icon: Icons.sentiment_very_satisfied,
                          iconColor: Colors.orangeAccent,
                          onTap: () {}),
                      ItemHorizontal(
                          icon: Icons.pin_drop,
                          iconColor: Colors.redAccent,
                          onTap: () {}),
                      ItemHorizontal(
                          icon: Icons.text_fields_sharp,
                          iconColor: Colors.green,
                          onTap: () {}),
                      ItemHorizontal(
                          icon: Icons.camera_alt,
                          iconColor: Colors.blueAccent,
                          onTap: () {}),
                      ItemHorizontal(
                          icon: Icons.video_call_outlined,
                          iconColor: Colors.redAccent,
                          onTap: () {}),
                      ItemHorizontal(
                          icon: Icons.music_note_outlined,
                          iconColor: Colors.greenAccent,
                          onTap: () {}),
                    ]),
                  ),
                ),
            ],
          ),
        ));
  }
}

class MyHorizontalScrollView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(children: [
        ItemHorizontal(
            icon: Icons.image_outlined, iconColor: Colors.green, onTap: () {}),
        ItemHorizontal(
            icon: Icons.person_add_alt_1_sharp,
            iconColor: Colors.blue,
            onTap: () {}),
        ItemHorizontal(
            icon: Icons.sentiment_very_satisfied,
            iconColor: Colors.orangeAccent,
            onTap: () {}),
        ItemHorizontal(
            icon: Icons.pin_drop, iconColor: Colors.redAccent, onTap: () {}),
        ItemHorizontal(
            icon: Icons.text_fields_sharp,
            iconColor: Colors.green,
            onTap: () {}),
        ItemHorizontal(
            icon: Icons.camera_alt, iconColor: Colors.blueAccent, onTap: () {}),
        ItemHorizontal(
            icon: Icons.video_call_outlined,
            iconColor: Colors.redAccent,
            onTap: () {}),
        ItemHorizontal(
            icon: Icons.music_note_outlined,
            iconColor: Colors.greenAccent,
            onTap: () {}),
      ]),
    );
  }
}

class ItemVertical extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String text;
  final VoidCallback onTap;
  const ItemVertical(
      {required this.icon,
      required this.iconColor,
      required this.text,
      required this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          border: BorderDirectional(
            top: BorderSide(color: Colors.grey),
            bottom: BorderSide(color: Colors.grey),
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: iconColor,
            ),
            SizedBox(width: 8.0),
            Text(text),
          ],
        ),
      ),
    );
  }
}

class ItemHorizontal extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final VoidCallback onTap;
  const ItemHorizontal(
      {required this.icon, required this.iconColor, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 50,
        height: 50,
        margin: EdgeInsets.all(8),
        child: Center(
          child: Icon(
            icon,
            color: iconColor,
          ),
        ),
      ),
    );
  }
}
