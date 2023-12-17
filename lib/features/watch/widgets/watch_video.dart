import 'package:anti_facebook_app/constants/global_variables.dart';
import 'package:anti_facebook_app/features/comment/screens/comment_screen.dart';
import 'package:anti_facebook_app/features/home/screens/home_screen.dart';
import 'package:anti_facebook_app/features/news-feed/widgets/post_content.dart';
import 'package:anti_facebook_app/features/watch/screens/watch_others_screen.dart';
import 'package:anti_facebook_app/features/watch/screens/watch_screen.dart';
import 'package:anti_facebook_app/models/post.dart';
import 'package:anti_facebook_app/utils/httpRequest.dart';
import 'package:anti_facebook_app/utils/time_utils.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'controls_overlay.dart';

// ignore: must_be_immutable
class WatchVideo extends StatefulWidget {
  final Post post;
  final GlobalKey videoKey;
  VideoControllerWrapper controller;
  bool? autoPlay;
  bool? isDarkMode;
  bool? noDispose;

  WatchVideo({
    Key? key,
    required this.post,
    required this.videoKey,
    required this.controller,
    this.autoPlay,
    this.isDarkMode,
    this.noDispose,
  }) : super(key: key);

  @override
  State<WatchVideo> createState() => _WatchVideoState();
}

class _WatchVideoState extends State<WatchVideo> {
  late List<String> icons = [];
  String reactions = '0';
  bool postVisible = true;
  String details = '';
  String subject = '';
  @override
  void initState() {
    super.initState();
    if (widget.controller.value == null ||
        (widget.controller.value != null &&
            !widget.controller.value!.value.isInitialized)) {
      widget.controller.value =
          VideoPlayerController.networkUrl(Uri.parse(widget.post.video!))
            ..initialize().then((value) {
              setState(() {
                widget.controller.value?.setVolume(1.0);
                if (widget.autoPlay == true) {
                  if (WatchScreen.offset == 0) {
                    widget.controller.value?.play();
                  }
                }
              });
            });
    } else {
      widget.controller.value?.play();
    }
    List<int> list = [
      widget.post.like != null ? widget.post.like! : 0,
      widget.post.haha != null ? widget.post.haha! : 0,
      widget.post.love != null ? widget.post.love! : 0,
      widget.post.lovelove != null ? widget.post.lovelove! : 0,
      widget.post.wow != null ? widget.post.wow! : 0,
      widget.post.sad != null ? widget.post.sad! : 0,
      widget.post.angry != null ? widget.post.angry! : 0
    ];
    list.sort((a, b) => b - a);
    int sum = 0;
    for (int i = 0; i < list.length; i++) {
      sum += list[i];
    }
    setState(() {
      reactions = '';
      String tmp = sum.toString();
      int x = 0;
      for (int i = tmp.length - 1; i > 0; i--) {
        x++;
        reactions = '${tmp[i]}$reactions';
        if (x == 3) reactions = '.$reactions';
      }
      reactions = '${tmp[0]}$reactions';
      icons = [];
      if (list[0] == widget.post.like) {
        icons.add('assets/images/reactions/like.png');
      } else if (list[0] == widget.post.haha) {
        icons.add('assets/images/reactions/haha.png');
      } else if (list[0] == widget.post.love) {
        icons.add('assets/images/reactions/love.png');
      } else if (list[0] == widget.post.lovelove) {
        icons.add('assets/images/reactions/care.png');
      } else if (list[0] == widget.post.wow) {
        icons.add('assets/images/reactions/wow.png');
      } else if (list[0] == widget.post.sad) {
        icons.add('assets/images/reactions/sad.png');
      } else if (list[0] == widget.post.angry) {
        icons.add('assets/images/reactions/angry.png');
      }

      if (list[1] == widget.post.like) {
        icons.add('assets/images/reactions/like.png');
      } else if (list[1] == widget.post.haha) {
        icons.add('assets/images/reactions/haha.png');
      } else if (list[1] == widget.post.love) {
        icons.add('assets/images/reactions/love.png');
      } else if (list[1] == widget.post.lovelove) {
        icons.add('assets/images/reactions/care.png');
      } else if (list[1] == widget.post.wow) {
        icons.add('assets/images/reactions/wow.png');
      } else if (list[1] == widget.post.sad) {
        icons.add('assets/images/reactions/sad.png');
      } else if (list[1] == widget.post.angry) {
        icons.add('assets/images/reactions/angry.png');
      }
    });
  }

  Future<void> reportPost(id) async {
    try {
      Map<String, dynamic> requestData = {
        "id": id,
        "subject": subject,
        "details": details,
      };

      var result = await callAPI('/report_post',
          requestData); // Sử dụng 'await' để đợi kết thúc của hàm callAPI
      await Future.delayed(const Duration(seconds: 1));
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
      setState(() {});
      // }
    } catch (error) {
      setState(() {});
    }
  }

  void changeSubject(String newSubject) {
    setState(() {
      subject = newSubject; // Thay đổi giá trị của subject khi text được click
    });
  }

