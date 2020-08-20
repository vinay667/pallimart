class Validations {
  static bool checkEmail(String email) {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    return emailValid;
  }

  static bool checkName(String name) {
    bool nameRegExp = RegExp('[a-zA-Z]').hasMatch(name);
    return nameRegExp;
  }
}
