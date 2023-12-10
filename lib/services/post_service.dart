import 'dart:convert';
import 'package:anti_facebook_app/utils/httpRequest.dart';

class PostService {
  static Future<List<dynamic>> fetchListPosts() async {
    try {
      final response =
          await HttpService.post(''); // Điều chỉnh path để phản ánh API của bạn
      final List<dynamic> posts =
          jsonDecode(response); // Chuyển đổi chuỗi JSON thành danh sách

      return posts; // Trả về danh sách bài đăng từ API
    } catch (e) {
      throw Exception('Failed to fetch posts: $e');
    }
  }

  // static Future<void> createPost(Map<String, dynamic> postData) async {
  //   try {
  //     await HttpService.post('/posts',
  //         postData); // Điều chỉnh path và dữ liệu postData để phản ánh API của bạn
  //   } catch (e) {
  //     throw Exception('Failed to create post: $e');
  //   }
  // }

  // static Future<void> updatePost(
  //     int postId, Map<String, dynamic> updatedData) async {
  //   try {
  //     await HttpService.put('/posts/$postId',
  //         updatedData); // Điều chỉnh path và dữ liệu updatedData để phản ánh API của bạn
  //   } catch (e) {
  //     throw Exception('Failed to update post: $e');
  //   }
  // }

  // static Future<void> deletePost(int postId) async {
  //   try {
  //     await HttpService.delete(
  //         '/posts/$postId'); // Điều chỉnh path để phản ánh API của bạn
  //   } catch (e) {
  //     throw Exception('Failed to delete post: $e');
  //   }
  // }
}
