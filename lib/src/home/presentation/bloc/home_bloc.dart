import 'dart:async';

import 'package:bike_app/src/home/data/repositories/home_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/cat_model.dart';
import '../../data/models/product_model.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepo _homeRepo;

  HomeBloc({required HomeRepo homeRepo})
      : _homeRepo = homeRepo,
        super(HomeInitial()) {
    on<GetProductsEvent>(_getRequestListHandler);
    on<GetCatEvent>(_getCatListHandler);
  }

  Future<void> _getRequestListHandler(
      GetProductsEvent event, Emitter<HomeState> emitter) async {
    emit(const HomeInitial());
    var response = await _homeRepo.getNewRequestList();
    response.fold((failure) {
      return emit(HomeErrorState(failure.errorMessage));
    }, (res) => emit(GetProductsState(list: res)));
  }

  Future<void> _getCatListHandler(
      GetCatEvent event, Emitter<HomeState> emitter) async {
    emit(const HomeInitial());
    var response = await _homeRepo.getCatList();
    response.fold((failure) {
      return emit(HomeErrorState(failure.errorMessage));
    }, (res) => emit(GetCatState(list: res)));
  }
}
