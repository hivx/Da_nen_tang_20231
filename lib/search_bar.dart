import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'network/network_request.dart';
import 'models/search_post.dart';

class SearchBarApp extends StatefulWidget {
  const SearchBarApp({Key? key}) : super(key: key);

  @override
  State<SearchBarApp> createState() => _SearchBarAppState();
}

class _SearchBarAppState extends State<SearchBarApp> {
  final TextEditingController _searchController = TextEditingController();
  bool isSearchClicked = false;
  String searchText = '';
  List<SearchPost>? searchPosts;
  List<SearchPost>? searchResults;

  @override
  void initState() {
    super.initState();
    // Gọi hàm để lấy dữ liệu từ API khi màn hình khởi tạo
    fetchAndSetSearchPosts();
  }

  Future<void> fetchAndSetSearchPosts() async {
    try {
      final networkRequest = NetworkRequest();
      final posts = await networkRequest.fetchPosts();
      setState(() {
        searchPosts = posts;
        searchResults = List.from(posts);
      });
    } catch (error) {
      // Xử lý lỗi nếu có
      if (kDebugMode) {
        print("Error fetching data: $error");
      }
    }
  }

  void _onSearchChanged(String value) async {
    setState(() {
      searchText = value;
    });

    try {
      final networkRequest = NetworkRequest();
      final request = Request(keyword: searchText);
      final posts = await networkRequest.fetchPosts(request);

      setState(() {
        searchPosts = posts;
        searchResults = List.from(posts);
      });
    } catch (error) {
      // Xử lý lỗi nếu có
      if (kDebugMode) {
        print("Error fetching data: $error");
      }
    }
  }

  void myFilterItems() {
    if (searchText.isEmpty) {
      setState(() {
        searchResults = List.from(searchPosts!);
      });
    } else {
      setState(() {
        searchResults = searchPosts!
            .where((post) =>
        post.data!
            .any((data) =>
            data.name!.toLowerCase().contains(searchText.toLowerCase())) ||
            post.data!
                .any((data) =>
                data.described!.toLowerCase().contains(searchText.toLowerCase())))
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: isSearchClicked
            ? Container(
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: TextField(
            controller: _searchController,
            onChanged: _onSearchChanged,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(16, 20, 16, 12),
              hintStyle: TextStyle(color: Colors.black),
              border: InputBorder.none,
              hintText: 'Tìm kiếm',
            ),
          ),
        )
            : const Text("Search Bar"),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isSearchClicked = !isSearchClicked;
                if (!isSearchClicked) {
                  _searchController.clear();
                  myFilterItems();
                }
              });
            },
            icon: Icon(isSearchClicked ? Icons.close : Icons.search),
          )
        ],
      ),
      body: searchResults != null
          ? ListView.builder(
        itemCount: searchResults!.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(searchResults![index].data![0].name ?? ""),
            // Hiển thị các thông tin khác theo nhu cầu
          );
        },
      )
          : const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
