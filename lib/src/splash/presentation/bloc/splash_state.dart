part of 'splash_bloc.dart';

abstract class SplashState extends Equatable {
  const SplashState();
  @override
  List<Object> get props => [];
}

class SplashInitial extends SplashState {
  const SplashInitial();
}

class Logged extends SplashState {
  const Logged();
}

class NotLogged extends SplashState {
  const NotLogged();
}
