import 'dart:developer' as developer;

class Logger {
  static final String name = 'develboulder';

  static log(String message) {
    developer.log('[LOG] $message', name: name);
  }

  static error(String message) {
    developer.log('[ERROR] $message', name: name);
  }
}
