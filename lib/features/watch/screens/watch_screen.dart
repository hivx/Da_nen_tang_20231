import 'package:anti_facebook_app/features/watch/widgets/watch_video.dart';
import 'package:anti_facebook_app/models/user.dart';
import 'package:anti_facebook_app/utils/httpRequest.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:video_player/video_player.dart';

import '../../../models/post.dart';

class WatchScreen extends StatefulWidget {
  static double offset = 0;
  const WatchScreen({super.key});

  @override
  State<WatchScreen> createState() => _WatchScreenState();
}

class VideoControllerWrapper {
  VideoPlayerController? value;
  VideoControllerWrapper(this.value);
}

class _WatchScreenState extends State<WatchScreen> {
  ScrollController scrollController =
      ScrollController(initialScrollOffset: WatchScreen.offset);
  ScrollController headerScrollController = ScrollController();
  int index = 0;
  List<VideoControllerWrapper> videoController = [];
  List<Post> posts = [
    // Post(
    //   user: User(name: 'Spezon', avatar: 'https://picsum.photos/250?image=9'),
    //   time: '27 tháng 8',
    //   shareWith: 'public',
    //   content: 'Lionel Messi World cup Champion [Messi EP. FINAL]',
    //   like: 4100,
    //   angry: 1,
    //   comment: 72,
    //   haha: 21,
    //   love: 888,
    //   lovelove: 100,
    //   sad: 20,
    //   share: 98,
    //   wow: 5,
    //   video:
    //       'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
    // ),
  ];
  List<GlobalKey> key = [];

  @override
  void initState() {
    super.initState();
    _callAPI();
    // videoController =
    //     List.generate(posts.length, (index) => VideoControllerWrapper(null));
    // key = List.generate(
    //     posts.length, (index) => GlobalKey(debugLabel: index.toString()));
    // setState(() {});
  }

  Future<void> _callAPI() async {
    try {
      Map<String, dynamic> requestData = {"index": "0", "count": "10"};

      var result = await callAPI('/get_list_videos', requestData);
      posts = postsFromJson(result['post']);
      videoController =
          List.generate(posts.length, (index) => VideoControllerWrapper(null));
      key = List.generate(
          posts.length, (index) => GlobalKey(debugLabel: index.toString()));
      setState(() {});
    } catch (error) {
      // setState(() {});
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    headerScrollController.dispose();
    for (int i = 0; i < videoController.length; i++) {
      videoController[i].value?.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    scrollController.addListener(() {
      headerScrollController.jumpTo(headerScrollController.offset +
          scrollController.offset -
          WatchScreen.offset);
      WatchScreen.offset = scrollController.offset;
    });
    return Scaffold(
      body: NestedScrollView(
        controller: headerScrollController,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            toolbarHeight: 70,
            titleSpacing: 0,
            pinned: true,
            floating: true,
            primary: false,
            centerTitle: true,
            automaticallyImplyLeading: false,
            snap: true,
            forceElevated: innerBoxIsScrolled,
            bottom: const PreferredSize(
                preferredSize: Size.fromHeight(0), child: SizedBox()),
            title: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            splashRadius: 20,
                            onPressed: () {},
                            icon: const ImageIcon(
                              AssetImage('assets/images/menu.png'),
                              color: Colors.black,
                              size: 50,
                            ),
                          ),
                          const Text(
                            'Video',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 21,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            width: 35,
                            height: 35,
                            padding: const EdgeInsets.all(0),
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.black12,
                            ),
                            child: IconButton(
                              splashRadius: 18,
                              padding: const EdgeInsets.all(0),
                              onPressed: () {},
                              icon: const Icon(
                                Icons.person_rounded,
                                color: Colors.black,
                                size: 24,
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            width: 35,
                            height: 35,
                            padding: const EdgeInsets.all(0),
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.black12,
                            ),
                            child: IconButton(
                              splashRadius: 18,
                              padding: const EdgeInsets.all(0),
                              onPressed: () {},
                              icon: const Icon(
                                Icons.search,
                                color: Colors.black,
                                size: 24,
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
          )
        ],
        body: NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scroll) {
            for (int i = 0; i < posts.length; i++) {
              var currentContext = key[i].currentContext;
              if (currentContext == null) continue;

              var renderObject = currentContext.findRenderObject();
              RenderAbstractViewport viewport =
                  RenderAbstractViewport.of(renderObject);
              var offsetToRevealBottom =
                  viewport.getOffsetToReveal(renderObject!, 1.0);
              var offsetToRevealTop =
                  viewport.getOffsetToReveal(renderObject, 0.0);

              if (offsetToRevealBottom.offset > scroll.metrics.pixels ||
                  scroll.metrics.pixels > offsetToRevealTop.offset) {
                //print('$i out of viewport');
              } else {
                //print('$i in viewport');
                if (videoController[i].value != null) {
                  if (videoController[i].value!.value.isInitialized) {
                    videoController[i].value!.play();
                  }
                }
              }
            }
            return false;
          },
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              children: [
                Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 5,
                      color: Colors.black26,
                    ),
                    ...posts.asMap().entries.map((e) {
                      return Column(
                        children: [
                          WatchVideo(
                            post: e.value,
                            videoKey: key[e.key],
                            controller: videoController[e.key],
                            autoPlay: e.key == 0,
                          ),
                          Container(
                            width: double.infinity,
                            height: 5,
                            color: Colors.black26,
                          ),
                        ],
                      );
                    }).toList(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
