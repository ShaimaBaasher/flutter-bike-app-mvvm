part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();
  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {
  const LoginInitial();
}

class GettingLoginState extends LoginState {
  const GettingLoginState();
}

class GetLoginState extends LoginState {
  dynamic response;
  GetLoginState({required this.response});
}

class LoginErrorState extends LoginState {
  const LoginErrorState(this.model);
  final dynamic model;
}

