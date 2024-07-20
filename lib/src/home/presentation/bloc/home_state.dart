part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();
  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {
  const HomeInitial();
}

class GettingProductsState extends HomeState {
  const GettingProductsState();
}

class GetProductsState extends HomeState {
  ProductModelList? list;
  CatModelList? catList;

  GetProductsState({this.list,  this.catList});
}

class GetCatState extends HomeState {
  CatModelList list;
  GetCatState({required this.list});
}

class HomeErrorState extends HomeState {
  const HomeErrorState(this.model);
  final dynamic model;
}