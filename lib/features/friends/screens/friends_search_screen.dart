import 'dart:convert';
import 'dart:math';

import 'package:anti_facebook_app/constants/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../models/user.dart';
import '../../personal-page/screens/personal_page_screen.dart';

class FriendsSearchScreen extends StatefulWidget {
  static const String routeName = '/friends-search-screen';
  const FriendsSearchScreen({super.key});

  @override
  State<FriendsSearchScreen> createState() => _FriendsSearchScreenState();
}

class FriendRequest {
  final User user;
  final String time;
  final int? mutualFriends;
  final int? monthStart;
  final int? yearStart;
  final User? f1;
  final User? f2;
  FriendRequest({
    required this.user,
    required this.time,
    this.mutualFriends,
    this.monthStart,
    this.yearStart,
    this.f1,
    this.f2,
  });
}

class _FriendsSearchScreenState extends State<FriendsSearchScreen> {
  final today = DateTime.now();

  List<FriendRequest> friends = [];
  final TextEditingController searchController = TextEditingController();

  final String apiGetUserFriend =
      'https://it4788.catan.io.vn/get_user_friends';
  final String apiSetRequestFriend =
      'https://it4788.catan.io.vn/set_request_friend';
  final String apiUnfriend =
      'https://it4788.catan.io.vn/unfriend';
  final String authToken = GlobalVariables.token;
  int totalFriend = 0;
  Future getData() async {
    var data = {
      "index": "0",
      "count": "5",
      "user_id": "375"
    };

    try {
      var response = await http.post(
        Uri.parse(apiGetUserFriend),
        body: json.encode(data),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $authToken',
        },
      );

      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);
        print(responseData);
        Map<String, dynamic> data = responseData['data'];
        List<dynamic> requests = data['friends'];
        int total = int.parse(data['total']);
        List<FriendRequest> tempFriendRequests = [];
        for (var request in requests) {
          String username = request['username'];
          String id = request['id'];
          String avatar = request['avatar'];
          int sameFriends = int.parse(request['same_friends']);
          String created = request['created'];
          DateTime dateTime = DateTime.parse(created);
          int month = dateTime.month;
          int year = dateTime.year;
          DateTime now = DateTime.now();
          Duration difference = now.difference(dateTime);

          String formattedTime = formatTimeDifference(difference);
          FriendRequest friendRequest = FriendRequest(
            user: User(name: username, avatar: avatar, userId: id),
            time: formattedTime,
            mutualFriends: sameFriends,
            monthStart: month,
            yearStart: year,
          );
          tempFriendRequests.add(friendRequest);
        }

        setState(() {
          friends = tempFriendRequests;
          totalFriend = total;
        });

