import 'dart:convert';
import 'dart:math';

import 'package:anti_facebook_app/constants/global_variables.dart';
import 'package:anti_facebook_app/features/news-feed/widgets/story_card.dart';
import 'package:anti_facebook_app/models/post.dart';
import 'package:anti_facebook_app/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../../dangBai.dart';
import '../../../models/user.dart';
import '../../../utils/httpRequest.dart';
import '../../news-feed/widgets/post_card.dart';
import 'edit_user_page.dart';

class PersonalPageScreen extends StatefulWidget {
  static const String routeName = '/personal-page';
  final User user;
  const PersonalPageScreen({super.key, required this.user});

  @override
  State<PersonalPageScreen> createState() => _PersonalPageScreenState();
}

class _PersonalPageScreenState extends State<PersonalPageScreen> {
  final TextEditingController searchController = TextEditingController();
  final Random random = Random();
  bool isMine = false;
  late bool isFriend = false;
  late bool isRequestFriend = false;
  int mutualFriends = 0;
  final String getListPosts = 'https://it4788.catan.io.vn/get_list_posts';
  final String getUserInfo = 'https://it4788.catan.io.vn/get_user_info';
  final String apiGetUserFriend = 'https://it4788.catan.io.vn/get_user_friends';
  final String authToken = GlobalVariables.token;

  late User newUser = widget.user;
  late String userName = widget.user.name ?? "";
  late String avatar = widget.user.avatar ?? "";
  late String coverImage = widget.user.cover ?? "";
  late String country = widget.user.country ?? "";
  late String address = widget.user.address ?? "";
  late String description = widget.user.bio ?? "";
  late String coins = widget.user.coins ?? "50";
  late List<User> topFriends = [];

  Future getInfo() async {
    var data = {
      "user_id": widget.user.userId,
    };

    try {
      var response = await http.post(
        Uri.parse(getUserInfo),
        body: json.encode(data),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $authToken',
        },
      );
      if (response.statusCode == 201) {
        var responseData = json.decode(response.body);

        String id = responseData['data']['id'];
        String username = responseData['data']['username'];
        String created = responseData['data']['created'];
        String description = responseData['data']['description'];
        String avatar = responseData['data']['avatar'];
        String coverImage = responseData['data']['cover_image'];
        String link = responseData['data']['link'];
        String address = responseData['data']['address'];
        String city = responseData['data']['city'];
        String country = responseData['data']['country'];
        String listing = responseData['data']['listing'];
        String is_friend = responseData['data']['is_friend'];
        String online = responseData['data']['online'];
        String coins = responseData['data']['coins'];
        setState(() {
          isFriend = is_friend == "0" ? false : true;
          userName = username;
          this.avatar = avatar;
          this.country = country;
          this.address = address;
          this.description = description;
          this.coins = coins;
          this.coverImage = coverImage;

          this.newUser = newUser.copyWith(name: userName, avatar: avatar, cover: coverImage,
              bio: description, address: address, city: city, country: country, link: link, coins: coins, userId: id);
        });
        return responseData;
      } else {
        throw Exception(
            'Failed to get friends. Status code: ${response.statusCode} ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to get info');
    }
  }

