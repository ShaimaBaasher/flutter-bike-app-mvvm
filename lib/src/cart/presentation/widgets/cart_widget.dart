import 'package:bike_app/core/theme/size_utils.dart';
import 'package:bike_app/core/theme/styles.dart';
import 'package:bike_app/src/home/data/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/custom_image_view.dart';
import '../../../../core/utils/enums.dart';
import '../../../products_detials/presentation/bloc/product_detials_bloc.dart';

class CartItemWidget extends StatelessWidget {
  const CartItemWidget({
    super.key,
    required this.model,
  });

  final ProductModel model;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
        key: Key(model.id.toString()),
        onDismissed: (direction) {
          context.read<ProductDetialsBloc>().add(
              UpdateCartQtyEvent(
                  product: model!,
                  counterEvent: CounterEvent.decrement));
        },
        child: Container(width: width ,
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: const [
              BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.03999999910593033),
                  offset: Offset(0, 4),
                  blurRadius: 20),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CustomImageView(
                    imagePath: model.images[0],
                    width: 100,
                    height: 100,
                    radius: BorderRadius.circular(
                      12,
                    ),
                    alignment: Alignment.center,
                  ),
                  const SizedBox(
                    width: 8 ,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    Text(model.title, style: fontStyle()),
                    Text('\$${model.price}', style: fontStyle(),),
                  ],)
                ],
              ),
            ],
          ),
        )

    );
  }
}
