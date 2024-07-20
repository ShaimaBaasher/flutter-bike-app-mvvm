import 'package:bike_app/core/app_widget.dart';
import 'package:bike_app/core/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/helper_widgets.dart';
import '../../home/data/models/product_model.dart';
import '../../products_detials/presentation/bloc/product_detials_bloc.dart';
import 'widgets/cart_widget.dart';

class Cart extends StatelessWidget {
  Cart({Key? key, required this.cartList}) : super(key: key);
  List<ProductModel> cartList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(),
      body: BlocConsumer<ProductDetialsBloc, ProductDetialsState>(
        listener: (context, state) {
          if (state is ProductDetialsModifiedState) {
            showNormalSnakbar(
              context,
              state.model,
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                cartList.isNotEmpty ?
                Expanded(
                  child: ListView.builder(
                      itemCount: cartList?.length,
                      itemBuilder: (ctx, i) {
                        final model = cartList![i];
                        return Container(
                          decoration: BoxDecoration(
                            color: Color(0xFF2C324B),
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                blurRadius: 10,
                                offset: Offset(0, 5),
                              ),
                            ],
                          ),
                          child: CartItemWidget(model: cartList[i],),
                        );
                      }),
                ) : Center(child: Text(
                  'Empty Cart', style: fontStyle(color: Colors.white),),),
              ],
            ),
          );
        },
      ),
    );
  }
}
