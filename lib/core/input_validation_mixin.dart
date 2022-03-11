mixin InputValidationMixin {
  String? isPasswordValid(String password) {
    if (password.isEmpty) {
      return "Введите пароль";
    } else if (password.length == 6) {
      return null;
    } else {
      return "пароль должен быть из 6 символов";
    }
  }

  String? isNameValid(String name) {
    if (name.isNotEmpty) {
      return null;
    } else {
      return "Введите имя";
    }
  }

  String? isEmailValid(String email) {
    RegExp regex = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (email.isEmpty) {
      return "Введите email";
    } else if (!regex.hasMatch(email)) {
      return "Введите валидный email";
    } else {
      return null;
    }
  }
}
