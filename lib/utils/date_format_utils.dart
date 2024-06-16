import 'package:intl/intl.dart'; // Import the intl package for date formatting

class DateFormatUtils {
  static String formatDate(DateTime dateTime) {
    // Format the given DateTime object into a string
    return DateFormat('yyyy-MM-dd').format(dateTime);
    // Adjust 'yyyy-MM-dd' to your desired date format
  }

  static DateTime parseDate(String dateString) {
    // Parse a date string into a DateTime object
    return DateFormat('yyyy-MM-dd').parse(dateString);
    // Adjust 'yyyy-MM-dd' to match the format of your date strings
  }
}
