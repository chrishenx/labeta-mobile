class Validators {
  static final emailRegex = RegExp(
      r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$');

  static final mediumPasswordRegex = RegExp(
      r'^(((?=.*[a-z])(?=.*[A-Z]))|((?=.*[a-z])(?=.*[0-9]))|((?=.*[A-Z])(?=.*[0-9])))(?=.{6,})');

  static final printableRegex = RegExp(r'[ -~]');

  static bool isEmail(String value) {
    return emailRegex.hasMatch(value.trim());
  }

  static bool isMediumPassword(String value) {
    return mediumPasswordRegex.hasMatch(value);
  }

  static bool isPrintable(String value) {
    return printableRegex.hasMatch(value);
  }

  static String? Function(String?) createFormFieldValidator(
      Function(String) testFunction, String invalidMessage) {
    return (String? value) {
      return testFunction(value ?? '')
          ? null
          : invalidMessage;
    };
  }

  static final String? Function(String?) validateNotEmpty =
      createFormFieldValidator((value) => value.isNotEmpty, 'Este campo es obligatorio.');

  static final String? Function(String?) validateEmail =
      createFormFieldValidator(isEmail, 'Ingresa un email válido.');

  static final String? Function(String?) validatePassword =
      createFormFieldValidator(isMediumPassword,
          'Usa una mejor contraseña (6 o mas caracteres, A-Z, a-z, 0-9)');

  static final String? Function(String?) validatePrintable = 
      createFormFieldValidator(isPrintable, 'Solo caracteres imprimibles son permitidos.');
}

String? Function(String? value) composeValidators(List<String? Function(String?)> validators) {
  return (String? value) {
    for (final validator in validators) {
      final result = validator(value);
      if (result != null) {
        return result;
      }
    }
    return null;
  };
}