// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// import 'logout.dart';
// import 'main.dart';

// class Home extends State<MyHomePage> with TickerProviderStateMixin {
//   late final TabController _tabController;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 5, vsync: this);
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           "Facebook",
//           style: TextStyle(
//             fontSize: 24.0,
//             fontWeight: FontWeight.bold,
//             color: Colors.blue,
//             fontFamily: 'Arial',
//           ),
//         ),
//         automaticallyImplyLeading: false,
//         bottom: TabBar(
//           controller: _tabController,
//           tabs: const <Widget>[
//             Tab(
//               icon: Icon(Icons.home),
//             ),
//             Tab(
//               icon: Icon(Icons.groups_rounded),
//             ),
//             Tab(
//               icon: Icon(Icons.people_outline),
//             ),
//             Tab(
//               icon: Icon(Icons.notifications),
//             ),
//             Tab(
//               icon: Icon(Icons.menu),
//             ),
//           ],
//         ),
//       ),
//       body: TabBarView(
//         controller: _tabController,
//         children: <Widget>[
//           const Center(
//             child: Text("Home View"),
//           ),
//           const Center(
//             child: Text("Group View"),
//           ),
//           const Center(
//             child: Text("Friend View"),
//           ),
//           const Center(
//             child: Text("Notification View"),
//           ),
//           Logout(),
//         ],
//       ),
//     );
//   }
// }
