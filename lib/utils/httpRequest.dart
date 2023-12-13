import 'package:http/http.dart' as http;
import 'dart:convert';

Future<Map<String, dynamic>> callAPI(String endpoint, Map<String, dynamic> requestData) async {
  String token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NjE0LCJkZXZpY2VfaWQiOiJzdHJpbmciLCJpYXQiOjE3MDI0NTc1MTB9.zGEjPP__HtAp0_wApgHHezOJroOPayFgp__SWoUDrCU'; // Đây là access token của bạn

  Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token', // Gắn kèm token vào header
  };

  String url = 'https://it4788.catan.io.vn$endpoint'; // Thay thế bằng endpoint của API bạn muốn gửi POST request đến

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
      return data['data']; // Trả về dữ liệu từ response
    } else {
      // Xử lý khi có lỗi trong quá trình gửi request
      print('POST request failed with status: ${response.statusCode}');
      return {}; // Trả về một dữ liệu mặc định (có thể là một object trống)
    }
  } catch (error) {
    // Xử lý khi có lỗi trong quá trình gửi request
    print('Error while sending POST request: $error');
    return {}; // Trả về một dữ liệu mặc định (có thể là một object trống)
  }
}
