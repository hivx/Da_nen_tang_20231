import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

import '../models/search_post.dart';

class NetworkRequest {
  static const String url = 'https://it4788.catan.io.vn/search';
  final String authToken = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ODg2LCJkZXZpY2VfaWQiOiJzdHJpbmciLCJpYXQiOjE3MDI3NzI0OTZ9.gvFieSd-eC7-WwrY5J914QCJZWPR4vMQ-1cS87oHy8A';

  List<SearchPost> parsePost(String responseBody) {
    var list = json.decode(responseBody) as List<dynamic>;
    return list.map((model) => SearchPost.fromJson(model)).toList();
  }
  Future<List<SearchPost>> fetchPosts(Request request) async {
    final Map<String, dynamic> requestBody = {
      'keyword': request.keyword,
      'user_id': request.userId,
      'index': request.index,
      'count': request.count,
    };

    var response = await http.post(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $authToken',
        'Content-Type': 'application/json',
      },
      body: json.encode(requestBody),
    );

    if (response.statusCode == 200) {
      return compute(parsePost, response.body);
    } else if (response.statusCode == 404) {
      throw Exception('Not Found');
    } else {
      throw Exception('Can\'t get searchPost');
    }
  }
}
