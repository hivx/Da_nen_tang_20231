import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';

import '../UserData/user_info.dart';

Future<Map<String, dynamic>> callAPI(
    String endpoint, Map<String, dynamic> requestData) async {
  String token = UserInfo.token;

  Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token', // Gắn kèm token vào header
  };

  String url =
      'https://it4788.catan.io.vn$endpoint'; // Thay thế bằng endpoint của API bạn muốn gửi POST request đến

  try {
    var response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(requestData),
    );

    if (response.statusCode == 200) {
      // Xử lý dữ liệu trả về khi request thành công
      print('POST request successful');
      // print(response.body);
      var data = jsonDecode(response.body);
      print(data["data"]);
      return data['data']; // Trả về dữ liệu từ response
    } else {
      // Xử lý khi có lỗi trong quá trình gửi request
      print('POST request failed with status: ${response.statusCode}');
      return {};
    }
  } catch (error) {
    // Xử lý khi có lỗi trong quá trình gửi request
    print('Error while sending POST request: $error');
    return {};
  }
}

Future<Map<String, dynamic>> callAPIcomment(
    String endpoint, Map<String, dynamic> requestData) async {
  String token =
      UserInfo.token;

  Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token', // Gắn kèm token vào header
  };

  String url =
      'https://it4788.catan.io.vn$endpoint'; // Thay thế bằng endpoint của API bạn muốn gửi POST request đến

  try {
    var response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(requestData),
    );

    if (response.statusCode == 200) {
      // Xử lý dữ liệu trả về khi request thành công
      print('POST request successful');
      // print(response.body);
      var data = jsonDecode(response.body);
      return data; // Trả về dữ liệu từ response
    } else {
      // Xử lý khi có lỗi trong quá trình gửi request
      print('POST request failed with status: ${response.statusCode}');
      return {};
    }
  } catch (error) {
    // Xử lý khi có lỗi trong quá trình gửi request
    print('Error while sending POST request: $error');
    return {};
  }
}

Future<Map<String, dynamic>> addPostWithImages(
  String endpoint,
  Map<String, dynamic> requestData,
  List<File> images,
) async {
  String token =
      UserInfo.token;

  String url = 'https://it4788.catan.io.vn$endpoint';

  try {
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers['Authorization'] = 'Bearer $token';

    requestData.forEach((key, value) {
      if (value is String) {
        request.fields[key] = value;
      }
    });

    // Thêm ảnh vào request
    for (int i = 0; i < images.length; i++) {
      List<int> imageBytes = await images[i].readAsBytes();
      request.files.add(http.MultipartFile.fromBytes(
        'image_$i',
        imageBytes,
        filename: 'file_image_$i.jpg',
        // contentType: MediaType('image', 'jpeg'),
      ));
    }

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data;
    } else {
      print('POST request failed with status: ${response.statusCode}');
      return {};
    }
  } catch (error) {
    print('Error while sending POST request: $error');
    return {};
  }
}
