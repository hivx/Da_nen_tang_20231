import 'package:flutter/material.dart';
import 'package:anti_facebook_app/services/post_service.dart';

class PostListScreen extends StatefulWidget {
  @override
  _PostListScreenState createState() => _PostListScreenState();
}

class _PostListScreenState extends State<PostListScreen> {
  List<dynamic>? posts;

  @override
  void initState() {
    super.initState();
    fetchPosts(); // Gọi hàm để lấy danh sách bài đăng khi StatefulWidget được khởi tạo
  }

  Future<void> fetchPosts() async {
    try {
      final fetchedPosts = await PostService.fetchListPosts();
      setState(() {
        posts = fetchedPosts;
        print('$posts');
      });
    } catch (e) {
      print('Error fetching posts: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List of Posts'),
      ),
      // body: posts != null
      //     ? ListView.builder(
      //         itemCount: posts!.length,
      //         itemBuilder: (context, index) {
      //           return ListTile(
      //             title: Text(posts![index]['title']),
      //             subtitle: Text(posts![index]['body']),
      //           );
      //         },
      //       )
      //     : Center(
      //         child: CircularProgressIndicator(),
      //       ),
    );
  }
}
