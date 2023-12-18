class Time {
  static String getDiffTime(String time) {
    DateTime pastTime = DateTime.parse(time);
    DateTime now = DateTime.now();
    Duration diffTime = now.difference(pastTime);
    if (diffTime.inMinutes < 1) {
      return 'Vừa xong';
    } else if (diffTime.inHours < 1) {
      return '${diffTime.inMinutes} phút';
    } else if (diffTime.inHours < 24) {
      return '${diffTime.inHours} giờ';
    } else {
      return '${diffTime.inHours ~/ 24} ngày';
    }
  }

  static DateTime transTime(String time) {
    DateTime pastTime = DateTime.parse(time);
    Duration sevenHours = Duration(hours: 7);

    DateTime resultTime = pastTime.subtract(sevenHours);
    return resultTime;
  }
}