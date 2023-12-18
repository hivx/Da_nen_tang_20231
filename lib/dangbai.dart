import 'dart:convert';
import 'dart:io';

import 'package:anti_facebook_app/features/home/screens/home_screen.dart';
import 'package:anti_facebook_app/utils/httpRequest.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class DangBai extends StatefulWidget {
  const DangBai({super.key});

  @override
  _DangBaiWidgetState createState() => _DangBaiWidgetState();
}

class _DangBaiWidgetState extends State<DangBai> {
  get confirm => null;
  bool isColumnVisible = false;
  bool expanded = false;
  XFile? selectedVideo;
  String described = '';
  String status = '';
  List<String> _imagePaths = [];
  final picker = ImagePicker();
  List<File> images = [];

  String imagePath = "";

  FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        setState(() {
          isColumnVisible = false;
        });
      } else if (!_focusNode.hasFocus && imagePath.isNotEmpty) {
        setState(() {
          isColumnVisible = true;
        });
      }
    });
  }

  Future<void> getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);


    if (pickedFile != null) {
      setState(() {
        images.add(File(pickedFile.path));
      });
    } else {
      print('Không có ảnh được chọn.');
    }
  }


  Future uploadImagesToServer() async {
    try {
      await addPostWithImages(
          '/add_post',
          {
            'video': '',
            // 'image': [],
            "described": described,
            "status": "tuyệt",
            "auto_accept": "1"
          },
          images);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
      setState(() {});
    } catch (error) {
      setState(() {});
    }
    // var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
    // request.headers['Content-Type'] = 'multipart/form-data';
    // request.headers['Authorization'] = 'Bearer $authToken';
    // request.fields['described'] = described;
    // request.fields['video'] = '';
    // request.fields['status'] = status;
    // request.fields['auto_accept'] = '1';

    // List<http.MultipartFile> multipartFiles = [];
    // for (var imagePath in imagePaths) {
    //   final file = File(imagePath);
    //   List<int> fileBytes = await file.readAsBytes();
    //   // if (fileBytes != null) {
    //   var fileImage = http.MultipartFile.fromBytes(
    //     'image', fileBytes,
    //     filename: imagePath.split('/').last,
    //     // Lấy tên tệp từ đường dẫn
    //   );
    //   // request.files.add(fileImage);
    //   print(imagePath);
    //   multipartFiles.add(fileImage);
    // }

    // request.files.addAll(multipartFiles);
    // try {
    //   var response = await request.send();
    //   if (response.statusCode == 200) {
    //     // Navigator.pushReplacementNamed(context, '/home');
    //     print('Images uploaded successfully!');
    //   } else {
    //     print('Failed to upload images. Status code: ${response.statusCode}');
    //   }
    // } catch (e) {
    //   // Xử lý ngoại lệ khi gặp lỗi trong quá trình gửi ảnh
    //   print('Error uploading images: $e');
    //   // setState(() {});
    // }
  }

  // Future<void> sendImages() async {
  //   if (_imagePaths.isNotEmpty) {
  //     await uploadImagesToServer();
  //   } else {
  //     // Xử lý khi không có ảnh được chọn
  //   }
  // }

  Future<void> selectImages() async {
    final picker = ImagePicker();
    final pickedFiles = await picker.pickMultiImage();

    if (pickedFiles != null) {
      setState(() {
        _imagePaths = pickedFiles.map((file) => file.path).toList();
      });
    }
  }

  // Future<void> _getVideo() async {
  //   final ImagePicker picker = ImagePicker();
  //   final pickedFile = await picker.pickVideo(source: ImageSource.gallery);

  //   if (pickedFile != null) {
  //     setState(() {
  //       selectedVideo = pickedFile;
  //     });
  //   }
  // }
  Future postData() async {
    var url = Uri.parse(apiUrl);
    var formData = http.MultipartRequest('POST', url);
    List<String> images = [];
    if(_imagePaths.isNotEmpty) {
      for(String file in _imagePaths) {
        images.add(file);
      }
    }
    formData.headers['Authorization'] = 'Bearer $authToken';
    formData.fields.addAll({
      'described': "described",
      'status': "status",
      // 'image': jsonEncode(images),
    });
    // if(videoFile != null) {
      formData.files.add(
          await http.MultipartFile.fromPath('image', images[0]));
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
                  // const Icon(
                  //   Icons.arrow_back,
                  //   color: Colors.black,
                  //   size: 24.0,
                  //   semanticLabel: 'Text to announce in accessibility modes',
                  // ),
                  const Center(
                    // alignment: AlignmentDirectional(-1, 0),
                    child: Text(
                      'Tạo bài viết',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: uploadImagesToServer,

                    child: const Text(
                      'Đăng',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 17,
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
                                child: const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircleAvatar(
                                      radius: 30.0,
                                      child: Icon(
                                        Icons.person_rounded,
                                        size: 35.0,
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
                                            fontSize: 18.0,
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
                                                Icon(Icons.public, size: 12),
                                                SizedBox(width: 5),
                                                Text(
                                                  'Công khai',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                  ),
                                                ),
                                                SizedBox(width: 5),
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
                              decoration: const InputDecoration(
                                hintText: "Bạn đang nghĩ gì?",
                                hintStyle: TextStyle(fontSize: 20),
                                border: InputBorder.none,
                              ),
                              onChanged: (value) {
                                setState(() {
                                  described = value;
                                });
                              },
                            ),
                          ),
                          if (_imagePaths.isNotEmpty)
                            Positioned(
                              top: 80,
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Column(
                                  //   children: [
                                  //     Container(
                                  //       width:
                                  //           MediaQuery.of(context).size.width /
                                  //               2,
                                  //       height: 150,
                                  //       decoration: BoxDecoration(
                                  //         shape: BoxShape.rectangle,
                                  //         color: Colors.greenAccent,
                                  //         image: _imagePaths[0] != null
                                  //             ? DecorationImage(
                                  //                 image: FileImage(
                                  //                   File(_imagePaths[0].path),
                                  //                 ),
                                  //                 fit: BoxFit.cover,
                                  //               )
                                  //             : null,
                                  //       ),
                                  //     ),
                                  //     Container(
                                  //       width:
                                  //           MediaQuery.of(context).size.width /
                                  //               2,
                                  //       height: 150,
                                  //       decoration: BoxDecoration(
                                  //         shape: BoxShape.rectangle,
                                  //         color: Colors.greenAccent,
                                  //         image: _imagePaths[2] != null
                                  //             ? DecorationImage(
                                  //                 image: FileImage(
                                  //                   File(_imagePaths[2].path),
                                  //                 ),
                                  //                 fit: BoxFit.cover,
                                  //               )
                                  //             : null,
                                  //       ),
                                  //     ),
                                  //   ],
                                  // ),
                                  // Column(
                                  //   children: [
                                  //     Container(
                                  //       width:
                                  //           MediaQuery.of(context).size.width /
                                  //               2,
                                  //       height: 150,
                                  //       decoration: BoxDecoration(
                                  //         shape: BoxShape.rectangle,
                                  //         color: Colors.redAccent,
                                  //         image: _imagePaths[1] != null
                                  //             ? DecorationImage(
                                  //                 image: FileImage(
                                  //                   File(_imagePaths[1].path),
                                  //                 ),
                                  //                 fit: BoxFit.cover,
                                  //               )
                                  //             : null,
                                  //       ),
                                  //     ),
                                  //     Container(
                                  //       width:
                                  //           MediaQuery.of(context).size.width /
                                  //               2,
                                  //       height: 150,
                                  //       decoration: BoxDecoration(
                                  //         shape: BoxShape.rectangle,
                                  //         color: Colors.greenAccent,
                                  //         image: _imagePaths[3] != null
                                  //             ? DecorationImage(
                                  //                 image: FileImage(
                                  //                   File(_imagePaths[3].path),
                                  //                 ),
                                  //                 fit: BoxFit.cover,
                                  //               )
                                  //             : null,
                                  //       ),
                                  //     ),
                                  //   ],
                                  // )
                                ],
                              ),
                            )
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
                          onTap: () {},
                        ),
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
                      onTap: () {}),
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
    );
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
