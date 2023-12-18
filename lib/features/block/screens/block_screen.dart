import 'dart:convert';


import 'package:anti_facebook_app/constants/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../UserData/user_info.dart';
import '../../../models/user.dart';
import '../../personal-page/screens/personal_page_screen.dart';


class BlockScreen extends StatefulWidget {
  static const String routeName = '/block-screen';
  const BlockScreen({super.key});

  @override
  State<BlockScreen> createState() => _BlockScreenState();
}

class FriendBlock {
   String userName;
  String avatar;
  String userId;
  FriendBlock({
    required this.userName,
    required this.avatar,
    required this.userId,

  });
}

class _BlockScreenState extends State<BlockScreen> {
  final today = DateTime.now();

  List<FriendBlock> friendBlocks = [];
  final TextEditingController searchController = TextEditingController();

  // final String authToken = GlobalVariables.token;
  final String authToken = UserInfo.token;
  Future getData() async {
    var data = {
      "index": "0",
      "count": "10"
    };

    try {
      var response = await http.post(
        Uri.parse(GlobalVariables.apiGetListBlocks),
        body: json.encode(data),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $authToken',
        },
      );

      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);
        print(responseData);
        List<dynamic> data = responseData['data'];

        List<FriendBlock> tempFriendBlock = [];
        for (var user in data) {
          String username = user['name'];
          String id = user['id'];
          String avatar = user['avatar'];

          FriendBlock friendBlock = FriendBlock(
            userName: username,
            avatar: avatar,
            userId: id
          );
          tempFriendBlock.add(friendBlock);
        }

        setState(() {
          friendBlocks = tempFriendBlock;
        });

        return responseData;
      } else {
        throw Exception(
            'Failed to get list block. Status code: ${response.statusCode} ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to get list block');
    }
  }
  Future unBlock(String? userId, int index) async{
    var data = {"user_id": userId};

    try {
      var response = await http.post(
        Uri.parse(GlobalVariables.apiUnblock),
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
            friendBlocks.removeAt(index);
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
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          automaticallyImplyLeading: false,
          titleSpacing: 0,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(20),
            child: Column(
              children: [
                Container(
                  color: Colors.black12,
                  height: 0.5,
                ),
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
                'Chặn',
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
                left: 15,
                top: 15,
                bottom: 15,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Người bị chặn",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 8,),
                  Text(
                    "Một khi bạn đã chân ai đó, họ sẽ không xem được nội dung bạn tự đăng trên dòng thời gian mình, gân thẻ bạn, mới bạn tham gia sự kiện hoặc nhóm, bắt đầu cuộc trò chuyện với bạn hay thêm bạn làm bạn bè. Điều này không bao gồm các ứng dụng, trò chơi hay nhóm mà cả bạn và người này đều tham gia",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
            for (int i = 0; i < friendBlocks.length; i++)
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
                        backgroundImage: NetworkImage(friendBlocks[i].avatar),
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
                                arguments: friendBlocks[i],
                              );
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  friendBlocks[i].userName,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              unBlock(friendBlocks[i].userId, i);
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.transparent,
                            ),
                            child: const Text(
                              'Bỏ chặn',
                              style: TextStyle(
                                color: Colors.grey,
                              ),
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