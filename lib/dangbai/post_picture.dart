import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PostPicture extends StatefulWidget {
  final List<XFile> imageFileList;
  final Function(int) onDeleteImage;

  PostPicture(
      {Key? key, required this.imageFileList, required this.onDeleteImage})
      : super(key: key);

  @override
  _PostPictureState createState() => _PostPictureState();
}

class _PostPictureState extends State<PostPicture> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 80,
      child:Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              if (widget.imageFileList.isNotEmpty)
                Picture(
                  image: widget.imageFileList[0],
                  index: 0,
                  onDeleteImage: widget.onDeleteImage,
                ),
              if (widget.imageFileList.length > 1)
                Picture(
                  image: widget.imageFileList[1],
                  index: 1,
                  onDeleteImage: widget.onDeleteImage,
                ),
            ],
          ),
          Column(
            children: [
              if (widget.imageFileList.length > 2)
                Picture(
                  image: widget.imageFileList[2],
                  index: 2,
                  onDeleteImage: widget.onDeleteImage,
                ),
              if (widget.imageFileList.length > 3)
                Picture(
                  image: widget.imageFileList[3],
                  index: 3,
                  onDeleteImage: widget.onDeleteImage,
                ),
            ],
          )
        ],
      ),
    );
  }
}

// Positioned(
//   top: 80,
//   child: Container(
//     width: MediaQuery.of(context).size.width,
//     // height: 360,
//     color: Colors.redAccent,
//     child: GridView.builder(
//       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 2,
//         crossAxisSpacing: 8.0,
//         mainAxisSpacing: 8.0,
//       ),
//       itemCount: widget.imageFileList.length,
//       itemBuilder: (BuildContext context, int index) {
//         return Stack(
//           children: [
//             AspectRatio(
//               aspectRatio: 1.0,
//               child: Container(
//                 decoration: BoxDecoration(
//                   shape: BoxShape.rectangle,
//                   color: Colors.greenAccent,
//                   image: widget.imageFileList[index] != null
//                       ? DecorationImage(
//                     image: FileImage(
//                       File(widget.imageFileList[index].path),
//                     ),
//                     fit: BoxFit.cover,
//                   )
//                       : null
//                   ),
//                 ),
//               ),
//             Positioned(
//               top: 0,
//               right: 0,
//               child: InkWell(
//                 onTap: () {
//                   widget.onDeleteImage(index);
//                   print('Xóa ảnh tại index $index');
//                 },
//                 child: Container(
//                   padding: EdgeInsets.all(4.0),
//                   child: Icon(
//                     Icons.close,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ),
//            // Hiển thị dấu "+" khi không có ảnh
//             if (widget.imageFileList[index] == null) // Hiển thị dấu "+" khi không có ảnh
//               Center(
//                 child: Icon(
//                   Icons.add,
//                   size: 40,
//                   color: Colors.blue,
//                 ),
//               ),
//
//           ],
//         );
//       },
//     ),
//   ),
// );
class Picture extends StatelessWidget {
  final XFile image;
  final int index;
  final Function(int) onDeleteImage;

  const Picture(
      {required this.image, required this.index, required this.onDeleteImage});
  @override
  Widget build(BuildContext context) {
    if(image == null) {
      return const Center(
          child: Icon(
            Icons.add,
            size: 40,
            color: Colors.blue,
          ),
        );
    }
    return
        Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width / 2,
                height: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  image: DecorationImage(
                    image: FileImage(
                      File(image.path),
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: InkWell(
                  onTap: () {
                    onDeleteImage(index);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(4.0),
                    child: const Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          );
  }
}
