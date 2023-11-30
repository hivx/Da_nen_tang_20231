import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import 'main.dart';

class DangBai extends State<MyHomePage> {
  get confirm => null;
  bool isColumnVisible = true;
  bool expanded = false;

  late File videoFile;
  List<XFile> imageFileList = [];
  String described = '';
  String status = '';
  String auto_accept = '';

  String imagePath = "";

  FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    videoFile = File("https://www.youtube.com/watch?v=4Cry85KUzzU");
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
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTA0LCJkZXZpY2VfaWQiOiI0NTc1MTIiLCJpYXQiOjE3MDA1ODg5MDN9.w6ijLbOlOgbYDO-Xp2X_LfWDsKAfmKz0svg91Md2kNQ';

  Future postData() async {
    var data = {
      'image': imageFileList,
      'video': videoFile.path,
      'described': described,
      'status': status,
      'auto_accept': auto_accept
    };

    var response = await http.post(
      Uri.parse(apiUrl),
      body: json.encode(data),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $authToken',
      },
    );

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON data
      var responseData = json.decode(response.body);
      return responseData;
    } else {
      // If the server did not return a 200 OK response, throw an exception.
      throw Exception('Failed to post data');
    }
  }

  void selectImages() async {
    final List<XFile>? selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages!.isNotEmpty) {
      imageFileList!.addAll(selectedImages);
    }
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        isColumnVisible = false;
        imagePath = pickedFile.path;
      });
    }
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
                  const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                    size: 24.0,
                    semanticLabel: 'Text to announce in accessibility modes',
                  ),
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
      body: Stack(
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
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                                          'Anh Hoàng',
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
                                                    BorderRadius.circular(10),
                                              ),
                                              elevation: 5,
                                            ),
                                            child: const Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Icon(Icons.people, size: 12),
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
                                                    BorderRadius.circular(10),
                                              ),
                                              elevation: 5,
                                            ),
                                            child: const Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
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
                                hintStyle: TextStyle(fontSize: 24),
                                border: InputBorder.none,
                              ),
                              onChanged: (value) {
                                setState(() {
                                  status = value;
                                });
                              },
                            ),
                          ),
                          if (imagePath.isNotEmpty)
                            Positioned(
                              top: 80.0,
                                child:Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 400,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    color: Colors.greenAccent,
                                    image: DecorationImage(
                                      image: FileImage(
                                        File(imagePath),
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                            )

                        ],
                      )),
                ],
              ),
            ),
          ),
          AnimatedOpacity(
            opacity: isColumnVisible ? 1.0 : 0.0,
            duration: Duration(milliseconds: 500),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height / 2,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          _pickImage();
                        },
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
                                Icons.image_outlined,
                                color: Colors.green,
                              ),
                              SizedBox(width: 8.0),
                              Text("Ảnh/Video"),
                            ],
                          ),
                        ),
                      ),
                      Container(
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
                              Icons.person_add_alt_1_sharp,
                              color: Colors.blue,
                            ),
                            SizedBox(width: 8.0),
                            Text("Gắn thẻ bạn bè"),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          border: BorderDirectional(
                            top: BorderSide(color: Colors.grey),
                            bottom: BorderSide(color: Colors.grey),
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.sentiment_very_satisfied,
                                color: Colors.orangeAccent),
                            SizedBox(width: 8.0),
                            Text("Cảm xúc/Hoạt động"),
                          ],
                        ),
                      ),
                      Container(
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
                              Icons.pin_drop,
                              color: Colors.redAccent,
                            ),
                            SizedBox(width: 8.0),
                            Text("Ảnh/video"),
                          ],
                        ),
                      ),
                      Container(
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
                              Icons.text_fields_sharp,
                              color: Colors.green,
                            ),
                            SizedBox(width: 8.0),
                            Text("Màu nền"),
                          ],
                        ),
                      ),
                      Container(
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
                              Icons.camera_alt,
                              color: Colors.blueAccent,
                            ),
                            SizedBox(width: 8.0),
                            Text("Camera"),
                          ],
                        ),
                      ),
                      Container(
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
                              Icons.video_call_outlined,
                              color: Colors.redAccent,
                            ),
                            SizedBox(width: 8.0),
                            Text("Video trực tiếp"),
                          ],
                        ),
                      ),
                      Container(
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
                              Icons.music_note_outlined,
                              color: Colors.greenAccent,
                            ),
                            SizedBox(width: 8.0),
                            Text("Nhạc"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
