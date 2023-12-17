import 'package:anti_facebook_app/dangBai.dart';
import 'package:anti_facebook_app/features/news-feed/widgets/add_story_card.dart';
import 'package:anti_facebook_app/features/news-feed/widgets/post_card.dart';
import 'package:anti_facebook_app/features/news-feed/widgets/story_card.dart';
import 'package:anti_facebook_app/models/post.dart';
import 'package:anti_facebook_app/models/story.dart';
import 'package:anti_facebook_app/models/user.dart';
import 'package:anti_facebook_app/providers/user_provider.dart';
import 'package:anti_facebook_app/utils/httpRequest.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewsFeedScreen extends StatefulWidget {
  static double offset = 0;
  final ScrollController parentScrollController;
  const NewsFeedScreen({super.key, required this.parentScrollController});

  @override
  State<NewsFeedScreen> createState() => _NewsFeedScreenState();
}

class _NewsFeedScreenState extends State<NewsFeedScreen> {
  Color colorNewPost = Colors.transparent;
  final stories = [
    Story(
      user: User(
        name: 'Doraemon',
        avatar: 'assets/images/user/doraemon.jpg',
        type: 'page',
      ),
      image: ['assets/images/story/1.jpg'],
      time: ['12 phút'],
      shareWith: 'public',
    ),
    Story(
      user: User(
          name: 'Sách Cũ Ngọc', avatar: 'assets/images/user/sachcungoc.jpg'),
      image: ['assets/images/story/2.jpg'],
      time: ['3 giờ'],
      shareWith: 'friends',
    ),
    Story(
      user: User(
        name: 'Vietnamese Argentina Football Fan Club (VAFFC)',
        avatar: 'assets/images/user/vaffc.jpg',
        type: 'page',
      ),
      image: ['assets/images/story/3.jpg'],
      time: ['5 giờ'],
      shareWith: 'friends-of-friends',
    ),
    Story(
      user:
          User(name: 'Minh Hương', avatar: 'assets/images/user/minhhuong.jpg'),
      image: [
        'assets/images/story/4.jpg',
        'assets/images/story/5.jpg',
        'assets/images/story/6.jpg',
        'assets/images/story/7.jpg',
      ],
      video: ['assets/videos/2.mp4', 'assets/videos/1.mp4'],
      time: ['1 phút'],
      shareWith: 'friends',
    ),
    Story(
      user: User(name: 'Khánh Vy', avatar: 'assets/images/user/khanhvy.jpg'),
      video: ['assets/videos/3.mp4'],
      time: ['1 phút'],
      shareWith: 'friends',
    ),
  ];

  List<Post> posts = [
    // Post(
    //   user: User(
    //     name: 'Tiến',
    //     avatar:
    //         'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSyfW1RdSwZE8xd2n8iW0a_lUTS6VEOiGK1EQ&usqp=CAU',
    //   ),
    //   time: '2021-08-29T11:05:37.119+07:00',
    //   shareWith: 'public',
    //   content: 'Do you like Phở?\nBecause I can be your Pho-ever ✨✨',
    //   image: [
    //     'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSyfW1RdSwZE8xd2n8iW0a_lUTS6VEOiGK1EQ&usqp=CAU',
    //   ],
    //   like: 15000,
    //   love: 7300,
    //   comment: 258,
    //   haha: 235,
    //   share: 825,
    //   lovelove: 212,
    //   wow: 9,
    //   layout: 'classic',
    //   type: 'memory',
    // ),
  ];

  ScrollController scrollController =
      ScrollController(initialScrollOffset: NewsFeedScreen.offset);

  @override
  void initState() {
    super.initState();
    _callAPI();
  }

  Future<void> _callAPI() async {
    try {
      Map<String, dynamic> requestData = {
        "user_id": "608",
        "index": "0",
        "count": "10"
      };

      var result = await callAPI('/get_list_posts',
          requestData); // Sử dụng 'await' để đợi kết thúc của hàm callAPI
      posts = postsFromJson(result['post']);
      setState(() {});
      // }
    } catch (error) {
      // setState(() {});
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).user;
    scrollController.addListener(() {
      if (widget.parentScrollController.hasClients) {
        widget.parentScrollController.jumpTo(
            widget.parentScrollController.offset +
                scrollController.offset -
                NewsFeedScreen.offset);
        NewsFeedScreen.offset = scrollController.offset;
      }
    });
    return SingleChildScrollView(
      controller: scrollController,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    right: 10,
                  ),
                  child: CircleAvatar(
                    backgroundImage: AssetImage(user.avatar),
                    radius: 20,
                  ),
                ),
                Expanded(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () {
                      // colorNewPost = Colors.transparent;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const DangBai()),
                      );
                    },
                    onTapUp: (tapUpDetails) {
                      setState(() {
                        colorNewPost = Colors.black12;
                      });
                    },
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        border: Border.all(
                          color: Colors.black12,
                          style: BorderStyle.solid,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        color: colorNewPost,
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        child: Text('Bạn đang nghĩ gì?'),
                      ),
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
          Container(
            width: double.infinity,
            height: 5,
            color: Colors.black26,
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 5,
                  ),
                  child: AddStoryCard(),
                ),
                ...stories
                    .map((e) => Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 5,
                          ),
                          child: StoryCard(story: e),
                        ))
                    .toList()
              ]),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            width: double.infinity,
            height: 5,
            color: Colors.black26,
          ),
          Column(
            children: posts
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
    );
  }
}
