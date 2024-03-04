
class Common{

  static  bool checkRegexFormat(RegExp regex, String value) => regex.hasMatch(value) ? true :false;

  static DateTime extractDate( DateTime dateTime) =>  DateTime(dateTime.year,dateTime.month,dateTime.day);

}