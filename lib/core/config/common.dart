class Common{

  static  bool checkRegexFormat(RegExp regex, String value){
    return regex.hasMatch(value) ? true :false;
  }

}