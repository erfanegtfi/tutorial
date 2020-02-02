class FormValidator {
  static FormValidator _instance;

  factory FormValidator() => _instance ??= new FormValidator._();

  FormValidator._();

  String validatePassword(String value) {
    String patttern = r'(^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{6,}$)';
    RegExp regExp = new RegExp(patttern);
    if (value.isEmpty) {
      return "Password is Required";
    } else if (value.length > 8) {
      return "Password must minimum eight characters";
    // } else if (!regExp.hasMatch(value)) {
    //   return "Password at least one uppercase letter, one lowercase letter and one number";
    }
    return null;
  }

  String validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (value.isEmpty) {
      return "Email is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Invalid Email";
    } else {
      return null;
    }
  }
 String validateFullName(String value) {
    String pattern = r'^[a-zA-Z]{3,}(?: [a-zA-Z]+){0,2}$';
    RegExp regExp = new RegExp(pattern);
    if (value.isEmpty) {
      return "Full name is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Invalid name";
    } else {
      return null;
    }
  }

  String validateMobile(String value) {
    String pattern =
        r'^(\+\d{1,3}[- ]?)?\d{10,11}$';
    RegExp regExp = new RegExp(pattern);
    if (value.isEmpty) {
      return "Mobile is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Invalid Mobile";
    } else {
      return null;
    }
  }
}
