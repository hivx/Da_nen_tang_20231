// import 'package:anti_facebook_app/dangbai.dart';
// import 'package:anti_facebook_app/login.dart';
// import 'package:flutter/material.dart';

// class Logout extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: SingleChildScrollView(
//         child: Container(
//             color: Color(int.parse('0xff' + 'f2f3f5')),
//             child: Padding(
//               padding: EdgeInsets.all(10),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 mainAxisSize: MainAxisSize.max,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 verticalDirection: VerticalDirection.down,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       Expanded(
//                         child: Container(
//                           width: MediaQuery.of(context).size.width / 2,
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Container(
//                                   width: double.infinity,
//                                   height: 100,
//                                   decoration: const BoxDecoration(
//                                     color: Colors.white,
//                                     borderRadius:
//                                         BorderRadius.all(Radius.circular(10)),
//                                   ),
//                                   child: Padding(
//                                     padding: EdgeInsets.all(10),
//                                     child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Icon(Icons.person_add_alt_1_sharp,
//                                             color: Colors.blue),
//                                         Text("Bạn bè"),
//                                       ],
//                                     ),
//                                   )),
//                               SizedBox(height: 10),
//                               GestureDetector(
//                                 onTap: () {
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) => DangBai()),
//                                   );
//                                 },
//                                 child: Container(
//                                     width: double.infinity,
//                                     height: 100,
//                                     decoration: const BoxDecoration(
//                                       color: Colors.white,
//                                       borderRadius:
//                                           BorderRadius.all(Radius.circular(10)),
//                                     ),
//                                     child: Padding(
//                                       padding: EdgeInsets.all(10),
//                                       child: Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Icon(
//                                             Icons.tv,
//                                             color: Colors.blue,
//                                           ),
//                                           Text("Đăng bài"),
//                                         ],
//                                       ),
//                                     )),
//                               ),
//                               SizedBox(height: 10),
//                               Container(
//                                   width: double.infinity,
//                                   height: 100,
//                                   decoration: const BoxDecoration(
//                                     color: Colors.white,
//                                     borderRadius:
//                                         BorderRadius.all(Radius.circular(10)),
//                                   ),
//                                   child: Padding(
//                                     padding: EdgeInsets.all(10),
//                                     child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Icon(
//                                           Icons.bookmark,
//                                           color: Color(0xff7b3ee2),
//                                         ),
//                                         Text("Đã lưu"),
//                                       ],
//                                     ),
//                                   )),
//                               SizedBox(height: 10),
//                               Container(
//                                   width: double.infinity,
//                                   height: 100,
//                                   decoration: const BoxDecoration(
//                                     color: Colors.white,
//                                     borderRadius:
//                                         BorderRadius.all(Radius.circular(10)),
//                                   ),
//                                   child: Padding(
//                                     padding: EdgeInsets.all(10),
//                                     child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Icon(Icons.calendar_month,
//                                             color: Color(0xffe892a2)),
//                                         Text("Sự kiện"),
//                                       ],
//                                     ),
//                                   )),
//                               SizedBox(height: 10),
//                               Container(
//                                   width: double.infinity,
//                                   height: 100,
//                                   decoration: const BoxDecoration(
//                                     color: Colors.white,
//                                     borderRadius:
//                                         BorderRadius.all(Radius.circular(10)),
//                                   ),
//                                   child: Padding(
//                                     padding: EdgeInsets.all(10),
//                                     child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Icon(
//                                           Icons.work,
//                                           color: Color(0xffbe6a1a),
//                                         ),
//                                         Text("Việc làm"),
//                                       ],
//                                     ),
//                                   )),
//                               SizedBox(height: 10),
//                             ],
//                           ),
//                         ),
//                       ),
//                       SizedBox(width: 10),
//                       Expanded(
//                         child: Container(
//                           width: MediaQuery.of(context).size.width / 2,
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Container(
//                                   width: double.infinity,
//                                   height: 100,
//                                   decoration: const BoxDecoration(
//                                     color: Colors.white,
//                                     borderRadius:
//                                         BorderRadius.all(Radius.circular(10)),
//                                   ),
//                                   child: Padding(
//                                     padding: EdgeInsets.all(10),
//                                     child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Icon(
//                                           Icons.watch_later_outlined,
//                                           color: Colors.blue,
//                                         ),
//                                         Text("Kỷ niệm"),
//                                       ],
//                                     ),
//                                   )),
//                               SizedBox(height: 10),
//                               Container(
//                                   width: double.infinity,
//                                   height: 100,
//                                   decoration: const BoxDecoration(
//                                     color: Colors.white,
//                                     borderRadius:
//                                         BorderRadius.all(Radius.circular(10)),
//                                   ),
//                                   child: Padding(
//                                     padding: EdgeInsets.all(10),
//                                     child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Icon(
//                                           Icons.music_video,
//                                           color: Colors.amberAccent,
//                                         ),
//                                         Text("Reels"),
//                                       ],
//                                     ),
//                                   )),
//                               SizedBox(height: 10),
//                               Container(
//                                   width: double.infinity,
//                                   height: 100,
//                                   decoration: const BoxDecoration(
//                                     color: Colors.white,
//                                     borderRadius:
//                                         BorderRadius.all(Radius.circular(10)),
//                                   ),
//                                   child: Padding(
//                                     padding: EdgeInsets.all(10),
//                                     child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Icon(
//                                           Icons.flag_rounded,
//                                           color: Color(0xfff16a2c),
//                                         ),
//                                         Text("Trang"),
//                                       ],
//                                     ),
//                                   )),
//                               SizedBox(height: 10),
//                               Container(
//                                   width: double.infinity,
//                                   height: 100,
//                                   decoration: const BoxDecoration(
//                                     color: Colors.white,
//                                     borderRadius:
//                                         BorderRadius.all(Radius.circular(10)),
//                                   ),
//                                   child: Padding(
//                                     padding: EdgeInsets.all(10),
//                                     child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Icon(Icons.gamepad_outlined,
//                                             color: Colors.blue),
//                                         Text("Chơi game"),
//                                       ],
//                                     ),
//                                   )),
//                               SizedBox(height: 10),
//                               Container(
//                                   width: double.infinity,
//                                   height: 100,
//                                   decoration: const BoxDecoration(
//                                     color: Colors.white,
//                                     borderRadius:
//                                         BorderRadius.all(Radius.circular(10)),
//                                   ),
//                                   child: Padding(
//                                     padding: EdgeInsets.all(10),
//                                     child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Icon(
//                                           Icons.home_work_outlined,
//                                           color: Colors.blueAccent,
//                                         ),
//                                         Text("Chợ"),
//                                       ],
//                                     ),
//                                   )),
//                               SizedBox(height: 10),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   // 3 thành phần còn lại của cột cha là các containre
//                   Container(
//                       height: 50,
//                       width: MediaQuery.of(context).size.width,
//                       decoration: const BoxDecoration(
//                         color: Color(0xffe7e8ea),
//                         borderRadius: BorderRadius.all(Radius.circular(10)),
//                       ),
//                       child: Center(
//                         child: Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             Padding(
//                               padding: EdgeInsets.all(10),
//                               child: Icon(Icons.multiline_chart,
//                                   color: Colors.blue),
//                             ),
//                             Center(
//                               child: Text("Xem thêm"),
//                             )
//                           ],
//                         ),
//                       )),
//                   SizedBox(height: 10),
//                   Container(
//                       height: 50,
//                       width: MediaQuery.of(context).size.width,
//                       decoration: const BoxDecoration(
//                         color: Color(0xffe7e8ea),
//                         borderRadius: BorderRadius.all(Radius.circular(10)),
//                       ),
//                       child: Center(
//                         child: Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             Padding(
//                               padding: EdgeInsets.all(10),
//                               child:
//                                   Icon(Icons.question_mark, color: Colors.grey),
//                             ),
//                             Center(
//                               child: Text("Câu hỏi và trợ giúp"),
//                             )
//                           ],
//                         ),
//                       )),
//                   SizedBox(height: 10),
//                   Container(
//                       height: 50,
//                       width: MediaQuery.of(context).size.width,
//                       decoration: const BoxDecoration(
//                         color: Color(0xffe7e8ea),
//                         borderRadius: BorderRadius.all(Radius.circular(10)),
//                       ),
//                       child: Center(
//                         child: Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             Padding(
//                               padding: EdgeInsets.all(10),
//                               child: Icon(Icons.settings_rounded,
//                                   color: Colors.grey),
//                             ),
//                             Center(
//                               child: Text("Cài đặt quyền riêng tư"),
//                             )
//                           ],
//                         ),
//                       )),
//                   SizedBox(height: 10),
//                   Container(
//                       height: 50,
//                       width: MediaQuery.of(context).size.width,
//                       decoration: const BoxDecoration(
//                         color: Color(0xffe7e8ea),
//                         borderRadius: BorderRadius.all(Radius.circular(10)),
//                       ),
//                       child: Center(
//                         child: Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             Padding(
//                               padding: EdgeInsets.all(10),
//                               child: Icon(Icons.logout, color: Colors.grey),
//                             ),
//                             GestureDetector(
//                               onTap: () {
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) => Login()),
//                                 );
//                               },
//                               child: Center(
//                                 child: Text("Đăng xuất"),
//                               ),
//                             )
//                           ],
//                         ),
//                       )),
//                   SizedBox(height: 10),
//                 ],
//               ),
//             )),
//       ),
//     );
//   }
// }
