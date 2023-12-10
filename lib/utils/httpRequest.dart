import 'package:http/http.dart' as http;

class HttpService {
  // static final http.Client _client = http.Client();
  // static const String baseUrl =
  //     'https://it4788.catan.io.vn/get_list_posts'; // Thay đổi baseURL của bạn

  // static Future<dynamic> post(String path,
  //     {Map<String, String>? headers}) async {
  //   final response =
  //       await _client.get(Uri.parse('$baseUrl$path'), headers: headers);
  //   return _handleResponse(response);
  // }

  // static Future<dynamic> post(String path, dynamic data,
  //     {Map<String, String>? headers}) async {
  //   final response = await _client.post(
  //     Uri.parse('$baseUrl$path'),
  //     headers: headers,
  //     body: data,
  //   );
  //   return _handleResponse(response);
  // }

  // static Future<dynamic> put(String path, dynamic data,
  //     {Map<String, String>? headers}) async {
  //   final response = await _client.put(
  //     Uri.parse('$baseUrl$path'),
  //     headers: headers,
  //     body: data,
  //   );
  //   return _handleResponse(response);
  // }

  // static Future<dynamic> delete(String path,
  //     {Map<String, String>? headers}) async {
  //   final response =
  //       await _client.delete(Uri.parse('$baseUrl$path'), headers: headers);
  //   return _handleResponse(response);
  // }

  static dynamic _handleResponse(http.Response response) {
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to fetch data');
    }
  }
}
