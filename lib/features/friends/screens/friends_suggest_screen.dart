import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../models/user.dart';

class FriendsSuggestScreen extends StatefulWidget {
  static const String routeName = '/friends-suggest-screen';
  const FriendsSuggestScreen({super.key});

  @override
  State<FriendsSuggestScreen> createState() => _FriendsSuggestScreenState();
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

class _FriendsSuggestScreenState extends State<FriendsSuggestScreen> {
  final today = DateTime.now();
  List<FriendRequest> friends = [];
  final String apiGetSuggestFriend =
      'https://it4788.catan.io.vn/get_suggested_friends';
  final String apiSetRequestFriend =
      'https://it4788.catan.io.vn/set_request_friend';
  final String apiDelRequestFriend =
      'https://it4788.catan.io.vn/del_request_friend';
  final String authToken =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Mzc1LCJkZXZpY2VfaWQiOiJzdHJpbmciLCJpYXQiOjE3MDIzMTMzNDd9.wFUtXedv902h_EXRUcXZCIFjVBX1vcLYNEl7blbgkqI";
  Future getData() async {
    var data = {"index": "0", "count": "10"};

    try {
      var response = await http.post(
        Uri.parse(apiGetSuggestFriend),
        body: json.encode(data),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $authToken',
        },
      );

      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);

        List<FriendRequest> tempFriendRequests = [];
        for (var suggest in responseData['data']) {
          String username = suggest['username'];
          String id = suggest['id'];
          String avatar = suggest['avatar'];
          int sameFriends = int.parse(suggest['same_friends']);
          String created = suggest['created'];
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

  Future setRequestFriend(String? userId, int index,void Function(bool) updateIsRequestFriend) async {
    var data = {"user_id": userId};

    try {
      var response = await http.post(
        Uri.parse(apiSetRequestFriend),
        body: json.encode(data),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $authToken',
        },
      );

      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);
        if (responseData['message'] == "OK") {
          print("ok");
          updateIsRequestFriend(true);
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

  Future delRequestFriend(String? userId, int index, void Function(bool) updateIsRequestFriend ) async {
    var data = {"user_id": userId};

    try {
      var response = await http.post(
        Uri.parse(apiDelRequestFriend),
        body: json.encode(data),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $authToken',
        },
      );

      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);
        if (responseData['message'] == "OK") {
          updateIsRequestFriend(false);
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
                'Gợi ý',
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
            const Padding(
              padding: EdgeInsets.only(
                left: 10,
                top: 15,
                bottom: 15,
              ),
              child: Text(
                'Những người bạn có thể biết',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            for (int i = 0; i < friends.length; i++)
              Padding(
                padding: const EdgeInsets.all(10),
                child: FriendWidget(
                  friend: friends[i],
                  index: i,
                  setRequestFriend: setRequestFriend,
                  delRequestFriend: delRequestFriend,
                ),
              )
          ],
        ),
      ),
    );
  }
}

class FriendWidget extends StatefulWidget {
  final FriendRequest friend;
  final int index;
  final Future Function(String? userId, int index, void Function(bool) updateIsRequestFriend) setRequestFriend;
  final Future Function(String? userId, int index, void Function(bool) updateIsRequestFriend) delRequestFriend;

  const FriendWidget({
    required this.friend,
    required this.index,
    required this.setRequestFriend,
    required this.delRequestFriend,
    Key? key,
  }) : super(key: key);

  @override
  _FriendWidgetState createState() => _FriendWidgetState();
}

class _FriendWidgetState extends State<FriendWidget> {
  bool isRequestFriend = false;
  void updateIsRequestFriend(bool value) {
    setState(() {
      isRequestFriend = value;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Row(
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
            backgroundImage: NetworkImage(widget.friend.user.avatar),
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
                    widget.friend.user.name,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    widget.friend.time,
                    style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              if (widget.friend.mutualFriends != null &&
                  widget.friend.mutualFriends! > 0)
                Padding(
                  padding: const EdgeInsets.only(
                    top: 2,
                  ),
                  child: Row(
                    children: [
                      Stack(
                        children: [
                          widget.friend.f2 != null
                              ? const SizedBox(
                                  width: 46,
                                  height: 28,
                                )
                              : const SizedBox(
                                  width: 28,
                                  height: 28,
                                ),
                          if (widget.friend.f2 != null)
                            Positioned(
                              left: 22,
                              top: 2,
                              child: CircleAvatar(
                                backgroundImage:
                                    NetworkImage(widget.friend.f2!.avatar),
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
                                backgroundImage:
                                    NetworkImage(widget.friend.f1!.avatar),
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
                        '${widget.friend.mutualFriends} bạn chung',
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
                  Visibility(
                    visible: !isRequestFriend,
                    child: Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          widget.setRequestFriend(widget.friend.user.userId, widget.index,updateIsRequestFriend);
                        },
                        style: ElevatedButton.styleFrom(
                          shadowColor: Colors.transparent,
                          backgroundColor: Colors.blue[700],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Thêm bạn bè',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                          ),
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
                        if (!isRequestFriend) {

                        } else {
                          widget.delRequestFriend(widget.friend.user.userId, widget.index,updateIsRequestFriend);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        shadowColor: Colors.transparent,
                        backgroundColor: Colors.grey[300],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        !isRequestFriend ? 'Gỡ' : "Hủy",
                        style: const TextStyle(
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
    );
  }
}
