class Validation {
  static isPhoneValid(String phone) {
    final regexPhone = RegExp(r'^[0-9]+$');
    return regexPhone.hasMatch(phone);
  }

  static isPassValid(String pass) {
    return pass.length > 6;
  }

  static isDisplayNameValid(String displayName) {
    return displayName.length > 5;
  }
}
