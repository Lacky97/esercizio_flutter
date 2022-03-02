abstract class LoginEvent{}

class LoginIntialFromStatus extends LoginEvent{}

class LoginEmailChange extends LoginEvent{
  final String email;

  LoginEmailChange({required this.email});
}

class LoginPasswordChange extends LoginEvent{
  final String password;

  LoginPasswordChange({required this.password});
}

class LoginSubmitted extends LoginEvent{
  final String email;
  final String password;

  LoginSubmitted({required this.email, required this.password});
}