        return responseData;
      } else {
        throw Exception(
            'Failed to get friends. Status code: ${response.statusCode} ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to get friends');
    }
  }
  String formatTimeDifference(Duration difference) {
    if (difference.inMinutes < 60) {
      return "${difference.inMinutes} phút";
    } else if (difference.inHours < 24) {
      return "${difference.inHours} giờ";
    } else if (difference.inDays < 7) {
      return "${difference.inDays} ngày";
    } else if (difference.inDays < 30) {
      int weeks = (difference.inDays / 7).floor();
      return "$weeks tuần";
    } else if (difference.inDays < 365) {
      int months = (difference.inDays / 30).floor();
      return "$months tháng";
    } else {
      int years = (difference.inDays / 365).floor();
      return "$years năm";
    }
  }
  Future unFriend(String? userId, int index) async{
    var data = {"user_id": userId};

    try {
      var response = await http.post(
        Uri.parse(apiUnfriend),
        body: json.encode(data),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $authToken',
        },
      );

      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);
        if (responseData['message'] == "OK") {
          setState(() {
            friends.removeAt(index);
          });
        }
        return responseData;
      } else {
        throw Exception(
            'Failed to set request friend. Status code: ${response.statusCode} ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to set request friend');
    }
  }
  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(110),
        child: AppBar(
          automaticallyImplyLeading: false,
          titleSpacing: 0,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: Column(
              children: [
                Container(
                  color: Colors.black12,
                  height: 0.5,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: searchController,
                          decoration: InputDecoration(
                            hintText: 'Tìm kiếm bạn bè',
                            hintStyle: const TextStyle(
                              fontSize: 14,
                            ),
                            prefixIcon: const Icon(
                              Icons.search_rounded,
                              color: Colors.grey,
                            ),
                            border: InputBorder.none,
                            filled: true,
                            fillColor: Colors.grey[200],
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            alignLabelWithHint: true,
                            contentPadding: const EdgeInsets.all(0),
                          ),
                          cursorColor: Colors.black,
                          textAlignVertical: TextAlignVertical.center,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            splashRadius: 20,
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 25,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Bạn bè',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                ),
                textAlign: TextAlign.center,
              ),
              IconButton(
                onPressed: () {},
                splashRadius: 20,
                icon: const Icon(
                  Icons.search_rounded,
                  color: Colors.black,
                  size: 30,
                ),
              )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 15,
                top: 15,
                bottom: 15,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "$totalFriend bạn bè",
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 15,
                    ),
                    child: InkWell(
                      onTap: () {
                        showModalBottomSheet<void>(
                          context: context,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                          ),
                          builder: (BuildContext context) {
                            return DecoratedBox(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ListTile(
                                    minLeadingWidth: 10,
                                    leading: ImageIcon(
                                      AssetImage('assets/images/stars.png'),
                                      size: 30,
                                      color: Colors.black,
                                    ),
                                    title: Text(
                                      'Mặc định',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  ListTile(
                                    minLeadingWidth: 10,
                                    leading: ImageIcon(
                                      AssetImage('assets/images/sortup.png'),
                                      size: 30,
                                      color: Colors.black,
                                    ),
                                    title: Text(
                                      'Bạn bè mới nhất trước tiên',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  ListTile(
                                    minLeadingWidth: 10,
                                    leading: ImageIcon(
                                      AssetImage('assets/images/sortdown.png'),
                                      size: 30,
                                      color: Colors.black,
                                    ),
                                    title: Text(
                                      'Bạn bè lâu năm nhất trước tiên',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: Text(
                        'Sắp xếp',
                        style: TextStyle(
                          color: Colors.blue[700],
                          fontSize: 18,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            for (int i = 0; i < friends.length; i++)
              Padding(
                padding: const EdgeInsets.only(
                  left: 15,
                  top: 10,
                  bottom: 10,
                  right: 0,
                ),
                child: Row(
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
                        backgroundImage: NetworkImage(friends[i].user.avatar),
                        radius: 30,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                PersonalPageScreen.routeName,
                                arguments: friends[i].user,
                              );
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  friends[i].user.name,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                if (friends[i].mutualFriends != null &&
                                    friends[i].mutualFriends! > 0)
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 2,
                                    ),
                                    child: Text(
                                      '${friends[i].mutualFriends} bạn chung',
                                      style: const TextStyle(
                                        color: Colors.black54,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              showModalBottomSheet<void>(
                                context: context,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                ),
                                builder: (BuildContext context) {
                                  return DecoratedBox(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 15,
                                            vertical: 10,
                                          ),
                                          child: Row(
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
                                                    friends[i].user.avatar,
                                                  ),
                                                  radius: 25,
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    friends[i].user.name,
                                                    style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 18,
                                                      fontWeight:
                                                      FontWeight.bold,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    'Là bạn bè từ tháng ${friends[i].monthStart} năm ${friends[i].yearStart}',
                                                    style: const TextStyle(
                                                      color: Colors.black54,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          color: Colors.black12,
                                          height: 0.5,
                                          width: double.infinity,
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        ListTile(
                                          minLeadingWidth: 10,
                                          leading: const ImageIcon(
                                            AssetImage(
                                                'assets/images/message-outlined.png'),
                                            size: 25,
                                            color: Colors.black,
                                          ),
                                          title: Text(
                                            'Nhắn tin cho ${friends[i].user.name}',
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                        ListTile(
                                          minLeadingWidth: 10,
                                          leading: const ImageIcon(
                                            AssetImage(
                                                'assets/images/unfollow.png'),
                                            size: 25,
                                            color: Colors.black,
                                          ),
                                          title: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Bỏ theo dõi ${friends[i].user.name}',
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              const Text(
                                                'Không nhìn thấy bài viết nữa nhưng vẫn là bạn bè.',
                                                style: TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        ListTile(
                                          minLeadingWidth: 10,
                                          leading: const ImageIcon(
                                            AssetImage(
                                                'assets/images/block.png'),
                                            size: 25,
                                            color: Colors.black,
                                          ),
                                          title: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Chặn trang cá nhân của ${friends[i].user.name}',
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                '${friends[i].user.name} sẽ không thể nhìn thấy bạn hoặc liên hệ với bạn trên Facebook.',
                                                style: const TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        ListTile(
                                          minLeadingWidth: 10,
                                          leading: const ImageIcon(
                                            AssetImage(
                                                'assets/images/unfriend.png'),
                                            size: 25,
                                            color: Colors.red,
                                          ),
                                          title: GestureDetector(
                                            onTap: () {
                                              print("confirm unfriend");
                                              Navigator.of(context).pop();
                                              showDialog(
                                                context: context,
                                                builder: (BuildContext context) {
                                                  return AlertDialog(
                                                    title: const Text("Hủy kết bạn"),
                                                    content: Text("Bạn có chắc chắn muốn hủy kết bạn với ${friends[i].user.name}?"),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () {
                                                          unFriend(friends[i].user.userId, i);
                                                          Navigator.of(context).pop();
                                                        },
                                                        child: const Text("Đồng ý", style: TextStyle(color: Colors.black),),
                                                      ),
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.of(context).pop();
                                                        },
                                                        child: const Text("Hủy bỏ",  style: TextStyle(color: Colors.black)),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            },
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Hủy kết bạn với ${friends[i].user.name}',
                                                  style: const TextStyle(
                                                    color: Colors.red,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  'Hủy kết bạn với ${friends[i].user.name}',
                                                  style: const TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                            padding: const EdgeInsets.all(0),
                            splashRadius: 23,
                            icon: const Icon(
                              Icons.more_horiz_rounded,
                              color: Colors.black87,
                              size: 25,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }
}