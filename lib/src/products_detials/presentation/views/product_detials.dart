import 'package:bike_app/core/theme/colors.dart';
import 'package:bike_app/core/theme/size_utils.dart';
import 'package:bike_app/core/utils/helper_widgets.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/styles.dart';
import '../../../../core/utils/enums.dart';
import '../../../../core/utils/image_constant.dart';
import '../../../home/data/models/product_model.dart';
import '../bloc/product_detials_bloc.dart';
import 'dart:math' as math;

class ProductDetails extends StatefulWidget {
  const ProductDetails({
    Key? key,
    this.model,
  }) : super(key: key);
  final ProductModel? model;

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  var currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: mainColor,
          image: DecorationImage(
              image: AssetImage(
                ImageConstant.BG,
              ),
              fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: BlocListener<ProductDetialsBloc, ProductDetialsState>(
          listener: (context, state) {
            if (state is ProductDetialsModifiedState) {
              showNormalSnakbar(
                context,
                state.model,
              );
            }
            if (state is ProductDetialsErrorState) {
              showNormalSnakbar(context, state.model, isSuccess: false);
            }
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
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
                            child: Transform.rotate(
                                angle: 270 * math.pi / 180,
                                child: const Icon(
                                  Icons.arrow_back_ios_new_outlined,
                                  color: Colors.white,
                                  size: 16,
                                )),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          widget.model!.title,
                          style: fontStyle(
                              fontSize: 20, color: Colors.white, isBold: true),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 27,
                  ),
                  Column(
                    children: [
                      CarouselSlider(
                        items: widget.model!.images
                            .map(
                              (e) => ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(e, fit: BoxFit.cover,
                                      loadingBuilder: (BuildContext context,
                                          Widget child,
                                          ImageChunkEvent? loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Center(
                                          child: CircularProgressIndicator(
                                        value: loadingProgress
                                                    .expectedTotalBytes !=
                                                null
                                            ? loadingProgress
                                                    .cumulativeBytesLoaded /
                                                loadingProgress
                                                    .expectedTotalBytes!
                                            : null,
                                      )),
                                    );
                                  }, errorBuilder: (BuildContext context,
                                          Object exception,
                                          StackTrace? stackTrace) {
                                    return const Icon(
                                      Icons.error,
                                      size: 100,
                                      color: Colors.white,
                                    );
                                  })),
                            )
                            .toList(),
                        options: CarouselOptions(
                          onPageChanged: (page, reason) {
                            setState(() {
                              currentIndex = page;
                            });
                          },
                          height: 350,
                          viewportFraction: 0.8,
                          initialPage: 0,
                          enableInfiniteScroll: true,
                          autoPlay: true,
                          autoPlayInterval: const Duration(seconds: 3),
                          autoPlayAnimationDuration:
                              const Duration(milliseconds: 800),
                          autoPlayCurve: Curves.linear,
                          enlargeCenterPage: true,
                          enlargeFactor: 0.3,
                          scrollDirection: Axis.horizontal,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          for (int i = 0; i < widget.model!.images.length; i++)
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              child: CircleAvatar(
                                backgroundColor: i == currentIndex
                                    ? Colors.white
                                    : Colors.grey,
                                radius: 4.0,
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  )
                ],
              ),
              Container(
                width: width,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment(-0.879, -1.049),
                      end: Alignment(0.028, 0.227),
                      colors: [secondMainColor, thirdMainColor]),
                  border: Border(
                    top: BorderSide(
                      color: Color(0x33FFFFFF),
                      width: 1.0, // Adjust border width as needed
                    ),
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // Align content to bottom
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 42,
                          ),
                          Row(
                            children: [
                              Text(
                                widget.model!.title,
                                textAlign: TextAlign.start,
                                style: fontStyle(
                                    color: Colors.white,
                                    isBold: true,
                                    fontSize: 17),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            widget.model!.description,
                            textAlign: TextAlign.start,
                            style: fontStyle(
                                color: whiteWithOpacity, fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        context.read<ProductDetialsBloc>().add(
                            UpdateCartQtyEvent(
                                product: widget.model!,
                                counterEvent: CounterEvent.increment));
                      },
                      child: Container(
                        width: width,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 30),
                        decoration: const BoxDecoration(
                          color: Color(0xFF262E3D),
                          border: Border(
                            top: BorderSide(
                              color: Color(0x33FFFFFF),
                              width: 1.0, // Adjust border width as needed
                            ),
                          ),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(60),
                            topRight: Radius.circular(60),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '\$ ${widget.model!.price}',
                              style: fontStyle(
                                  color: Color(0xFF3D9CEA), fontSize: 24),
                            ),
                            Container(
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
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 11),
                                child: Text(
                                  'Add to Cart',
                                  style: fontStyle(color: Colors.white),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