  Future<void> deletePost(id) async {
    try {
      Map<String, dynamic> requestData = {
        "id": id,
      };

      var result = await callAPI('/delete_post',
          requestData); // Sử dụng 'await' để đợi kết thúc của hàm callAPI
      await Future.delayed(const Duration(seconds: 1));
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
      setState(() {});
      // }
    } catch (error) {
      setState(() {});
    }
  }

  Future<void> blockUser(id) async {
    try {
      Map<String, dynamic> requestData = {
        "user_id": id,
      };

      var result = await callAPI('/set_block',
          requestData); // Sử dụng 'await' để đợi kết thúc của hàm callAPI
      await Future.delayed(const Duration(seconds: 1));
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
      // }
    } catch (error) {
      // setState(() {});
    }
  }

  Future<void> likePost(id) async {
    try {
      Map<String, dynamic> requestData = {"id": id, "type": "0"};

      var result = await callAPI('/feel',
          requestData); // Sử dụng 'await' để đợi kết thúc của hàm callAPI
    } catch (error) {
      // setState(() {});
    }
  }

  Future<void> deleteLikePost(id) async {
    try {
      Map<String, dynamic> requestData = {
        "id": id,
      };

      var result = await callAPI('/delete_feel',
          requestData); // Sử dụng 'await' để đợi kết thúc của hàm callAPI

      // }
    } catch (error) {
      // setState(() {});
    }
  }

