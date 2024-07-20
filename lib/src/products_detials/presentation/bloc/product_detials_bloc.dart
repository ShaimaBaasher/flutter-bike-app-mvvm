import 'dart:async';

import 'package:bike_app/src/home/data/models/product_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/utils/enums.dart';

part 'product_detials_event.dart';
part 'product_detials_state.dart';

class ProductDetialsBloc extends Bloc<ProductDetialsEvent, ProductDetialsState> {
  var cartItems = <ProductModel>[];

  ProductDetialsBloc() : super(ProductDetialsInitial()) {
    on<UpdateCartQtyEvent>(_updateCartItemsHandler);
  }

  void _updateCartItemsHandler(UpdateCartQtyEvent event, Emitter<ProductDetialsState> emitter) async {
    emit(const ProductDetialsInitial());

    final index = cartItems.indexWhere((item) => item.id == event.product.id);

    if (event.counterEvent == CounterEvent.decrement) {
      if (index != -1) {
        cartItems.removeAt(index);
        emit(ProductDetialsModifiedState('Item removed successfully'));
      } else {
        emit(ProductDetialsErrorState('Item not found in the cart'));
      }
    } else if (event.counterEvent == CounterEvent.increment) {
      if (index != -1) {
        emit(ProductDetialsErrorState('Item already added'));
      } else {
        cartItems.add(event.product);
        emit(ProductDetialsModifiedState('Item added successfully'));
      }
    }
  }


}