  List<Post> listPosts = [];
  Future getPosts() async {
    var data = {
      "user_id": widget.user.userId,
      "index": "0",
      "count": "10",
    };

    try {
      var response = await http.post(
        Uri.parse(getListPosts),
        body: json.encode(data),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $authToken',
        },
      );

      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);
        List<dynamic> posts = responseData['data']['post'];
        List<Post> temp = [];
        for (var post in posts) {
          String postId = post['id'];
          String postName = post['name'];
          List<dynamic> postImages = post['image'];
          String postDescribed = post['described'];
          String postCreated = post['created'];
          String postFeel = post['feel'];
          String postCommentMark = post['comment_mark'];
          String postIsFelt = post['is_felt'];
          String postIsBlocked = post['is_blocked'];
          String postCanEdit = post['can_edit'];
          String postBanned = post['banned'];
          String postState = post['state'];
          DateTime dateTime = DateTime.parse(postCreated);
          DateTime now = DateTime.now();
          Duration difference = now.difference(dateTime);
          String time = formatTimeDifference(difference);

          // Truy cập thông tin về tác giả
          Map<String, dynamic> author = post['author'];
          String authorId = author['id'];
          String authorName = author['name'];
          String authorAvatar = author['avatar'];

          Post newPost =
              // Post(
              //     user: User(name: authorName, userId: authorId, avatar: authorAvatar),
              //     time: time, shareWith: "public", comment: int.parse(postCommentMark), content: postDescribed  );
              Post(
            user: User(
              name: authorName,
              avatar: 'assets/images/user/lcd.jpg',
              userId: authorId,
            ),
            time: time,
            shareWith: 'public',
            content: postDescribed,
            image: ['assets/images/post/2.jpg'],
            like: 163,
            love: 24,
            comment: int.parse(postCommentMark),
            type: 'memory',
          );
          temp.add(newPost);
        }
        setState(() {
          listPosts = temp;
        });
        return responseData;
      } else {
        throw Exception(
            'Failed to get friends. Status code: ${response.statusCode} ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to get post');
    }
  }
  Future<void> _callAPI() async {
    try {
      Map<String, dynamic> requestData = {
        "user_id": widget.user.userId,
        "index": "0",
        "count": "10"
      };

      var result = await callAPI('/get_list_posts',
          requestData); // Sử dụng 'await' để đợi kết thúc của hàm callAPI
      listPosts = postsFromJson(result['post']);
      setState(() {});
      // }
    } catch (error) {
      // setState(() {});
    }
  }

  Future setRequestFriend() async {
    var data = {"user_id": widget.user.userId};
    try {
      var response = await http.post(
        Uri.parse(GlobalVariables.apiSetRequestFriend),
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
            isRequestFriend = true;
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

  Future delRequestFriend() async {
    var data = {"user_id": widget.user.userId};

    try {
      var response = await http.post(
        Uri.parse(GlobalVariables.apiDelRequestFriend),
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
            isRequestFriend = false;
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

  Future setBlock() async {
    var data = {"user_id": widget.user.userId};
    try {
      var response = await http.post(
        Uri.parse(GlobalVariables.apiSetBlock),
        body: json.encode(data),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $authToken',
        },
      );

      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);
        if (responseData['message'] == "OK") {

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
  Future unFriend() async{
    var data = {"user_id": widget.user.userId};

    try {
      var response = await http.post(
        Uri.parse(GlobalVariables.apiUnfriend),
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
            isFriend = false;
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
  Future getListFriend() async {
    var data = {
      "index": "0",
      "count": "5",
      "user_id": widget.user.userId
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
        Map<String, dynamic> data = responseData['data'];
        List<dynamic> requests = data['friends'];
        List<User> tempFriend= [];
        for (var request in requests) {
          String username = request['username'];
          String id = request['id'];
          String avatar = request['avatar'];
          User user = User(name: username, avatar: avatar, userId: id);
          tempFriend.add(user);
          print("1121" + username);
        }
        setState(() {
          topFriends = tempFriend;
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

  @override
  void initState() {
    super.initState();
    getListFriend();
    _callAPI();
    getInfo();
  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<UserProvider>(context).user;
    if (widget.user.userId != user.userId) {
      user = widget.user;

      if (user.friends == null) {
        user = user.copyWith(
          friends: random.nextInt(5000),
        );
      }
      if (user.likes == null) {
        user = user.copyWith(
          likes: random.nextInt(1000000),
        );
      }
      if (user.type == 'page' && user.followers == null) {
        user = user.copyWith(
          followers: random.nextInt(1000000),
        );
      }
      mutualFriends = random.nextInt(user.friends ?? 1000);
    } else {
      setState(() {
        isMine = true;
      });
    }
    void _goToEditUserPage() {
      Navigator.pushNamed(
        context,
        EditUserPage.routeName,
        arguments: newUser,
      );
    }

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
              width: double.infinity,
              height: 0.5,
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
              size: 30,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    right: 10,
                    top: 5,
                    bottom: 5,
                  ),
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      isDense: true,
                      hintText: 'Tìm kiếm',
                      hintStyle: const TextStyle(
                        fontSize: 18,
                      ),
                      prefixIcon: const Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 10,
                        ),
                        child: Icon(
                          Icons.search_rounded,
                          color: Colors.grey,
                          size: 25,
                        ),
                      ),
                      prefixIconConstraints:
                          const BoxConstraints(minWidth: 45, maxHeight: 41),
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
                      contentPadding: EdgeInsets.zero,
                    ),
                    cursorColor: Colors.black,
                    textAlignVertical: TextAlignVertical.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                const SizedBox(
                  width: double.infinity,
                  height: 270,
                ),
                coverImage != ""
                    ? Image.network(
                        coverImage,
                        fit: BoxFit.cover,
                        height: 220,
                        width: double.infinity,
                      )
                    : Container(
                        width: double.infinity,
                        height: 220,
                        color: Colors.grey,
                      ),
                Positioned(
                  left: 15,
                  bottom: 0,
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white,
                            width: 5,
                            style: BorderStyle.solid,
                          ),
                        ),
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(avatar),
                          radius: 75,
                        ),
                      ),
                      if (user.guard == true)
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Image.asset(
                            'assets/images/guard.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      if (isMine)
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.camera_alt_rounded,
                                color: Colors.black,
                                size: 22,
                              )),
                        ),
                    ],
                  ),
                ),
                if (isMine)
                  Positioned(
                    bottom: 65,
                    right: 15,
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(9),
                          decoration: BoxDecoration(
                            color: Colors.blue[700],
                            shape: BoxShape.circle,
                          ),
                          child: const ImageIcon(
                            AssetImage('assets/images/avatar.png'),
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.camera_alt_rounded,
                            color: Colors.black,
                            size: 22,
                          ),
                        ),
                      ],
                    ),
                  )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        userName,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      (user.verified == true
                          ? const Padding(
                              padding: EdgeInsets.only(left: 5),
                              child: Icon(
                                Icons.verified,
                                color: Colors.blue,
                                size: 15,
                              ),
                            )
                          : const SizedBox()),
                      Text(
                        " - $coins",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(
                        Icons.currency_bitcoin_sharp,
                        color: Color.fromARGB(255, 99, 99, 7),
                        size: 20.0,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  user.type != 'page'
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              '${user.friends! >= 1000 ? '${user.friends! ~/ 1000},${(user.friends! ~/ 100) % 10}K' : user.friends}',
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            const Text(
                              'bạn bè',
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            if (!isMine)
                              Row(
                                children: [
                                  const Icon(
                                    Icons.circle,
                                    color: Colors.black,
                                    size: 3,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    '$mutualFriends',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  const Text(
                                    'bạn chung',
                                    style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              '${user.likes! >= 1000 ? '${user.likes! ~/ 1000}K' : user.likes}',
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            const Text(
                              'lượt thích',
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.circle,
                                  color: Colors.black,
                                  size: 3,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  '${user.followers! >= 1000 ? '${user.followers! ~/ 1000}K' : user.followers}',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                const Text(
                                  'người theo dõi',
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                  const SizedBox(
                    height: 5,
                  ),
                  if (user.bio != null)
                    Text(
                      description,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  const SizedBox(
                    height: 10,
                  ),
                  (isMine)
                      ? Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                        shadowColor: Colors.transparent,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        backgroundColor: Colors.blue[700],
                                      ),
                                      child: const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.add,
                                            color: Colors.white,
                                            size: 16,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            'Thêm vào tin',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ],
                                      )),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                      onPressed: () {
                                        _goToEditUserPage();
                                      },
                                      style: ElevatedButton.styleFrom(
                                        shadowColor: Colors.transparent,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        backgroundColor: Colors.grey[200],
                                      ),
                                      child: const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.edit_rounded,
                                            color: Colors.black,
                                            size: 16,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            'Chỉnh sửa trang cá nhân',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ],
                                      )),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    shadowColor: Colors.transparent,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    backgroundColor: Colors.grey[200],
                                    padding: EdgeInsets.zero,
                                  ),
                                  child: const Icon(
                                    Icons.more_horiz_rounded,
                                    size: 20,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            )
                          ],
                        )
                      : user.type != 'page'
                          ? Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if (!isFriend && !isRequestFriend) {
                                        setRequestFriend();
                                      } else if (!isFriend && isRequestFriend) {
                                        delRequestFriend();
                                      } else if (isFriend) {
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
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  ListTile(
                                                    minLeadingWidth: 10,
                                                    leading: const ImageIcon(
                                                      AssetImage(
                                                          'assets/images/block.png'),
                                                      size: 25,
                                                      color: Colors.black,
                                                    ),
                                                    title: GestureDetector(
                                                      onTap: () {
                                                        Navigator.pop(context);
                                                        setBlock();
                                                      },
                                                      child: Column(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                        children: [
                                                        Text(
                                                        'Chặn trang cá nhân của ${widget.user.name}',
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
                                                        Text(
                                                        '${widget.user.name} sẽ không thể nhìn thấy bạn hoặc liên hệ với bạn trên Facebook.',
                                                        style:
                                                        const TextStyle(
                                                        color:
                                                        Colors.black54,
                                                        fontSize: 14,
                                                        ),
                                                        ),
                                                        ],
                                                        )
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
                                                        Navigator.of(context).pop();
                                                        showDialog(
                                                          context: context,
                                                          builder: (BuildContext context) {
                                                            return AlertDialog(
                                                              title: const Text("Hủy kết bạn"),
                                                              content: Text("Bạn có chắc chắn muốn hủy kết bạn với ${widget.user.name}?"),
                                                              actions: [
                                                                TextButton(
                                                                  onPressed: () {
                                                                    unFriend();
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
                                                            'Hủy kết bạn với ${widget.user.name}',
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
                                                            'Hủy kết bạn với ${widget.user.name}',
                                                            style: const TextStyle(
                                                              color: Colors.black54,
                                                              fontSize: 14,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        );
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      shadowColor: Colors.transparent,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      backgroundColor: Colors.grey[200],
                                      padding: EdgeInsets.zero,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        ImageIcon(
                                          AssetImage(
                                              'assets/images/friend.png'),
                                          size: 16,
                                          color: Colors.black,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          isFriend
                                              ? 'Bạn bè'
                                              : !isRequestFriend
                                                  ? 'Thêm bạn bè'
                                                  : "Hủy lời mời",
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  flex: 3,
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      shadowColor: Colors.transparent,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      backgroundColor: Colors.blue[700],
                                    ),
                                    child: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        ImageIcon(
                                          AssetImage(
                                              'assets/images/message.png'),
                                          color: Colors.white,
                                          size: 18,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          'Nhắn tin',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  flex: 1,
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      shadowColor: Colors.transparent,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      backgroundColor: Colors.grey[200],
                                      padding: EdgeInsets.zero,
                                    ),
                                    child: const Icon(
                                      Icons.more_horiz_rounded,
                                      size: 20,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      shadowColor: Colors.transparent,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      backgroundColor: Colors.blue[700],
                                      padding: EdgeInsets.zero,
                                    ),
                                    child: const Text(
                                      'Nhắn tin',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  flex: 3,
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      shadowColor: Colors.transparent,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      backgroundColor: Colors.grey[200],
                                    ),
                                    child: const Text(
                                      'Đã thích',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  flex: 1,
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      shadowColor: Colors.transparent,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      backgroundColor: Colors.grey[200],
                                      padding: EdgeInsets.zero,
                                    ),
                                    child: const Icon(
                                      Icons.more_horiz_rounded,
                                      size: 20,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                ],
              ),
            ),
            if (isMine || user.type == 'page')
              Container(
                width: double.infinity,
                height: 10,
                color: Colors.grey,
              ),
            if (isMine)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 15,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue[50],
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Bài viết',
                        style: TextStyle(
                          color: Colors.blue[700],
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 15,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'Reels',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            if (user.type == 'page')
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 10,
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 15,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blue[50],
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'Bài viết',
                          style: TextStyle(
                            color: Colors.blue[700],
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 15,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          'Giới thiệu',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 15,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          'Video',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 15,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Row(
                          children: [
                            Text(
                              'Xem thêm',
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(
                              width: 2,
                            ),
                            Icon(
                              Icons.arrow_drop_down_sharp,
                              size: 25,
                              color: Colors.black54,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            isMine
                ? Container(
                    width: double.infinity,
                    color: Colors.black12,
                    height: 0.5,
                  )
                : Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 15,
                    ),
                    width: double.infinity,
                    color: Colors.black12,
                    height: 0.5,
                  ),
            Padding(
              padding: const EdgeInsets.only(
                left: 15,
                right: 15,
                top: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (isMine || user.type == 'page')
                    const Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Text(
                        'Chi tiết',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  if (user.pageType != null)
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 10,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.info_rounded,
                            size: 25,
                            color: Colors.black54,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: RichText(
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              text: TextSpan(
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                                children: [
                                  const TextSpan(
                                    text: 'Trang',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const TextSpan(
                                    text: ' · ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text: user.pageType,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  if (user.educations != null)
                    for (int i = 0; i < user.educations!.length; i++)
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: 10,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.school_rounded,
                              size: 25,
                              color: Colors.black54,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: RichText(
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                text: TextSpan(
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                  children: [
                                    TextSpan(
                                      text:
                                          'Học ${user.educations![i].majors != '' ? '${user.educations![i].majors} ' : ''}tại ',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    TextSpan(
                                      text: user.educations![i].school,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                  if (user.address != null)
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 10,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.house_rounded,
                            size: 25,
                            color: Colors.black54,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: RichText(
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              text: TextSpan(
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                                children: [
                                  const TextSpan(
                                    text: 'Sống tại ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  TextSpan(
                                    text: address,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  if (user.hometown != null)
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 10,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.location_on_rounded,
                            size: 25,
                            color: Colors.black54,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: RichText(
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              text: TextSpan(
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                                children: [
                                  const TextSpan(
                                    text: 'Đến từ ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  TextSpan(
                                    text: country,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  if (user.type != 'page' && user.followers != null)
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 10,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(
                              left: 5,
                            ),
                            child: ImageIcon(
                              AssetImage('assets/images/wifi.png'),
                              size: 20,
                              color: Colors.black54,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Text(
                              'Có ${user.followers} người theo dõi',
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  if (user.socialMedias != null)
                    for (int i = 0; i < user.socialMedias!.length; i++)
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: 10,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ImageIcon(
                              AssetImage(user.socialMedias![i].icon),
                              size: 25,
                              color: Colors.black54,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Text(
                                user.socialMedias![i].name,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 10,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.more_horiz_rounded,
                          size: 25,
                          color: Colors.black54,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Text(
                            isMine
                                ? 'Xem thông tin giới thiệu của bạn'
                                : 'Xem thông tin giới thiệu của ${user.name}',
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  if (user.hobbies != null)
                    Wrap(
                      spacing: 10,
                      children: [
                        for (int i = 0; i < user.hobbies!.length; i++)
                          Container(
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              user.hobbies![i],
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                      ],
                    ),
                  if (user.stories != null || isMine)
                    const SizedBox(
                      height: 10,
                    ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        if (isMine)
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 80,
                                height: 144,
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Icon(
                                  Icons.add,
                                  color: Colors.black54,
                                  size: 25,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              const Text(
                                'Mới',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              )
                            ],
                          ),
                        if (isMine)
                          const SizedBox(
                            width: 15,
                          ),
                        if (user.stories != null)
                          for (int i = 0; i < user.stories!.length; i++)
                            Padding(
                              padding: EdgeInsets.only(
                                  right: i < user.stories!.length ? 15 : 0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 80,
                                    height: 144,
                                    child: FittedBox(
                                      child: StoryCard(
                                        story: user.stories![i],
                                        hidden: true,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    user.stories![i].name != null
                                        ? user.stories![i].name!
                                        : 'Tin nổi bật',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                                  )
                                ],
                              ),
                            ),
                      ],
                    ),
                  ),
                  if (user.stories != null)
                    const SizedBox(
                      height: 10,
                    ),
                  if (isMine)
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue[50],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              shadowColor: Colors.transparent,
                            ),
                            child: Text(
                              'Chỉnh sửa chi tiết công khai',
                              style: TextStyle(
                                color: Colors.blue[700],
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
            if (!isMine)
              Container(
                width: double.infinity,
                height: 0.5,
                color: Colors.black12,
              ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        user.type != 'page'
                            ? 'Bạn bè'
                            : 'Bài viết của ${user.name}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                      if (isMine)
                        Text(
                          'Tìm bạn bè',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.blue[700],
                          ),
                        ),
                    ],
                  ),
                  if (user.type != 'page')
                    const SizedBox(
                      height: 5,
                    ),
                  if (user.type != 'page')
                    RichText(
                      textAlign: TextAlign.left,
                      text: TextSpan(
                          text: user.friends.toString(),
                          style: const TextStyle(
                            color: Colors.black54,
                            fontSize: 16,
                          ),
                          children: [
                            isMine
                                ? const TextSpan(text: ' người bạn ')
                                : mutualFriends > 0
                                    ? TextSpan(
                                        text: ' ($mutualFriends) bạn chung')
                                    : const TextSpan()
                          ]),
                    ),
                  if (user.type != 'page')
                    const SizedBox(
                      height: 20,
                    ),
                  if (topFriends.isNotEmpty)
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            for (int i = 0;
                                i < min(3, topFriends!.length);
                                i++)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      topFriends![i].avatar,
                                      width:
                                          (MediaQuery.of(context).size.width -
                                                  50) /
                                              3,
                                      height:
                                          (MediaQuery.of(context).size.width -
                                                  50) /
                                              3,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  SizedBox(
                                    width: (MediaQuery.of(context).size.width -
                                            50) /
                                        3,
                                    child: Text(
                                      topFriends![i].name,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            for (int i = min(3, topFriends!.length);
                                i < 3;
                                i++)
                              SizedBox(
                                width:
                                    (MediaQuery.of(context).size.width - 50) /
                                        3,
                              ),
                          ],
                        ),
                        if (topFriends!.length > 3)
                          const SizedBox(
                            height: 10,
                          ),
                        if (topFriends!.length > 3)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              for (int i = 3;
                                  i < min(6, topFriends!.length);
                                  i++)
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        topFriends![i].avatar,
                                        width:
                                            (MediaQuery.of(context).size.width -
                                                    50) /
                                                3,
                                        height:
                                            (MediaQuery.of(context).size.width -
                                                    50) /
                                                3,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    SizedBox(
                                      width:
                                          (MediaQuery.of(context).size.width -
                                                  50) /
                                              3,
                                      child: Text(
                                        topFriends![i].name,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              for (int i = min(6, topFriends!.length);
                                  i < 6;
                                  i++)
                                SizedBox(
                                  width:
                                      (MediaQuery.of(context).size.width - 50) /
                                          3,
                                ),
                            ],
                          ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.grey[200],
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  shadowColor: Colors.transparent,
                                ),
                                child: const Text(
                                  'Xem tất cả bạn bè',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                ],
              ),
            ),
            if (user.type != 'page')
              const SizedBox(
                height: 10,
              ),
            if (user.type != 'page')
              Container(
                height: 10,
                width: double.infinity,
                color: Colors.grey,
              ),
            if (user.type != 'page')
              const SizedBox(
                height: 15,
              ),
            if (user.type != 'page')
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Bài viết',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        color: Colors.black,
                      ),
                    ),
                    if (isMine)
                      Text(
                        'Bộ lọc',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.blue[700],
                        ),
                      ),
                  ],
                ),
              ),
            const SizedBox(
              height: 10,
            ),
            if (user.type != 'page')
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DangBai()),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          right: 10,
                        ),
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(avatar),
                          radius: 20,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          isMine
                              ? 'Bạn đang nghĩ gì?'
                              : 'Viết gì đó cho ${user.name}',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      IconButton(
                        splashRadius: 20,
                        onPressed: () {},
                        icon: const Icon(
                          Icons.image,
                          color: Colors.green,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            const SizedBox(
              height: 10,
            ),
            if (isMine)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: 0.5,
                    color: Colors.black12,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                    ),
                    color: Colors.grey[100],
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                      ),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {},
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: Colors.black12,
                                  width: 0.75,
                                ),
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ImageIcon(
                                    AssetImage('assets/images/menu/reels.png'),
                                    color: Colors.red,
                                    size: 20,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    'Thước phim',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          InkWell(
                            onTap: () {},
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: Colors.black12,
                                  width: 0.75,
                                ),
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.video_camera_front_rounded,
                                    color: Colors.red,
                                    size: 20,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    'Phát trực tiếp',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 0.5,
                    color: Colors.black12,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                          ),
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey[200],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              shadowColor: Colors.transparent,
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.chat_rounded,
                                    color: Colors.black, size: 18),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'Quản lý bài viết',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            Container(
              width: double.infinity,
              height: 10,
              color: Colors.grey,
            ),
            if (user.type != 'page')
              Padding(
                padding: const EdgeInsets.all(15),
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.image_rounded,
                          color: Colors.black,
                          size: 20,
                        ),
                        SizedBox(width: 5),
                        Text(
                          'Ảnh',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            if (user.type != 'page')
              Container(
                width: double.infinity,
                height: 10,
                color: Colors.grey,
              ),
            Column(
              children: listPosts
                  .map((post) => Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  PostCard(
                    post: post,
                  ),
                  Container(
                    width: double.infinity,
                    height: 5,
                    color: Colors.black26,
                  ),
                ],
              ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
