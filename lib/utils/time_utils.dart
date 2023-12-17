import 'package:intl/intl.dart';

String formatDate(String thoiGianDang) {
  DateTime thoiGianHienTai = DateTime.now();
  DateTime thoiGianDangBai = DateTime.parse(thoiGianDang);
  Duration thoiGianTroLai = thoiGianHienTai.difference(thoiGianDangBai);

  if (thoiGianTroLai.inMinutes < 1) {
    return 'Vừa xong';
  } else if (thoiGianTroLai.inMinutes < 60) {
    return '${thoiGianTroLai.inMinutes} phút';
  } else if (thoiGianTroLai.inHours < 24) {
    return '${thoiGianTroLai.inHours} giờ';
  } else if (thoiGianTroLai.inDays < 7) {
    return '${thoiGianTroLai.inDays} ngày';
  } else if (thoiGianDangBai.year == thoiGianHienTai.year) {
    // Trong cùng năm
    return DateFormat('MMM d').format(thoiGianDangBai);
  } else {
    // Năm trước
    return DateFormat('MMM d, y').format(thoiGianDangBai);
  }
}
