import 'package:intl/intl.dart';

class DateUtils {

  static String dateToString({DateTime date, String format = "yyyy-MM-dd"}) {
    return DateFormat(format).format(date);
  }

  static DateTime stringToDate({String date, String format = "yyyy-MM-dd"}) {
    return DateFormat(format).parseUTC(date);
  }
}
