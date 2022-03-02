import 'package:esercizio_flutter/bloc/auth/form_submission_status.dart';

class LoginState {
  final String email;
  bool get isValidEmail => email.length > 3;
  

  final String password;
  bool get isValidPassword => password.length > 6;

  final String token;

  final FormSubmissionStatus formStatus;

  LoginState({
    this.email = '', 
    this.password = '',
    this.token = '',
    this.formStatus = const InitialFormStatus()
  });


  LoginState copyWith({
    String? email,
    String? password,
    String? token,
    FormSubmissionStatus? formStatus,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      token: token ?? this.token,
      formStatus: formStatus ?? this.formStatus,
    );
  }
}
