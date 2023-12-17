import 'package:flutter/material.dart';

class FindAccount extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FindAccountWidget();
  }
}

class FindAccountWidget extends State<FindAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          margin: const EdgeInsets.only(left: 15.0, right: 15.0),
          child: Stack(
              children: [
                Column(
                  children: [
                    const SizedBox(height: 80),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Tìm tài khoản',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: Colors.black
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Nhập số di động hoặc địa chỉ email của bạn.',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    const TextField(
                      autofocus: true,
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                      decoration: InputDecoration(
                          labelText: 'Số di động hoặc email',
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.bold, // Độ đậm
                            fontSize: 20.0, // Kích thước chữ
                          ),
                          border: OutlineInputBorder()
                      ),
                    ),
                    const SizedBox(height: 20),
                    FractionallySizedBox(
                      widthFactor: 1.0,
                      child: SizedBox(
                        height: 50,
                        child: ElevatedButton(
                            onPressed: null,
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(const Color.fromRGBO(24, 119, 242, 1)), // Đặt màu nền
                            ),
                            child: const Text(
                              'Tìm tài khoản',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white
                              ),
                            )
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  top: 20,
                  left: -15,
                  child: IconButton(
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      Navigator.pop(context);
                      // Navigator.of(context).push(_customPageRoute(Login()));
                    },
                    icon: const Icon(Icons.arrow_back, color: Colors.black,),
                  ),
                )
              ]

          ),
        )
    );
  }
}

