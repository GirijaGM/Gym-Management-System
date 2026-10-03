class Validators {
  static bool isValidName(String name) {
    return name.trim().isNotEmpty;
  }

  static bool isValidPhone(String phone) {
    return RegExp(r'^[0-9]{10}$').hasMatch(phone);
  }

  static bool isValidEmail(String email) {
    return RegExp(
      r'^[\w.-]+@[\w.-]+\.\w+$',
    ).hasMatch(email);
  }

  static bool isValidGender(String gender) {
    return gender.toLowerCase() == 'male' ||
        gender.toLowerCase() == 'female';
  }

  static int? parseId(String input) {
    return int.tryParse(input);
  }
}