  @override
  void dispose() {
    if (widget.noDispose == null || widget.noDispose == false) {
      widget.controller.value?.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return postVisible
        ? Container(
            // height: MediaQuery.of(context).size.height * 1, // 60% chiều cao màn hình
            // width: MediaQuery.of(context).size.width * 1.1,
            color: widget.isDarkMode == true
                ? Colors.black.withOpacity(0.85)
                : Colors.white,
            padding: const EdgeInsets.only(
              top: 10,
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundImage:
                                NetworkImage(widget.post.user.avatar),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 2),
                                  child: Row(
                                    children: [
                                      Text(
                                        widget.post.user.name,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: widget.isDarkMode == true
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                      (widget.post.user.verified == true
                                          ? const Padding(
                                              padding: EdgeInsets.only(left: 5),
                                              child: Icon(
                                                Icons.verified,
                                                color: Colors.blue,
                                                size: 15,
                                              ),
                                            )
                                          : const SizedBox()),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  // width: 115,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        formatDate(widget.post.time),
                                        style: TextStyle(
                                          color: widget.isDarkMode == true
                                              ? Colors.white.withOpacity(0.5)
                                              : Colors.black54,
                                          fontSize: 14,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          top: 2,
                                          left: 5,
                                          right: 5,
                                        ),
                                        child: Icon(
                                          Icons.circle,
                                          size: 2,
                                          color: widget.isDarkMode == true
                                              ? Colors.white.withOpacity(0.5)
                                              : Colors.black54,
                                        ),
                                      ),
                                      Icon(
                                        widget.post.shareWith == 'public'
                                            ? Icons.public
                                            : widget.post.shareWith == 'friends'
                                                ? Icons.people
                                                : widget.post.shareWith ==
                                                        'friends-of-frends'
                                                    ? Icons.groups
                                                    : Icons.lock,
                                        color: widget.isDarkMode == true
                                            ? Colors.white.withOpacity(0.5)
                                            : Colors.black54,
                                        size: 14,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                            splashRadius: 20,
                            onPressed: () {
                              showModalBottomSheet(
                                isScrollControlled: true,
                                context: context,
                                builder: (context) {
                                  return DecoratedBox(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                      ),
                                      color: Colors.grey[300],
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          height: 4,
                                          width: 40,
                                          decoration: BoxDecoration(
                                            color: Colors.grey,
                                            shape: BoxShape.rectangle,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                          ),
                                          child: Column(
                                            children: [
                                              Material(
                                                color: Colors.transparent,
                                                child: InkWell(
                                                  onTap: () {},
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(10),
                                                    topRight:
                                                        Radius.circular(10),
                                                  ),
                                                  child: const ListTile(
                                                    titleAlignment:
                                                        ListTileTitleAlignment
                                                            .center,
                                                    tileColor: Colors.white,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(10),
                                                        topRight:
                                                            Radius.circular(10),
                                                      ),
                                                    ),
                                                    minLeadingWidth: 10,
                                                    leading: Icon(
                                                      Icons.add_circle_rounded,
                                                      size: 30,
                                                      color: Colors.black,
                                                    ),
                                                    title: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          'Hiển thị thêm',
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        Text(
                                                          'Bạn sẽ nhìn thấy nhiều bài viết tương tự hơn.',
                                                          style: TextStyle(
                                                            color:
                                                                Colors.black54,
                                                            fontSize: 14,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Material(
                                                color: Colors.transparent,
                                                child: InkWell(
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(10),
                                                    bottomRight:
                                                        Radius.circular(10),
                                                  ),
                                                  onTap: () {},
                                                  child: const ListTile(
                                                    titleAlignment:
                                                        ListTileTitleAlignment
                                                            .center,
                                                    tileColor: Colors.white,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        bottomLeft:
                                                            Radius.circular(10),
                                                        bottomRight:
                                                            Radius.circular(10),
                                                      ),
                                                    ),
                                                    minLeadingWidth: 10,
                                                    leading: Icon(
                                                      Icons.remove_circle,
                                                      size: 30,
                                                      color: Colors.black,
                                                    ),
                                                    title: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          'Ẩn bớt',
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        Text(
                                                          'Bạn sẽ nhìn thấy ít bài viết tương tự hơn.',
                                                          style: TextStyle(
                                                            color:
                                                                Colors.black54,
                                                            fontSize: 14,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Material(
                                                color: Colors.transparent,
                                                child: InkWell(
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(10),
                                                    topRight:
                                                        Radius.circular(10),
                                                  ),
                                                  onTap: () {},
                                                  child: const ListTile(
                                                    tileColor: Colors.white,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(10),
                                                        topRight:
                                                            Radius.circular(10),
                                                      ),
                                                    ),
                                                    minLeadingWidth: 10,
                                                    titleAlignment:
                                                        ListTileTitleAlignment
                                                            .center,
                                                    leading: Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                        horizontal: 2.5,
                                                      ),
                                                      child: ImageIcon(
                                                        AssetImage(
                                                            'assets/images/save-fill.png'),
                                                        size: 25,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    title: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          'Lưu bài viết',
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        Text(
                                                          'Thêm vào danh sách các mục đã lưu.',
                                                          style: TextStyle(
                                                            color:
                                                                Colors.black54,
                                                            fontSize: 14,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Material(
                                                color: Colors.transparent,
                                                child: InkWell(
                                                  onTap: () {
                                                    deletePost(widget.post.id);
                                                  },
                                                  child: ListTile(
                                                    titleAlignment:
                                                        ListTileTitleAlignment
                                                            .center,
                                                    tileColor: Colors.white,
                                                    minLeadingWidth: 10,
                                                    leading: Container(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                        horizontal: 5,
                                                        vertical: 2,
                                                      ),
                                                      decoration: BoxDecoration(
                                                        color: Colors.black,
                                                        shape:
                                                            BoxShape.rectangle,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      child: const Icon(
                                                        Icons.close,
                                                        size: 20,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    title: const Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          'Xóa video',
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        Text(
                                                          'Ẩn bớt các bài viết tương tự.',
                                                          style: TextStyle(
                                                            color:
                                                                Colors.black54,
                                                            fontSize: 14,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Material(
                                                color: Colors.transparent,
                                                child: InkWell(
                                                  onTap: () {
                                                    showModalBottomSheet(
                                                      isScrollControlled: true,
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return Container(
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              0.9,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(10),
                                                            child: Column(
                                                              children: [
                                                                Container(
                                                                  padding: EdgeInsets.only(
                                                                      top: 10.0,
                                                                      bottom:
                                                                          10.0),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    border:
                                                                        Border(
                                                                      bottom:
                                                                          BorderSide(
                                                                        color: Colors
                                                                            .grey, // Màu sắc của đường viền dưới
                                                                        width:
                                                                            1.0, // Độ dày của đường viền dưới
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  child:
                                                                      const Row(
                                                                    children: [
                                                                      Text(
                                                                        'Báo cáo bài viết',
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Colors.black,
                                                                          fontSize:
                                                                              22,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                const Row(
                                                                  children: [
                                                                    Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Padding(
                                                                          padding: EdgeInsets.only(
                                                                              top: 10.0,
                                                                              bottom: 10.0), // Padding top và bottom là 10
                                                                          child:
                                                                              Text(
                                                                            'Vui lòng chọn vấn đề để tiếp tục',
                                                                            style:
                                                                                TextStyle(
                                                                              fontWeight: FontWeight.bold,
                                                                              fontSize: 19,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding:
                                                                              EdgeInsets.only(bottom: 15),
                                                                          child:
                                                                              Text(
                                                                            'Bạn có thể báo cáo bài viết sau khi chọn vấn đề',
                                                                            style:
                                                                                TextStyle(fontSize: 17),
                                                                          ),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .only(
                                                                          right:
                                                                              10,
                                                                          bottom:
                                                                              10),
                                                                      child:
                                                                          InkWell(
                                                                        borderRadius:
                                                                            BorderRadius.circular(20),
                                                                        onTap:
                                                                            () {
                                                                          changeSubject(
                                                                              'Ảnh khỏa thân');
                                                                        },
                                                                        child:
                                                                            Container(
                                                                          padding:
                                                                              const EdgeInsets.symmetric(
                                                                            horizontal:
                                                                                10,
                                                                            vertical:
                                                                                8,
                                                                          ),
                                                                          decoration: (true)
                                                                              ? BoxDecoration(
                                                                                  color: Colors.blue.withOpacity(0.1),
                                                                                  shape: BoxShape.rectangle,
                                                                                  borderRadius: BorderRadius.circular(20),
                                                                                )
                                                                              : const BoxDecoration(),
                                                                          child:
                                                                              Text(
                                                                            'Ảnh khỏa thân',
                                                                            style:
                                                                                TextStyle(
                                                                              fontSize: 15,
                                                                              color: true ? Colors.blue[800] : Colors.black,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .only(
                                                                          right:
                                                                              10,
                                                                          bottom:
                                                                              10),
                                                                      child:
                                                                          InkWell(
                                                                        borderRadius:
                                                                            BorderRadius.circular(20),
                                                                        onTap:
                                                                            () {
                                                                          changeSubject(
                                                                              'Bạo lực');
                                                                        },
                                                                        child:
                                                                            Container(
                                                                          padding:
                                                                              const EdgeInsets.symmetric(
                                                                            horizontal:
                                                                                10,
                                                                            vertical:
                                                                                8,
                                                                          ),
                                                                          decoration: (true)
                                                                              ? BoxDecoration(
                                                                                  color: Colors.blue.withOpacity(0.1),
                                                                                  shape: BoxShape.rectangle,
                                                                                  borderRadius: BorderRadius.circular(20),
                                                                                )
                                                                              : const BoxDecoration(),
                                                                          child:
                                                                              Text(
                                                                            'Bạo lực',
                                                                            style:
                                                                                TextStyle(
                                                                              fontSize: 15,
                                                                              color: true ? Colors.blue[800] : Colors.black,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .only(
                                                                          right:
                                                                              10,
                                                                          bottom:
                                                                              10),
                                                                      child:
                                                                          InkWell(
                                                                        borderRadius:
                                                                            BorderRadius.circular(20),
                                                                        onTap:
                                                                            () {
                                                                          changeSubject(
                                                                              'Quấy rối');
                                                                        },
                                                                        child:
                                                                            Container(
                                                                          padding:
                                                                              const EdgeInsets.symmetric(
                                                                            horizontal:
                                                                                10,
                                                                            vertical:
                                                                                8,
                                                                          ),
                                                                          decoration: (true)
                                                                              ? BoxDecoration(
                                                                                  color: Colors.blue.withOpacity(0.1),
                                                                                  shape: BoxShape.rectangle,
                                                                                  borderRadius: BorderRadius.circular(20),
                                                                                )
                                                                              : const BoxDecoration(),
                                                                          child:
                                                                              Text(
                                                                            'Quấy rối',
                                                                            style:
                                                                                TextStyle(
                                                                              fontSize: 15,
                                                                              color: true ? Colors.blue[800] : Colors.black,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .only(
                                                                          right:
                                                                              10,
                                                                          bottom:
                                                                              10),
                                                                      child:
                                                                          InkWell(
                                                                        borderRadius:
                                                                            BorderRadius.circular(20),
                                                                        onTap:
                                                                            () {
                                                                          changeSubject(
                                                                              'Tự tử/ Tự gây thương tích');
                                                                        },
                                                                        child:
                                                                            Container(
                                                                          padding:
                                                                              const EdgeInsets.symmetric(
                                                                            horizontal:
                                                                                10,
                                                                            vertical:
                                                                                8,
                                                                          ),
                                                                          decoration: (true)
                                                                              ? BoxDecoration(
                                                                                  color: Colors.blue.withOpacity(0.1),
                                                                                  shape: BoxShape.rectangle,
                                                                                  borderRadius: BorderRadius.circular(20),
                                                                                )
                                                                              : const BoxDecoration(),
                                                                          child:
                                                                              Text(
                                                                            'Tự tử/ Tự gây thương tích',
                                                                            style:
                                                                                TextStyle(
                                                                              fontSize: 15,
                                                                              color: true ? Colors.blue[800] : Colors.black,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .only(
                                                                          right:
                                                                              10,
                                                                          bottom:
                                                                              10),
                                                                      child:
                                                                          InkWell(
                                                                        borderRadius:
                                                                            BorderRadius.circular(20),
                                                                        onTap:
                                                                            () {
                                                                          changeSubject(
                                                                              'Tin giả');
                                                                        },
                                                                        child:
                                                                            Container(
                                                                          padding:
                                                                              const EdgeInsets.symmetric(
                                                                            horizontal:
                                                                                10,
                                                                            vertical:
                                                                                8,
                                                                          ),
                                                                          decoration: (true)
                                                                              ? BoxDecoration(
                                                                                  color: Colors.blue.withOpacity(0.1),
                                                                                  shape: BoxShape.rectangle,
                                                                                  borderRadius: BorderRadius.circular(20),
                                                                                )
                                                                              : const BoxDecoration(),
                                                                          child:
                                                                              Text(
                                                                            'Tin giả',
                                                                            style:
                                                                                TextStyle(
                                                                              fontSize: 15,
                                                                              color: true ? Colors.blue[800] : Colors.black,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .only(
                                                                          right:
                                                                              10,
                                                                          bottom:
                                                                              10),
                                                                      child:
                                                                          InkWell(
                                                                        borderRadius:
                                                                            BorderRadius.circular(20),
                                                                        onTap:
                                                                            () {
                                                                          changeSubject(
                                                                              'Spam');
                                                                        },
                                                                        child:
                                                                            Container(
                                                                          padding:
                                                                              const EdgeInsets.symmetric(
                                                                            horizontal:
                                                                                10,
                                                                            vertical:
                                                                                8,
                                                                          ),
                                                                          decoration: (true)
                                                                              ? BoxDecoration(
                                                                                  color: Colors.blue.withOpacity(0.1),
                                                                                  shape: BoxShape.rectangle,
                                                                                  borderRadius: BorderRadius.circular(20),
                                                                                )
                                                                              : const BoxDecoration(),
                                                                          child:
                                                                              Text(
                                                                            'Spam',
                                                                            style:
                                                                                TextStyle(
                                                                              fontSize: 15,
                                                                              color: true ? Colors.blue[800] : Colors.black,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .only(
                                                                          right:
                                                                              10,
                                                                          bottom:
                                                                              10),
                                                                      child:
                                                                          InkWell(
                                                                        borderRadius:
                                                                            BorderRadius.circular(20),
                                                                        onTap:
                                                                            () {
                                                                          changeSubject(
                                                                              'Bán hàng trái phép');
                                                                        },
                                                                        child:
                                                                            Container(
                                                                          padding:
                                                                              const EdgeInsets.symmetric(
                                                                            horizontal:
                                                                                10,
                                                                            vertical:
                                                                                8,
                                                                          ),
                                                                          decoration: (true)
                                                                              ? BoxDecoration(
                                                                                  color: Colors.blue.withOpacity(0.1),
                                                                                  shape: BoxShape.rectangle,
                                                                                  borderRadius: BorderRadius.circular(20),
                                                                                )
                                                                              : const BoxDecoration(),
                                                                          child:
                                                                              Text(
                                                                            'Bán hàng trái phép',
                                                                            style:
                                                                                TextStyle(
                                                                              fontSize: 15,
                                                                              color: true ? Colors.blue[800] : Colors.black,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .only(
                                                                          right:
                                                                              10,
                                                                          bottom:
                                                                              10),
                                                                      child:
                                                                          InkWell(
                                                                        borderRadius:
                                                                            BorderRadius.circular(20),
                                                                        onTap:
                                                                            () {
                                                                          changeSubject(
                                                                              'Ngôn ngữ gây thù ghét');
                                                                        },
                                                                        child:
                                                                            Container(
                                                                          padding:
                                                                              const EdgeInsets.symmetric(
                                                                            horizontal:
                                                                                10,
                                                                            vertical:
                                                                                8,
                                                                          ),
                                                                          decoration: (true)
                                                                              ? BoxDecoration(
                                                                                  color: Colors.blue.withOpacity(0.1),
                                                                                  shape: BoxShape.rectangle,
                                                                                  borderRadius: BorderRadius.circular(20),
                                                                                )
                                                                              : const BoxDecoration(),
                                                                          child:
                                                                              Text(
                                                                            'Ngôn ngữ gây thù ghét',
                                                                            style:
                                                                                TextStyle(
                                                                              fontSize: 15,
                                                                              color: true ? Colors.blue[800] : Colors.black,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .only(
                                                                          right:
                                                                              10,
                                                                          bottom:
                                                                              30),
                                                                      child:
                                                                          InkWell(
                                                                        borderRadius:
                                                                            BorderRadius.circular(20),
                                                                        onTap:
                                                                            () {
                                                                          changeSubject(
                                                                              'Khủng bố');
                                                                        },
                                                                        child:
                                                                            Container(
                                                                          padding:
                                                                              const EdgeInsets.symmetric(
                                                                            horizontal:
                                                                                10,
                                                                            vertical:
                                                                                8,
                                                                          ),
                                                                          decoration: (true)
                                                                              ? BoxDecoration(
                                                                                  color: Colors.blue.withOpacity(0.1),
                                                                                  shape: BoxShape.rectangle,
                                                                                  borderRadius: BorderRadius.circular(20),
                                                                                )
                                                                              : const BoxDecoration(),
                                                                          child:
                                                                              Text(
                                                                            'Khủng bố',
                                                                            style:
                                                                                TextStyle(
                                                                              fontSize: 15,
                                                                              color: true ? Colors.blue[800] : Colors.black,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .only(
                                                                          right:
                                                                              10,
                                                                          bottom:
                                                                              30),
                                                                      child:
                                                                          InkWell(
                                                                        borderRadius:
                                                                            BorderRadius.circular(20),
                                                                        onTap:
                                                                            () {
                                                                          changeSubject(
                                                                              'Vấn đề khác');
                                                                        },
                                                                        child:
                                                                            Container(
                                                                          padding:
                                                                              const EdgeInsets.symmetric(
                                                                            horizontal:
                                                                                10,
                                                                            vertical:
                                                                                8,
                                                                          ),
                                                                          decoration: (true)
                                                                              ? BoxDecoration(
                                                                                  color: Colors.blue.withOpacity(0.1),
                                                                                  shape: BoxShape.rectangle,
                                                                                  borderRadius: BorderRadius.circular(20),
                                                                                )
                                                                              : const BoxDecoration(),
                                                                          child:
                                                                              Text(
                                                                            'Vấn đề khác',
                                                                            style:
                                                                                TextStyle(
                                                                              fontSize: 15,
                                                                              color: true ? Colors.blue[800] : Colors.black,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    Expanded(
                                                                        child:
                                                                            (TextField(
                                                                      maxLines:
                                                                          4,
                                                                      decoration:
                                                                          InputDecoration(
                                                                        border:
                                                                            OutlineInputBorder(),
                                                                        hintText:
                                                                            'Mô tả chi tiết...',
                                                                      ),
                                                                      onChanged:
                                                                          (value) {
                                                                        setState(
                                                                            () {
                                                                          details =
                                                                              value;
                                                                        });
                                                                      },
                                                                    ))),
                                                                  ],
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    Expanded(
                                                                      child:
                                                                          ElevatedButton(
                                                                        style: ElevatedButton
                                                                            .styleFrom(
                                                                          backgroundColor:
                                                                              Color(0xFF1878F3),
                                                                          shadowColor:
                                                                              Color(0xFF1878F3),
                                                                          side:
                                                                              const BorderSide(
                                                                            color:
                                                                                Colors.black12,
                                                                            width:
                                                                                0.5,
                                                                          ),
                                                                        ),
                                                                        onPressed:
                                                                            () {
                                                                          reportPost(widget
                                                                              .post
                                                                              .id);
                                                                        },
                                                                        child:
                                                                            const Text(
                                                                          'Xác nhận',
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                17,
                                                                            color:
                                                                                Colors.white,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    );
                                                  },
                                                  child: ListTile(
                                                    tileColor: Colors.white,
                                                    minLeadingWidth: 10,
                                                    titleAlignment:
                                                        ListTileTitleAlignment
                                                            .center,
                                                    leading: const Icon(
                                                      Icons.feedback_rounded,
                                                      size: 30,
                                                      color: Colors.black,
                                                    ),
                                                    title: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        const Text(
                                                          'Báo cáo bài viết',
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          height: 5,
                                                        ),
                                                        Text(
                                                          'Chúng tôi sẽ không cho ${widget.post.user.name} biết ai đã báo cáo.',
                                                          style:
                                                              const TextStyle(
                                                            color:
                                                                Colors.black54,
                                                            fontSize: 14,
                                                            height: 1.4,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Material(
                                                color: Colors.transparent,
                                                child: InkWell(
                                                  onTap: () {},
                                                  child: const ListTile(
                                                    titleAlignment:
                                                        ListTileTitleAlignment
                                                            .center,
                                                    tileColor: Colors.white,
                                                    minLeadingWidth: 10,
                                                    leading: ImageIcon(
                                                      AssetImage(
                                                          'assets/images/noti-fill.png'),
                                                      color: Colors.black,
                                                      size: 30,
                                                    ),
                                                    title: Text(
                                                      'Bật thông báo về bài viết này',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Material(
                                                color: Colors.transparent,
                                                child: InkWell(
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(10),
                                                    bottomRight:
                                                        Radius.circular(10),
                                                  ),
                                                  onTap: () {},
                                                  child: const ListTile(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        bottomLeft:
                                                            Radius.circular(10),
                                                        bottomRight:
                                                            Radius.circular(10),
                                                      ),
                                                    ),
                                                    titleAlignment:
                                                        ListTileTitleAlignment
                                                            .center,
                                                    tileColor: Colors.white,
                                                    minLeadingWidth: 10,
                                                    leading: Icon(
                                                      Icons.file_copy_rounded,
                                                      color: Colors.black,
                                                      size: 30,
                                                    ),
                                                    title: Text(
                                                      'Sao chép liên kết',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Material(
                                                color: Colors.transparent,
                                                child: InkWell(
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(10),
                                                    topRight:
                                                        Radius.circular(10),
                                                  ),
                                                  onTap: () {},
                                                  child: ListTile(
                                                    shape:
                                                        const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(10),
                                                        topRight:
                                                            Radius.circular(10),
                                                      ),
                                                    ),
                                                    tileColor: Colors.white,
                                                    minLeadingWidth: 10,
                                                    titleAlignment:
                                                        ListTileTitleAlignment
                                                            .center,
                                                    leading: const Icon(
                                                      Icons.star_rounded,
                                                      size: 30,
                                                      color: Colors.black,
                                                    ),
                                                    title: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          'Thêm ${widget.post.user.name} vào mục Yêu thích',
                                                          style:
                                                              const TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          height: 5,
                                                        ),
                                                        const Text(
                                                          'Ưu tiên bài viết của họ trong Bảng tin',
                                                          style: TextStyle(
                                                            color:
                                                                Colors.black54,
                                                            fontSize: 14,
                                                            height: 1.4,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Material(
                                                color: Colors.transparent,
                                                child: InkWell(
                                                  onTap: () {},
                                                  child: ListTile(
                                                    tileColor: Colors.white,
                                                    minLeadingWidth: 10,
                                                    titleAlignment:
                                                        ListTileTitleAlignment
                                                            .center,
                                                    leading: const Icon(
                                                      Icons.access_time_filled,
                                                      size: 30,
                                                      color: Colors.black,
                                                    ),
                                                    title: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          'Tạm ẩn ${widget.post.user.name} trong 30 ngày.',
                                                          style:
                                                              const TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          height: 5,
                                                        ),
                                                        const Text(
                                                          'Tạm thời không nhìn thấy bài viết nữa.',
                                                          style: TextStyle(
                                                            color:
                                                                Colors.black54,
                                                            fontSize: 14,
                                                            height: 1.4,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Material(
                                                color: Colors.transparent,
                                                child: InkWell(
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(10),
                                                    bottomRight:
                                                        Radius.circular(10),
                                                  ),
                                                  onTap: () {
                                                    blockUser(
                                                        widget.post.user.id);
                                                  },
                                                  child: ListTile(
                                                    shape:
                                                        const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        bottomLeft:
                                                            Radius.circular(10),
                                                        bottomRight:
                                                            Radius.circular(10),
                                                      ),
                                                    ),
                                                    tileColor: Colors.white,
                                                    minLeadingWidth: 10,
                                                    titleAlignment:
                                                        ListTileTitleAlignment
                                                            .center,
                                                    leading: const ImageIcon(
                                                      AssetImage(
                                                          'assets/images/block.png'),
                                                      size: 30,
                                                      color: Colors.black,
                                                    ),
                                                    title: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          'Chặn ${widget.post.user.name}',
                                                          style:
                                                              const TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          height: 5,
                                                        ),
                                                        const Text(
                                                          'Không xem bài viết của Người này nữa.',
                                                          style: TextStyle(
                                                            color:
                                                                Colors.black54,
                                                            fontSize: 14,
                                                            height: 1.4,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Material(
                                                color: Colors.transparent,
                                                child: InkWell(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  onTap: () {},
                                                  child: ListTile(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    tileColor: Colors.white,
                                                    minLeadingWidth: 10,
                                                    titleAlignment:
                                                        ListTileTitleAlignment
                                                            .center,
                                                    leading: const Icon(
                                                      Icons.view_list_rounded,
                                                      size: 30,
                                                      color: Colors.black,
                                                    ),
                                                    title: const Text(
                                                      'Quản lý bảng feed',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                            icon: const Icon(Icons.more_horiz_rounded),
                          ),
                          if (widget.post.type != 'memory')
                            IconButton(
                              splashRadius: 20,
                              onPressed: () {
                                setState(() {
                                  postVisible = false;
                                });
                              },
                              icon: const Icon(Icons.close),
                            ),
                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: PostContent(
                    text: widget.post.content!,
                    textColor:
                        widget.isDarkMode == true ? Colors.white : Colors.black,
                  ),
                ),
                widget.controller.value!.value.isInitialized
                    ? GestureDetector(
                        onTap: () {
                          if (widget.isDarkMode == null ||
                              widget.isDarkMode == false) {
                            widget.controller.value!.pause();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => WatchOthersScreen(
                                  controllerInit: widget.controller,
                                  postInit: widget.post,
                                ),
                              ),
                            );
                          }
                        },
                        child: Stack(
                          children: [
                            AspectRatio(
                              aspectRatio:
                                  widget.controller.value!.value.aspectRatio,
                              child: Stack(
                                children: [
                                  VideoPlayer(
                                    widget.controller.value!,
                                    key: widget.videoKey,
                                  ),
                                  if (widget.isDarkMode == true)
                                    ControlsOverlay(
                                        controller: widget.controller.value!),
                                ],
                              ),
                            ),
                            if (widget.isDarkMode == null ||
                                widget.isDarkMode == false)
                              Positioned(
                                top: 5,
                                right: 5,
                                child: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.picture_in_picture_alt_rounded,
                                    color: Colors.white,
                                    size: 25,
                                  ),
                                ),
                              ),
                            if (widget.isDarkMode == null ||
                                widget.isDarkMode == false)
                              Positioned(
                                bottom: 5,
                                right: 5,
                                child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      if (widget
                                              .controller.value!.value.volume >
                                          0) {
                                        widget.controller.value!.setVolume(0);
                                      } else {
                                        widget.controller.value!.setVolume(1.0);
                                      }
                                    });
                                  },
                                  icon:
                                      widget.controller.value!.value.volume > 0
                                          ? const Icon(
                                              Icons.volume_up_outlined,
                                              color: Colors.white,
                                              size: 25,
                                            )
                                          : const Icon(
                                              Icons.volume_off_outlined,
                                              color: Colors.white,
                                              size: 25,
                                            ),
                                ),
                              ),
                          ],
                        ),
                      )
                    : const CircularProgressIndicator(
                        color: Colors.black,
                        strokeWidth: 5,
                      ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                    bottom: 8,
                    left: 10,
                    right: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 42,
                            child: Stack(
                              children: [
                                const SizedBox(
                                  width: 24,
                                  height: 24,
                                ),
                                Positioned(
                                  top: 2,
                                  left: 18,
                                  child: Image.asset(
                                    icons[1],
                                    width: 20,
                                  ),
                                ),
                                Positioned(
                                  top: 0,
                                  left: 0,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: widget.isDarkMode == true
                                              ? Colors.black.withOpacity(0.85)
                                              : Colors.white,
                                          width: 2,
                                        )),
                                    child: Image.asset(
                                      icons[0],
                                      width: 20,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            reactions,
                            style: TextStyle(
                              color: widget.isDarkMode == true
                                  ? Colors.white
                                  : Colors.black54,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                context, CommentScreen.routeName,
                                arguments: widget.post);
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: 10,
                              bottom: 8,
                              left: 15,
                              right: 15,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 42,
                                      child: Stack(
                                        children: [
                                          const SizedBox(
                                            width: 24,
                                            height: 24,
                                          ),
                                          Positioned(
                                            top: 2,
                                            left: 18,
                                            child: Image.asset(
                                              icons[1],
                                              width: 20,
                                            ),
                                          ),
                                          Positioned(
                                            top: 0,
                                            left: 0,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                    color: Colors.white,
                                                    width: 2,
                                                  )),
                                              child: Image.asset(
                                                icons[0],
                                                width: 20,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Text(
                                      // reactions,
                                      widget.post.feel.toString(),
                                      style: const TextStyle(
                                        color: Colors.black54,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    widget.post.comment != null
                                        ? Text(
                                            '${widget.post.comment} bình luận',
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black54,
                                            ),
                                          )
                                        : const SizedBox(),
                                    (widget.post.comment != null &&
                                            widget.post.share != null)
                                        ? const Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 5),
                                            child: Icon(
                                              Icons.circle,
                                              size: 3,
                                              color: Colors.black54,
                                            ),
                                          )
                                        : const SizedBox(),
                                    widget.post.share != null
                                        ? Text(
                                            '${widget.post.share} lượt chia sẻ',
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black54,
                                            ),
                                          )
                                        : const SizedBox(),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Divider(
                    color: widget.isDarkMode == true
                        ? Colors.white
                        : Colors.black38,
                    height: 0,
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    (widget.post.isFelt == -1)
                        ? (InkWell(
                            onTap: () {
                              likePost(widget.post.id);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 11.5,
                              ),
                              alignment: Alignment.center,
                              width: (MediaQuery.of(context).size.width) / 3,
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.thumb_up_outlined,
                                    size: 24.0,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Text(
                                      'Thích',
                                      style: TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ))
                        : (InkWell(
                            onTap: () {
                              deleteLikePost(widget.post.id);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 11.5,
                              ),
                              alignment: Alignment.center,
                              width: (MediaQuery.of(context).size.width) / 3,
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.thumb_up,
                                    color: Color(0xFF1878F3),
                                    size: 24.0,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Text(
                                      'Thích',
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Color(0xFF1878F3)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                        ),
                        alignment: Alignment.center,
                        width: (MediaQuery.of(context).size.width) / 3,
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ImageIcon(
                              AssetImage('assets/images/comment.png'),
                              size: 22,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Text(
                                'Bình luận',
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                        ),
                        alignment: Alignment.center,
                        width: (MediaQuery.of(context).size.width) / 3,
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ImageIcon(
                              AssetImage('assets/images/share.png'),
                              size: 27,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Text(
                                'Chia sẻ',
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          )
        : (Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                const Row(
                  children: [
                    Icon(
                      Icons.visibility_off_rounded,
                      color: GlobalVariables.secondaryColor,
                      size: 14,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Đã ẩn',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Việc ẩn bài viết giúp Facebook cá nhân hóa Bảng feed của bạn.',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 17,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          postVisible = true;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[300],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        shadowColor: Colors.transparent,
                      ),
                      child: const Text(
                        'Hoàn tác',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                const Divider(
                  color: Colors.black12,
                  thickness: 0.5,
                  height: 20,
                ),
                Row(
                  children: [
                    DecoratedBox(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.black12,
                          width: 0.5,
                        ),
                      ),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                          widget.post.user.avatar,
                        ),
                        radius: 15,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Tạm ẩn ${widget.post.user.name} trong 30 ngày',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Row(
                  children: [
                    Icon(
                      Icons.feedback_rounded,
                      color: Colors.black,
                      size: 30,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Báo cáo bài viết',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Row(
                  children: [
                    Icon(
                      Icons.view_list_rounded,
                      color: Colors.black,
                      size: 30,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Quản lý Bảng feed',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ));
  }
}
