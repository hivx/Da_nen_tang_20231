import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExitConfirmationDialog {
  static Future<bool> showExitConfirmationDialog(BuildContext context) async {
    return await showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
      ),
      builder: (BuildContext context) {
        return Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Bạn muốn hoàn thành bài viết của mình sau?",
                style: TextStyle(fontSize: 12.0),
              ),
              const Text(
                "Lưu bản nháp hoặc bạn có thể tiếp tục chỉnh sửa.",
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.w200),
              ),
              _buildOption(context, 'Lưu bản nháp', Icons.save),
              _buildOption(context, 'Bỏ bài viết', Icons.delete),
              _buildOption(context, 'Tiếp tục chỉnh sửa', Icons.edit),
            ],
          ),
        );
      },
    );
  }
}

Widget _buildOption(BuildContext context, String text, IconData icon) {
  return InkWell(
    onTap: () {
      if (text == 'Lưu bản nháp') {
        Navigator.of(context).pop(true);
      } else if (text == 'Bỏ bài viết') {
        Navigator.of(context).pop(true);
      } else if (text == 'Tiếp tục chỉnh sửa') {
        Navigator.of(context).pop(false);
      }
    },
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
      child: Row(
        children: [
          Icon(icon),
          SizedBox(width: 16.0),
          Text(
            text,
            style: TextStyle(fontSize: 18.0),
          ),
        ],
      ),
    ),
  );
}