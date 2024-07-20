import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../theme/styles.dart';
import 'image_constant.dart';

class Widgets {
  call() {}
}


showLoadingDialog(BuildContext context) {
  Future.delayed(const Duration(milliseconds: 100), () {
    showDialog(
      context: context,
      barrierDismissible: false,
      useSafeArea: true,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: SizedBox.expand(
            child: SafeArea(
              child: (Container(
                color: Colors.black.withOpacity(0.4),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              )),
            ),
          ),
        );
      },
    );
  });
}

hideLoadingDialog(BuildContext context) {
  // WidgetsBinding.instance.addPostFrameCallback((_) {
  Navigator.pop(context);
  // });
}

showNormalSnakbar(BuildContext context, String message,
    {bool isSuccess = true,
      bool isDismissible = true,
      int duration = 2,
      bool isOpenFile = false,
      VoidCallback? callback}) {
  Flushbar(
    messageText: Row(
      children: [
        if (isSuccess)
          SvgPicture.asset(
            ImageConstant.icCheck,
            width: 32,
            height: 32,
          ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            message,
            style: fontStyle(
                color: isSuccess
                    ? const Color.fromRGBO(10, 85, 84, 1)
                    : Colors.red.shade900,
                isSemiBold: true,
                fontSize: 14),
            textAlign: TextAlign.left,
          ),
        ),
      ],
    ),
    messageColor: isSuccess ? const Color.fromRGBO(43, 108, 103, 1) : Colors.red.shade900,
    duration: Duration(seconds: duration),
    forwardAnimationCurve: Curves.decelerate,
    isDismissible: isDismissible,
    backgroundColor: isSuccess
        ? const Color.fromRGBO(216, 251, 222, 1)
        : Colors.red.shade200,
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 17),
    // borderRadius: BorderRadius.circular(25),
    // margin: const EdgeInsets.symmetric(horizontal: 20).copyWith(top: 0),
    // padding: EdgeInsets.only(bottom: 5),
    animationDuration: const Duration(milliseconds: 300),
    // borderColor: defaultColor,

    flushbarStyle: FlushbarStyle.GROUNDED,
    flushbarPosition: FlushbarPosition.TOP,
  ).show(context);
}