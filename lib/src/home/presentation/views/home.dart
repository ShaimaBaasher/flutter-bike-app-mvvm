import 'dart:ui';

import 'package:bike_app/core/app_widget.dart';
import 'package:bike_app/core/utils/helper_widgets.dart';
import 'package:bike_app/core/utils/image_constant.dart';
import 'package:bike_app/src/home/presentation/bloc/home_bloc.dart';
import 'package:bike_app/src/products_detials/presentation/bloc/product_detials_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/routes/pages.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/size_utils.dart';
import '../../../../core/theme/styles.dart';
import '../../../cart/presentation/cart.dart';
import '../../../products_detials/presentation/views/product_detials.dart';
import '../../data/models/cat_model.dart';
import '../../data/models/product_model.dart';
import '../widgets/badget_icon.dart';
import '../widgets/custom_button.dart';
import '../widgets/item.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentTabIndex = 0;
  List<CatModel>? catModelList;
  List<ProductModel>? productList;

  @override
  void initState() {
    context.read<HomeBloc>().add(GetProductsEvent());
    context.read<HomeBloc>().add(GetCatEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          print('state>>$state');
          if (state is HomeErrorState) {
            showNormalSnakbar(context, state.model, isSuccess: false);
          }
          if (state is GetCatState) {
            catModelList = state.list.requestList;
            print('catModelList>>${catModelList!.length}');
          }
          if (state is GetProductsState) {
            productList = state.list?.requestList;
          }
        },
        builder: (context, state) {
          if (state is GettingProductsState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is GetProductsState || productList != null) {
            return Container(
              decoration: BoxDecoration(
                  color: mainColor,
                  image: DecorationImage(
                      image: AssetImage(
                        ImageConstant.BG,
                      ),
                      fit: BoxFit.cover)),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Choose Your Bike',
                            style: fontStyle(
                                fontSize: 20,
                                color: Colors.white,
                                isBold: true),
                          ),
                          InkWell(
                            onTap: () async {
                              final list =
                                  context.read<ProductDetialsBloc>().cartItems;
                              var res = await pushRoute(
                                  context: context,
                                  route: Cart(
                                    cartList: list,
                                  ));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                padding: const EdgeInsets.all(12.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: const LinearGradient(
                                    begin: Alignment(-0.9, -1),
                                    end: Alignment(1, 1.44),
                                    colors: <Color>[
                                      Color(0xFF34C8E8),
                                      Color(0xFF4E4AF2)
                                    ],
                                    stops: <double>[0, 1],
                                  ),
                                ),
                                child: Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    Icon(
                                      Icons.shopping_cart,
                                      color: Colors.white,
                                    ),
                                    Positioned(
                                        top: -10,
                                        right: -5,
                                        child: Container(
                                          padding: const EdgeInsets.all(6),
                                          decoration: BoxDecoration(
                                              color: Colors.red, borderRadius: BorderRadius.circular(10)),
                                          constraints: const BoxConstraints(maxHeight: 25, minWidth: 20),
                                          child: const BadgetIconWidget(),
                                        ))
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Stack(
                      children: [
                        Image.asset(
                          ImageConstant.icProductIconsPng,
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 40,
                                  ),
                                  Image.asset(
                                    ImageConstant.firstBike,
                                    fit: BoxFit.contain,
                                  ),
                                  Row(
                                    children: [
                                      const SizedBox(
                                        width: 50,
                                      ),
                                      Text(
                                        '30% Off',
                                        style: fontStyle(
                                            color: whiteWithOpacity,
                                            fontSize: 26),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            catModelList != null && catModelList!.isNotEmpty
                                ? Padding(
                              padding: EdgeInsets.only(left: 24 * fem),
                              child: SingleChildScrollView(
                                clipBehavior: Clip.none,
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: List<Widget>.generate(
                                      catModelList!.length,
                                          (index) => Padding(
                                        padding: const EdgeInsets
                                            .symmetric(
                                            horizontal: 3.0),
                                        child: CustomButton(
                                          text: '',
                                          icon: catModelList![index]
                                              .image,
                                        ),
                                      )),
                                ),
                              ),
                            )
                                : const SizedBox.shrink(),
                            const SizedBox(
                              height: 10,
                            ),
                            productList != null && productList!.isNotEmpty
                                ? Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0),
                              child: Container(
                                width: width,
                                height: MediaQuery.of(context).size.height - 300,
                                child: AlignedGridView.count(
                                  itemCount:
                                  productList!.length,
                                  physics:
                                  const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (ctx, index) {
                                    var item =
                                    productList![index];
                                    return InkWell(
                                        onTap: () async {
                                          var res = await pushRoute(
                                              context: context,
                                              route: ProductDetails(
                                                model: item,
                                              ));
                                        },
                                        child: itemWidget(model: item!));
                                  },
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 5,
                                  crossAxisSpacing: 5,
                                ),
                              ),
                            )
                                : const Text('No Products Found')
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
