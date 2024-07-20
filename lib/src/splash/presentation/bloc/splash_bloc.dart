import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/utils/local_cache.dart';
import '../../../../core/utils/local_storage_constants.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial()) {
    on<GetIfUserIsLoggedEvent>(_getLoggedHandler);
  }

  Future<void> _getLoggedHandler(GetIfUserIsLoggedEvent event, Emitter<SplashState> emitter) async {
    emit(const SplashInitial());
    final isLOGGED = await CacheHelper.getDataFromSharedPref(key: LOGGED) ?? false;
    if (isLOGGED) {
      emit(Logged());
    } else {
      emit(NotLogged());
    }
  }

}
