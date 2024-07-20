part of 'product_detials_bloc.dart';

abstract class ProductDetialsEvent extends Equatable {
  const ProductDetialsEvent();
  @override
  List<Object> get props => [];
}

class UpdateCartQtyEvent extends ProductDetialsEvent {
  final ProductModel product;
  final CounterEvent counterEvent;
  const UpdateCartQtyEvent({required this.product, required this.counterEvent,});
  @override
  List<Object> get props => [product.id,];
}
