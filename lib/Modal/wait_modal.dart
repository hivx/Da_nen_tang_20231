import 'package:flutter/material.dart';

class WaitModal {
  static void showLoadingModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      enableDrag: false,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Center(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
            ),
            width: MediaQuery.of(context).size.width * 0.5,
            height: MediaQuery.of(context).size.width * 0.5,
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircularProgressIndicator(), // Hiệu ứng quay vòng
                SizedBox(height: 20),
                Text('Vui lòng đợi...'), // Text hiển thị thông báo chờ
              ],
            ),
          ),
        );
      },
    );
  }
}

