import 'package:flutter/material.dart';

import '../../../models/post.dart';
import '../../comment/screens/comment_screen.dart';
import '../screen/image_fullscreen.dart';

class SingleImage extends StatelessWidget {
  final Post post;
  const SingleImage({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    List<String> icons = [];
    icons = [
      'assets/images/reactions/like.png',
      'assets/images/reactions/love.png'
    ];

    return Column(
      children: [
        ...post.image!.map((imageUrl) {
          return Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    ImageFullScreen.routeName,
                    arguments: post,
                  );
                },
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 11.5,
                      ),
                      alignment: Alignment.centerLeft,
                      width: (MediaQuery.of(context).size.width) / 3,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ImageIcon(
                            AssetImage(
                              'assets/images/like.png',
                            ),
                            color: Colors.black,
                            size: 24,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              'Thích',
                              style: TextStyle(
                                color: Colors.black,
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
                        vertical: 12,
                      ),
                      alignment: Alignment.center,
                      width: (MediaQuery.of(context).size.width) / 3,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ImageIcon(
                            AssetImage('assets/images/comment.png'),
                            color: Colors.black,
                            size: 22,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              'Bình luận',
                              style: TextStyle(
                                color: Colors.black,
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
                      alignment: Alignment.centerRight,
                      width: (MediaQuery.of(context).size.width) / 3,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ImageIcon(
                            AssetImage('assets/images/share.png'),
                            color: Colors.black,
                            size: 27,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              'Chia sẻ',
                              style: TextStyle(
                                color: Colors.black,
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
              Container(
                margin: const EdgeInsets.only(
                  top: 5,
                ),
                color: Colors.grey[400],
                height: 5,
                width: double.infinity,
              ),
            ],
          );
        }).toList(),
      ],
    );
  }
}
