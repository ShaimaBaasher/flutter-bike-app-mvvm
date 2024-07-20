import 'package:bike_app/src/products_detials/presentation/bloc/product_detials_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BadgetIconWidget extends StatelessWidget {
  const BadgetIconWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetialsBloc, ProductDetialsState>(
      builder: (context, state) {
        return Text('${BlocProvider.of<ProductDetialsBloc>(context).cartItems.length}',
          style: const TextStyle(color: Colors.white, fontSize: 8),
          textAlign: TextAlign.center,
        );
      },
    );
  }
}
