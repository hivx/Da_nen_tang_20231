// class ShowPost extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     return ShowPostWidget();
//   }
// }
//
// class ShowPostWidget extends State<ShowPost> {
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Image(
//                     image: AssetImage('assets/images/icon_facebook.png'),
//                     height: 25,
//                     fit: BoxFit.cover,
//                   ),
//                   Row(
//                     children: [
//                       ClipOval(
//                         child: Material(
//                           color: Color.fromRGBO(229, 230, 235, 1),
//                           child: InkWell(
//                             onTap: () {
//                               // Xử lý khi nhấn nút tìm kiếm
//                             },
//                             child: SizedBox(
//                               width: 40, // Độ rộng của IconButton
//                               height: 40, // Độ cao của IconButton
//                               child: Icon(
//                                 Icons.search,
//                                 color: Colors.black, // Màu của icon
//                                 size: 30, // Kích thước của icon
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       SizedBox(width: 8),
//                       ClipOval(
//                         child: Material(
//                           color: Color.fromRGBO(229, 230, 235, 1),
//                           child: InkWell(
//                             onTap: () {
//                               // Xử lý khi nhấn nút tìm kiếm
//                             },
//                             child: SizedBox(
//                               width: 40, // Độ rộng của IconButton
//                               height: 40, // Độ cao của IconButton
//                               child: Icon(
//                                 FontAwesomeIcons.facebookMessenger,
//                                 color: Colors.black, // Màu của icon
//                                 size: 25, // Kích thước của icon
//                               ),
//                             ),
//                           ),
//                         ),
//                       )
//                     ],
//                   )
//                 ],
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(15),
//               child: Row(
//                 children: [
//                   ClipOval(
//                     child: Image(
//                       image: AssetImage('assets/images/default_avatar.png'),
//                       width: 50,
//                       height: 50,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                   TextButton(
//                     onPressed: () {
//                       // Xử lý khi nút được nhấn
//                     },
//                     child: const Text(
//                       'Bạn đang nghĩ gì?',
//                       style: TextStyle(
//                         color: Color.fromRGBO(101, 103, 107, 1),
//                         fontSize: 18,
//                         // fontFamily: 'Roboto'
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//             Container(
//               height: 8,
//               decoration: BoxDecoration(
//                 color: Color.fromRGBO(201, 204, 209, 1), // Màu nền của Container
//               ),
//             )
//           ]
//         )
//       ),
//     );
//   }
// }

