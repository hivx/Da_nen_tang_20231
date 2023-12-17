import 'package:flutter/material.dart';
import 'package:anti_facebook_app/widgets/button_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ClauseSignupScreen extends StatelessWidget {
  const ClauseSignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Điều khoản & quyền riêng tư',
          style: TextStyle(fontSize: 20),
        ),
        leading: IconButton(
          icon: const FaIcon(
            FontAwesomeIcons.arrowLeft,
            // size: 48.0,
          ), // Sử dụng biểu tượng mũi tên quay lại
          onPressed: () {
            // Xử lý khi nút "Back" được nhấn
            Navigator.of(context)
                .pop(); // Đóng màn hình đăng ký và quay lại màn hình trước đó
          },
        ),
      ),
      backgroundColor: Color.fromRGBO(238, 238, 238, 1),
      body: Stack(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
                  child: const Text(
                    'Hoàn tất đăng ký',
                    style: TextStyle(
                        color: Color.fromARGB(255, 39, 41, 47),
                        fontSize: 21,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                            text: 'Bằng cách nhấn vào Đăng ký, bạn đồng ý với',
                            style: TextStyle(
                                color: Color.fromARGB(255, 125, 122, 122))),
                        TextSpan(
                            text: ' Điều khoản, Chính sách dữ liệu',
                            style: TextStyle(color: Colors.blue)),
                        TextSpan(
                            text: ' và',
                            style: TextStyle(
                                color: Color.fromARGB(255, 125, 122, 122))),
                        TextSpan(
                            text: ' Chính sách cookie',
                            style: TextStyle(color: Colors.blue)),
                        TextSpan(
                            text:
                                ' của chúng tôi. Bạn có thể nhận được thông báo của chúng tôi qua SMS và chọn không nhận bất cứ lúc nào. Thông tin từ danh bạ của bạn sẽ được tải lên Facebook liên tục để chúng tôi có thể gợi ý bạn bè, cung cấp và cải thiện quảng cáo cho bạn và người khác, cũng như mang đến dịch vụ tốt hơn.',
                            style: TextStyle(
                                color: Color.fromARGB(255, 125, 122, 122))),
                      ],
                      style: TextStyle(
                        fontSize: 16,
                        height: 1.4,
                      )),
                ),
                // const SizedBox(height: 20),
                Container(
                  margin: EdgeInsets.only(top: 40.0, bottom: 5.0),
                  child: MyButton(
                    label: 'Đăng ký',
                    onPressed: () {
                      // Xử lý đăng ký tại đây
                    },
                  ),
                ),

                MyButton(
                  label: 'Đăng ký mà không tải danh bạ của tôi lên',
                  buttonColor: const Color.fromRGBO(246, 247, 249, 1),
                  textColor: Colors.blue,
                  onPressed: () {
                    // Xử lý đăng ký tại đây
                  },
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: const Color.fromRGBO(
                  238, 238, 238, 1), // Màu nền của khối ở dưới cùng
              padding: EdgeInsets.all(16.0), // Padding của khối ở dưới cùng
              child: Center(
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text:
                            'Thông tin liên hệ trong danh bạ của bạn, bao gồm tên, số điện thoại và biệt danh, sẽ được gửi tới Facebook để chúng tôi có thể gợi ý bạn bè, cung cấp và cải thiện quảng cáo cho bạn và người khác, cũng như mang đến dịch vụ tốt hơn. Bạn có thể tắt tính năng này trong phần Cài đặt, quản lý hoặc xóa bỏ thông tin liên hệ mình đã chia sẻ với Facebook.',
                        style: TextStyle(
                            color: Color.fromARGB(255, 125, 122, 122)),
                      ),
                      TextSpan(
                        text: ' Tìm hiểu thêm',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ],
                    style: TextStyle(fontSize: 14, height: 1.4),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
