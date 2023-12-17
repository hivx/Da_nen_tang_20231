import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final double height;
  final Color textColor;
  final Color buttonColor;

  const MyButton({super.key, 
    required this.label,
    required this.onPressed,
    this.height = 50.0,
    this.textColor = Colors.white, // Màu chữ mặc định
    this.buttonColor = const Color(0xFF1878F3), // Màu nút mặc định
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor, // Đặt màu nút
        minimumSize: Size(double.infinity, height), // Đặt chiều cao của nút
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // Đặt góc bo tròn và độ cong của cạnh
        side: const BorderSide(
            color: Color(0xFF1878F3), // Màu của đường viền
            width: 2, // Độ rộng của đường viền
          ),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: textColor, // Đặt màu chữ
        ),
      ),
    );
  }
}


