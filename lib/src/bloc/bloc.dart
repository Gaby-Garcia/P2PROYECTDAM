import 'dart:async';
import 'package:proyect2p/src/bloc/validators.dart';

class Bloc with Validators {
  final _emailController = StreamController<String>();
  final _passwordController = StreamController<String>();

  String _currentEmail = "";
  String _currentPassword = "";

  Stream<String> get email => _emailController.stream.transform(validaEmail);
  Stream<String> get password => _passwordController.stream.transform(validaPassword);

  Function(String) get changeEmail => (email) {
    _currentEmail = email;
    _emailController.sink.add(email);
  };

  Function(String) get changePassword => (password) {
    _currentPassword = password;
    _passwordController.sink.add(password);
  };

  String get currentEmail => _currentEmail;
  String get currentPassword => _currentPassword;

  dispose() {
    _emailController.close();
    _passwordController.close();
  }
}