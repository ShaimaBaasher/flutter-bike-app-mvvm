import 'dart:async';

import 'package:bike_app/core/utils/local_storage_constants.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/utils/local_cache.dart';
import '../../data/repositories/auth_repo.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthService _authService;

  LoginBloc({required AuthService authService})
      : _authService = authService,
        super(LoginInitial()) {
    on<LoginEmailEvent>(_getLoginHandler);
    on<SignUpEmailEvent>(_signUp);
  }

  Future<void> _getLoginHandler(
      LoginEmailEvent event, Emitter<LoginState> emitter) async {
    emit(const LoginInitial());
    try {
      User? user = await _authService.signInWithEmailAndPassword(
          event.email, event.password);
      if (user != null && user!.email != '') {
        CacheHelper.setDataToSharedPref(key: LOGGED, value: true);
        emit(GetLoginState(response: 'Success'));
      } else {
        emit(LoginErrorState(
            'There is no user record corresponding to this identifier.'));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email');
        emit(LoginErrorState('No user found for that email'));
      } else if (e.code == 'wrong-password') {
        // Handle case where the password is incorrect
        emit(LoginErrorState('Wrong password provided'));
      } else {
        emit(LoginErrorState('${e.message}'));
      }
    } catch (e) {
      // Handle general errors
      emit(LoginErrorState('An unexpected error occurred ${e}'));
    }
  }

  Future<void> _signUp(SignUpEmailEvent event, Emitter<LoginState> emitter) async {
    emit(const LoginInitial());

    try {
      User? user = await _authService.signUpWithEmailAndPassword(
          event.email, event.password);
      if (user != null && user!.email != '') {
        CacheHelper.setDataToSharedPref(key: LOGGED, value: true);
        emit(GetLoginState(response: 'Success'));
      } else {
        emit(LoginErrorState(
            'There is no user record corresponding to this identifier.'));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email');
        emit(LoginErrorState('No user found for that email'));
      } else if (e.code == 'wrong-password') {
        // Handle case where the password is incorrect
        emit(LoginErrorState('Wrong password provided'));
      } else {
        emit(LoginErrorState('${e.message}'));
      }
    } catch (e) {
      // Handle general errors
      emit(LoginErrorState('An unexpected error occurred ${e}'));
    }
  }
}
