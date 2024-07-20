import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/colors.dart';
import '../../../../core/theme/custom_image_view.dart';
import '../../../../core/utils/image_constant.dart';
import '../../data/models/product_model.dart';

class itemWidget extends StatelessWidget {
  const itemWidget({
    Key? key,
    required this.model,
  }) : super(key: key);
  final ProductModel model;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Stack(
          children: [
            Image.asset(
              ImageConstant.itemRect,
            ),
            Container(
              decoration: BoxDecoration(
                color: mainColor,
                image: DecorationImage(
                    image: AssetImage(
                      ImageConstant.itemRect,
                    ),
                    fit: BoxFit.cover),
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: Icon(
                          Icons.favorite_border,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.network(
                              height: 110, model.images[0], fit: BoxFit.cover,
                              loadingBuilder: (BuildContext context,
                                  Widget child,
                                  ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Padding(
                              padding: const EdgeInsets.all(10),
                              child: Center(
                                  child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                              )),
                            );
                          }, errorBuilder: (BuildContext context,
                                  Object exception, StackTrace? stackTrace) {
                            return const Icon(
                              Icons.error,
                              size: 100,
                              color: Colors.white,
                            );
                          })
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        model.title,
                        maxLines: 1,
                        style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          color: whiteWithOpacity,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        '${model.description}',
                        maxLines: 1,
                        style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        '\$${model.price}',
                        style: TextStyle(
                          color: whiteWithOpacity,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
