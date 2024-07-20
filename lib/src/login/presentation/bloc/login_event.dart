part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
  @override
  List<Object> get props => [];
}

class LoginEmailEvent extends LoginEvent {
  String email;
  String password;
  LoginEmailEvent({required this.email, required this.password});
}

class SignUpEmailEvent extends LoginEvent {
  String email;
  String password;
  SignUpEmailEvent({required this.email, required this.password});
}

