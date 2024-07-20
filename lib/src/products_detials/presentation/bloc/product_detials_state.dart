part of 'product_detials_bloc.dart';

abstract class ProductDetialsState extends Equatable {
  const ProductDetialsState();
  @override
  List<Object> get props => [];
}

class ProductDetialsInitial extends ProductDetialsState {
  const ProductDetialsInitial();
}

class ProductDetialsModifiedState extends ProductDetialsState {
  final dynamic model;
  const ProductDetialsModifiedState(this.model);
}

class ProductDetialsErrorState extends ProductDetialsState {
  final dynamic model;
  const ProductDetialsErrorState(this.model);
}
