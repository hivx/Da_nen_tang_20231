import 'dart:convert';
import 'dart:io';

import 'package:anti_facebook_app/constants/global_variables.dart';
import 'package:anti_facebook_app/features/personal-page/screens/personal_page_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../models/user.dart';
import '../../../providers/user_provider.dart';

class EditUserPage extends StatefulWidget {
  static const String routeName = '/edit-user-page';
  final User user;

  const EditUserPage({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  _EditUserPageState createState() => _EditUserPageState();
}

class _EditUserPageState extends State<EditUserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Chỉnh sửa trang cá nhân',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: ProfileContent(
          user: widget.user!,
        ),
      ),
    );
  }
}

class ProfileContent extends StatefulWidget {
  final User user;

  const ProfileContent({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  _ProfileContentState createState() => _ProfileContentState();
}

class _ProfileContentState extends State<ProfileContent> {
  late String networkcoverimage = "";
  late String userName = widget.user.name;
  late String? avatarImagePath = "";
  late String? coverImagePath = "";
  late String? description = widget.user.bio;
  late String? city = widget.user.city;
  late String? hometown = widget.user.hometown;
  late String? country = widget.user.country;
  late String? address = widget.user.address;
  late int follower = 10;
  late String school = "";
  late String relationship = "";
  late String? linkUser = widget.user.link;

  late bool isEditUserName = false;
  late bool isEditDetail = false;
  late bool isEditDes = false;
  late bool isEditLink = false;
  @override
  void initState() {
    super.initState();
    if (widget.user.cover != null) {
      networkcoverimage = widget.user.cover!;
    }
  }

  TextEditingController userNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController linkController = TextEditingController();

  final ImagePicker imagePicker = ImagePicker();
  void selectImages() async {
    var selectedImages =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (selectedImages != null) {
      setState(() {
        avatarImagePath = selectedImages.path;
      });
    }
  }

  void pickCoverImage() async {
    final XFile? selectedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (selectedImage != null) {
      setState(() {
        coverImagePath = selectedImage.path;
      });
    }
  }

  final String setUserInfo = 'https://it4788.catan.io.vn/set_user_info';
  final String authToken = GlobalVariables.token;

  Future setUserData() async {
    var url = Uri.parse(setUserInfo);
    var formData = http.MultipartRequest('POST', url);
    formData.headers['Authorization'] = 'Bearer $authToken';
    if (userName.isNotEmpty) {
      formData.fields['username'] = userName;
    }

    if (description!.isNotEmpty) {
      formData.fields['description'] = description!;
    }

    if (country!.isNotEmpty) {
      formData.fields['country'] = country!;
    }

    if (city!.isNotEmpty) {
      formData.fields['city'] = city!;
    }

    if (address!.isNotEmpty) {
      formData.fields['address'] = address!;
    }

    if (linkUser!.isNotEmpty) {
      formData.fields['link'] = linkUser!;
    }

    if (avatarImagePath != null && avatarImagePath!.isNotEmpty) {
      File avatarFile = File(avatarImagePath!);
      if (avatarFile.existsSync()) {
        List<int> avatarBytes = await avatarFile.readAsBytes();
        formData.files.add(
          http.MultipartFile.fromBytes('avatar', avatarBytes, filename: 'avatar.jpg'),
        );
      } else {
        print('Avatar file not found');
      }
    }

// Chuyển từ MultipartFile.fromPath sang MultipartFile.fromBytes cho cover image
    if (coverImagePath != null && coverImagePath!.isNotEmpty) {
      File coverFile = File(coverImagePath!);
      if (coverFile.existsSync()) {
        List<int> coverBytes = await coverFile.readAsBytes();
        formData.files.add(
          http.MultipartFile.fromBytes('cover_image', coverBytes, filename: 'cover_image.jpg'),
        );
      } else {
        print('Cover image file not found');
      }
    }
    try {
      formData.send().then((response) {
        response.stream.bytesToString().then((value) {
          print(json.decode(value)['message']);
          if(json.decode(value)['message'] == "OK") {
            UserProvider userProvider = UserProvider();
            userProvider.updateUserData(name: userName, avatar: avatarImagePath, cover_image : coverImagePath, city: city, country: country , address: address, description: description, link: linkUser);
          }
          Navigator.pushNamed(
            context,
            PersonalPageScreen.routeName,
            arguments: Provider.of<UserProvider>(context, listen: false).user,
          );
        });
      });
      // final response = await formData.send();
      // if (response.statusCode == 201) {
      //   print("success");
      //   // UserProvider userProvider = UserProvider();
      //   // userProvider.updateUserData(name: userName, avatar: avatarImagePath, cover_image : coverImagePath, city: city, country: country , address: address, description: description, link: linkUser);
      // } else {
      //   throw Exception(
      //       'Failed to post data. Status code: ${response.statusCode} ${response.stream.bytesToString().toString()}');
      // }

    } catch (e) {
      print('Error4: $e');
      throw Exception('Failed to post data');
    }
  }
  // Future setUserData() async {
  //   var url = Uri.parse(setUserInfo);
  //   var request = http.MultipartRequest('POST', url);
  //
  //   request.headers['Authorization'] = 'Bearer $authToken';
  //
  //   request.fields['username'] = userName;
  //   request.fields['description'] = description ?? '';
  //   request.fields['country'] = country ?? '';
  //   request.fields['city'] = city ?? '';
  //   request.fields['address'] = address ?? '';
  //   request.fields['link'] = linkUser ?? '';
  //
  //   if (avatarImagePath != null && avatarImagePath!.isNotEmpty) {
  //     var avatarFile = await http.MultipartFile.fromPath('avatar', avatarImagePath!);
  //     request.files.add(avatarFile);
  //   }
  //
  //   if (coverImagePath != null && coverImagePath!.isNotEmpty) {
  //     var coverFile = await http.MultipartFile.fromPath('cover_image', coverImagePath!);
  //     request.files.add(coverFile);
  //   }
  //
  //   try {
  //     var response = await request.send();
  //
  //     if (response.statusCode == 201) {
  //       print("Success");
  //     } else {
  //       throw Exception('Failed to post data. Status code: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     print('Error: $e');
  //     throw Exception('Failed to post data');
  //   }
  // }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          !isEditUserName
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      userName,
                      style: const TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          isEditUserName = true;
                        });
                      },
                      child: Text(
                        'Chỉnh sửa',
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                  ],
                )
              : TextFormField(
                  controller: userNameController,
                  decoration: InputDecoration(
                    labelText: 'Enter your username',
                    suffixIcon: IconButton(
                      icon: Icon(Icons.save),
                      onPressed: () {
                        setState(() {
                          userName = userNameController.text;
                          isEditUserName = false;
                        });
                      },
                    ),
                  ),
                ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Ảnh đại diện',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {
                  selectImages();
                },
                child: Text(
                  'Chỉnh sửa',
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                ),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.transparent,
                ),
              ),
            ],
          ),
          SizedBox(height: 30),
          Center(
            child: avatarImagePath != ""
                ? Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: FileImage(
                          File(avatarImagePath!),
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                : Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(widget.user.avatar),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
          ),
          SizedBox(height: 20),
          Divider(
            color: Colors.grey,
            thickness: 1, // Độ dày của đường gạch
            height: 5, // Chiều cao của đường gạch
            indent: 5, // Khoảng cách từ lề trái
            endIndent: 5, // Khoảng cách từ lề phải
          ),
          SizedBox(height: 10),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Ảnh bìa',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // Xử lý sự kiện khi nút được nhấn
                  },
                  child: Text(
                    'Chỉnh sửa',
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.transparent,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          Center(
            child: coverImagePath != ""
                ? Container(
                    width: 360,
                    height: 180,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: FileImage(
                          File(coverImagePath!),
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                : Container(
                    width: 360,
                    height: 180,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(networkcoverimage),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
          ),
          SizedBox(height: 20),
          Divider(
            color: Colors.grey,
            thickness: 1, // Độ dày của đường gạch
            height: 10, // Chiều cao của đường gạch
            indent: 5, // Khoảng cách từ lề trái
            endIndent: 5, // Khoảng cách từ lề phải
          ),
          SizedBox(height: 10),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Tiểu sử',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    if (isEditDes) {
                      setState(() {
                        description = descriptionController.text;
                      });
                    }
                    setState(() {
                      isEditDes = !isEditDes;
                    });
                  },
                  child: Text(
                    !isEditDes ? 'Chỉnh sửa' : 'lưu',
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.transparent,
                  ),
                ),
              ],
            ),
          ),
          !isEditDes
              ? Container(
                  child: Text(
                    description!,
                    style: TextStyle(fontSize: 18.0),
                  ),
                )
              : Container(
                  child: TextFormField(
                    controller: descriptionController,
                    decoration: InputDecoration(
                      hintText: widget.user.bio,
                    ),
                  ),
                ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Chi tiết',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    if (isEditDetail) {
                      setState(() {
                        city = cityController.text;
                        address = addressController.text;
                        country = countryController.text;
                      });
                    }
                    setState(() {
                      isEditDetail = !isEditDetail;
                    });
                  },
                  child: Text(
                    !isEditDetail ? 'Chỉnh sửa' : 'lưu',
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.transparent,
                  ),
                ),
              ],
            ),
          ),
          !isEditDetail
              ? Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons
                              .work, // This is the icon you want to use; you can change it to any other icon you prefer.
                          size: 20,
                          color: Colors
                              .grey, // Adjust the size of the icon as needed
                        ),
                        SizedBox(
                            width: 10), // Spacing between the icon and the text
                        Text(
                          city!,
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.home,
                          size: 20,
                          color: Colors.grey,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Sống tại ' + address!,
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons
                              .place, // This is the icon you want to use; you can change it to any other icon you prefer.
                          size: 20,
                          color: Colors
                              .grey, // Adjust the size of the icon as needed
                        ),
                        SizedBox(
                            width: 10), // Spacing between the icon and the text
                        Text(
                          'Đến từ ' + country!,
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons
                              .wifi, // This is the icon you want to use; you can change it to any other icon you prefer.
                          size: 20,
                          color: Colors
                              .grey, // Adjust the size of the icon as needed
                        ),
                        SizedBox(
                            width: 10), // Spacing between the icon and the text
                        Text(
                          'Có ' + follower!.toString() + ' người theo dõi',
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons
                              .school, // This is the icon you want to use; you can change it to any other icon you prefer.
                          size: 20,
                          color: Colors
                              .grey, // Adjust the size of the icon as needed
                        ),
                        SizedBox(
                            width: 10), // Spacing between the icon and the text
                        Text(
                          school!,
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons
                              .favorite, // This is the icon you want to use; you can change it to any other icon you prefer.
                          size: 20,
                          color: Colors
                              .grey, // Adjust the size of the icon as needed
                        ),
                        SizedBox(
                            width: 10), // Spacing between the icon and the text
                        Text(
                          relationship!,
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ],
                    ),
                  ],
                )
              : Column(
                  children: [
                    TextField(
                      controller: cityController,
                      decoration: InputDecoration(labelText: 'City'),
                    ),
                    SizedBox(height: 16.0),
                    TextField(
                      controller: addressController,
                      decoration: InputDecoration(labelText: 'Address'),
                    ),
                    SizedBox(height: 16.0),
                    TextField(
                      controller: countryController,
                      decoration: InputDecoration(labelText: 'Country'),
                    ),
                  ],
                ),
          const SizedBox(height: 20),
          const Divider(
            color: Colors.grey,
            thickness: 1, // Độ dày của đường gạch
            height: 5, // Chiều cao của đường gạch
            indent: 5, // Khoảng cách từ lề trái
            endIndent: 5, // Khoảng cách từ lề phải
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Sở thích',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Thêm',
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.transparent,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Divider(
            color: Colors.grey,
            thickness: 1, // Độ dày của đường gạch
            height: 5, // Chiều cao của đường gạch
            indent: 5, // Khoảng cách từ lề trái
            endIndent: 5, // Khoảng cách từ lề phải
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Đáng chú ý',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Center(
            child: Container(
              width: 200,
              height: 100,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/paint.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Center(
            child: Text(
              'Hãy thêm một số tin, ảnh hoặc video yêu thich vào phần Đáng chú ý để mọi người hiểu hơn về bạn.',
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
          ),
          SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: () {
                // Xử lý sự kiện khi nút được nhấn
              },
              child: Container(
                width: 300,
                height: 30,
                child: Center(
                  child: Text(
                    'Dùng thử',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.grey[300],
                padding: EdgeInsets.zero,
              ),
            ),
          ),
          SizedBox(height: 20),
          const Divider(
            color: Colors.grey,
            thickness: 1,
            height: 5,
            indent: 5,
            endIndent: 5,
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Liên kết',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    if (isEditLink) {
                      setState(() {
                        linkUser = linkController.text;
                      });
                    }
                    setState(() {
                      isEditLink = !isEditLink;
                    });
                  },
                  child: Text(
                    !isEditLink ? 'Thêm' : 'lưu',
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.transparent,
                  ),
                ),
              ],
            ),
          ),
          !isEditLink
              ? Container(
                  child: Text(
                    linkUser!,
                    style: TextStyle(fontSize: 18.0),
                  ),
                )
              : Container(
                  child: TextFormField(
                    controller: linkController,
                    decoration: InputDecoration(
                      hintText: linkUser,
                    ),
                  ),
                ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                showDialog<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Xác nhận'),
                      content: const Text('Bạn có muốn lưu thay đổi không?'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text(
                            'Không lưu',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            setUserData();

                          },
                          child: const Text(
                            'Lưu',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Container(
                width: 300,
                height: 30,
                child: Center(
                  child: Text(
                    'Lưu thay đổi',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.blue[300],
                padding: EdgeInsets.zero,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
