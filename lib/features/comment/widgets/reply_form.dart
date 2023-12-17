import 'package:anti_facebook_app/models/comment.dart';
import 'package:anti_facebook_app/utils/httpRequest.dart';
import 'package:flutter/material.dart';

class ReplyFormWidget extends StatefulWidget {
  final int idPost;
  final int idComment;
  const ReplyFormWidget(
      {Key? key, required this.idPost, required this.idComment})
      : super(key: key);

  @override
  _ReplyFormWidgetState createState() => _ReplyFormWidgetState();
}

class _ReplyFormWidgetState extends State<ReplyFormWidget> {
  String content = '';
  @override
  void initState() {
    super.initState();
  }

  Future<void> setMarkComment(idPost, idComment) async {
    try {
      Map<String, dynamic> requestData = {
        'id': idPost,
        "mark_id": idComment,
        "content": content,
        "index": 0,
        "count": 10,
        "type": 1,
      };
      print(requestData);
      var result = await callAPIcomment('/set_mark_comment',
          requestData); // Sử dụng 'await' để đợi kết thúc của hàm callAPI
      setState(() {});
    } catch (error) {
      // setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.all(16),
        children: [
          Padding(
            padding: EdgeInsets.only(
              bottom: 10.0,
            ),
            child: Text(
              'Phản hồi bình luận',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color.fromARGB(255, 216, 215, 215),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 1.0,
                      ),
                    ),
                    hintText: 'Viết phản hồi...',
                    contentPadding: EdgeInsets.symmetric(horizontal: 15),
                  ),
                  onChanged: (value) {
                    setState(() {
                      content = value;
                    });
                  },
                ),
              ),
              IconButton(
                icon: Icon(Icons.send),
                color: Colors.blue[700],
                onPressed: () {
                  setMarkComment(widget.idPost, widget.idComment);
                  Navigator.pop(context);
                  // Xử lý khi bấm nút gửi bình luận
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
