
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class RequestAPI {
  static Future<String?> postRequest(String url, int statusCode, Map<String, dynamic> data, String token) async {

    final response = await http.post(
      Uri.parse(url), // Thay đổi URL của bạn tại đây
      body: json.encode(data),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );

    if (response.statusCode == statusCode) {
      // print('Yêu cầu POST thành công!');
      return response.body; // Trả về response.body
    } else {
      print('Lỗi: ${response.reasonPhrase}');
      print('Lỗi: ${response.statusCode}');
      return null; // Trả về null nếu có lỗi
    }
  }

}

