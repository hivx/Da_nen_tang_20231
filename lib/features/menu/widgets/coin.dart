import 'dart:math';

import 'package:anti_facebook_app/features/menu/screens/menu_screen.dart';
import 'package:anti_facebook_app/utils/httpRequest.dart';
import 'package:flutter/material.dart';

class Coin extends StatefulWidget {
  final String title;

  const Coin({Key? key, required this.title}) : super(key: key);

  @override
  State<Coin> createState() => _CoinState();
}

class _CoinState extends State<Coin> {
  double borderWidth = 1.0;
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final FocusNode _focusNode2 = FocusNode();
  String code = '';
  String coins = '';

  @override
  void initState() {
    super.initState();
    _focusNode2.addListener(() {
      if (_focusNode2.hasFocus) {
        setState(() {
          borderWidth = 2.0; // Thay đổi border khi TextField được focus
        });
      } else {
        setState(() {
          borderWidth = 1.0; // Reset lại border khi không còn focus
        });
      }
    });
    _focusNode2.addListener(() {
      if (_focusNode2.hasFocus) {
        setState(() {
          borderWidth = 2.0; // Thay đổi border khi TextField được focus
        });
      } else {
        setState(() {
          borderWidth = 1.0; // Reset lại border khi không còn focus
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _controller2.dispose();
    _focusNode.dispose();
    _focusNode2.dispose();
    super.dispose();
  }

  Future<void> buyCoins() async {
    try {
      Map<String, dynamic> requestData = {"code": code, "coins": coins};

      var result = await callAPI('/buy_coins',
          requestData); // Sử dụng 'await' để đợi kết thúc của hàm callAPI
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MenuScreen()),
      );
    } catch (error) {
      // setState(() {});
    }
  }

  void _showModal(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.9,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.black, // Màu sắc của đường viền dưới
                        width: 1.0, // Độ dày của đường viền dưới
                      ),
                    ),
                  ),
                  child: const Row(
                    children: [
                      Text(
                        'Mua coin',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                        child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: (TextField(
                              focusNode: _focusNode,
                              controller: _controller,
                              decoration: const InputDecoration(
                                hintText: 'Nhập Code...',
                                labelText: 'Code',
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black, // Màu đường viền
                                    width: 1.0, // Độ dày đường viền
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors
                                        .black, // Màu sắc border khi focus
                                    width: 1.0,
                                  ),
                                ),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  code = value;
                                });
                              },
                            )))),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextField(
                          focusNode: _focusNode2,
                          controller: _controller2,
                          decoration: const InputDecoration(
                            hintText: 'Nhập Coins...',
                            labelText: 'Coins',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 1.0,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black, // Màu sắc border khi focus
                                width: 1.0,
                              ),
                            ),
                          ),
                          onChanged: (value) {
                            setState(() {
                              coins = value;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF1878F3),
                          shadowColor: Color(0xFF1878F3),
                          side: const BorderSide(
                            color: Colors.black12,
                            width: 0.5,
                          ),
                        ),
                        onPressed: () {
                          buyCoins();
                        },
                        child: const Text(
                          'Xác nhận',
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showModal(context);
      },
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.currency_bitcoin_sharp,
            color: Color.fromARGB(255, 99, 99, 7),
            size: 27.0,
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            'Mua Coin',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          )
        ],
      ),
    );
  }
}
