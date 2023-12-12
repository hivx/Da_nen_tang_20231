import 'dart:convert';

import 'package:anti_facebook_app/features/friends/screens/friends_search_screen.dart';
import 'package:anti_facebook_app/features/friends/screens/friends_suggest_screen.dart';
import 'package:flutter/material.dart';

import '../../../models/user.dart';
import 'package:http/http.dart' as http;

class FriendsScreen extends StatefulWidget {
  static const String routeName = '/friends-screen';
  const FriendsScreen({super.key});

  @override
  State<FriendsScreen> createState() => _FriendsScreenState();
}

class FriendRequest {
  final User user;
  final String time;
  final int? mutualFriends;
  final User? f1;
  final User? f2;
  FriendRequest({
    required this.user,
    required this.time,
    this.mutualFriends,
    this.f1,
    this.f2,
  });
}

class _FriendsScreenState extends State<FriendsScreen> {
  final today = DateTime.now();
  List<FriendRequest> friends = [];
  final String apiGetRequestFriend =
      'https://it4788.catan.io.vn/get_requested_friends';
  final String apiSetAcceptFriend =
      'https://it4788.catan.io.vn/set_accept_friend';
  final String authToken =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Mzc1LCJkZXZpY2VfaWQiOiJzdHJpbmciLCJpYXQiOjE3MDIzMTMzNDd9.wFUtXedv902h_EXRUcXZCIFjVBX1vcLYNEl7blbgkqI";
  int totalRequestFriend = 0;

  Future getData() async {
    var data = {"index": "0", "count": "5"};

    try {
      var response = await http.post(
        Uri.parse(apiGetRequestFriend),
        body: json.encode(data),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $authToken',
        },
      );

      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);
        Map<String, dynamic> data = responseData['data'];
        List<dynamic> requests = data['requests'];
        int total = int.parse(data['total']);
        List<FriendRequest> tempFriendRequests = [];
        for (var request in requests) {
          String username = request['username'];
          String id = request['id'];
          String avatar = request['avatar'];
          int sameFriends = int.parse(request['same_friends']);
          String created = request['created'];
          DateTime dateTime = DateTime.parse(created);
          DateTime now = DateTime.now();
          Duration difference = now.difference(dateTime);

          String formattedTime = formatTimeDifference(difference);
          FriendRequest friendRequest = FriendRequest(
              user: User(name: username, avatar: avatar, userId: id),
              time: formattedTime,
              mutualFriends: sameFriends);
          tempFriendRequests.add(friendRequest);
        }

        setState(() {
          friends = tempFriendRequests;
          totalRequestFriend = total;
        });

        return responseData;
      } else {
        throw Exception(
            'Failed to get data. Status code: ${response.statusCode} ${response.body}');
      }
    } catch (e) {
      print('Error4: $e');
      throw Exception('Failed to get data');
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

  Future setAcceptFriend(String? userId, String isAccept, int index) async {
    var data = {"user_id": userId, "is_accept": isAccept};

    try {
      var response = await http.post(
        Uri.parse(apiSetAcceptFriend),
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
            'Failed to set accept friend. Status code: ${response.statusCode} ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to set accept friend');
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
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          automaticallyImplyLeading: false,
          titleSpacing: 0,
          bottom: PreferredSize(
              preferredSize: const Size.fromHeight(0.5),
              child: Container(
                color: Colors.black12,
                height: 0.5,
              )),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
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
              const Expanded(
                child: Text(
                  'Bạn bè',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
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
                left: 10,
                top: 20,
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        FriendsSuggestScreen.routeName,
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.all(10),
                      child: const Text(
                        'Gợi ý',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        FriendsSearchScreen.routeName,
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.all(10),
                      child: const Text(
                        'Bạn bè',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const Divider(
              color: Colors.black12,
              thickness: 0.5,
              height: 40,
              indent: 10,
              endIndent: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Lời mời kết bạn',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "$totalRequestFriend",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                  const Text(
                    'Xem tất cả',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                      color: Colors.blueAccent,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            for (int i = 0; i < friends.length; i++)
              Padding(
                padding: const EdgeInsets.all(10),
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
                        radius: 46,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                friends[i].user.name,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                friends[i].time,
                                style: const TextStyle(
                                  color: Colors.black54,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          if (friends[i].mutualFriends != null &&
                              friends[i].mutualFriends! > 0)
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 2,
                              ),
                              child: Row(
                                children: [
                                  Stack(
                                    children: [
                                      friends[i].f2 != null
                                          ? const SizedBox(
                                              width: 46,
                                              height: 28,
                                            )
                                          : const SizedBox(
                                              width: 28,
                                              height: 28,
                                            ),
                                      if (friends[i].f2 != null)
                                        Positioned(
                                          left: 22,
                                          top: 2,
                                          child: CircleAvatar(
                                            backgroundImage: NetworkImage(
                                                friends[i].f2!.avatar),
                                            radius: 12,
                                          ),
                                        ),
                                      Positioned(
                                        left: 0,
                                        top: 0,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: Colors.white,
                                              width: 2,
                                            ),
                                          ),
                                          child: CircleAvatar(
                                            backgroundImage: NetworkImage(
                                                friends[i].f1!.avatar),
                                            radius: 12,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    '${friends[i].mutualFriends} bạn chung',
                                    style: const TextStyle(
                                      color: Colors.black54,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    setAcceptFriend(friends[i].user.userId, "1", i); // chang id
                                  },
                                  style: ElevatedButton.styleFrom(
                                    shadowColor: Colors.transparent,
                                    backgroundColor: Colors.blue[700],
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: const Text(
                                    'Chấp nhận',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    setAcceptFriend(friends[i].user.userId, "0", i); // chang user id
                                  },
                                  style: ElevatedButton.styleFrom(
                                    shadowColor: Colors.transparent,
                                    backgroundColor: Colors.grey[300],
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: const Text(
                                    'Xóa',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
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
