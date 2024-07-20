import 'package:bike_app/core/theme/colors.dart';
import 'package:bike_app/core/theme/styles.dart';
import 'package:bike_app/core/utils/image_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({
    Key? key,
    this.title = '',
    this.isBackButtonIsShown = true,
    this.centerTitle = false,
    this.icBackButtonWithoutTail = false,
    this.toolbarHeight = 56.0,
    this.actions,
  }) : super(key: key);

  final String? title;
  final bool? isBackButtonIsShown;
  final bool? icBackButtonWithoutTail;
  final double? toolbarHeight;
  final List<Widget>? actions;
  final bool? centerTitle;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      centerTitle: centerTitle,
      title: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          '$title',
          style: fontStyle(fontSize: 20, color: Colors.white, isBold: true),
        ),
      ),
      backgroundColor: mainColor,
      iconTheme: const IconThemeData(color: Colors.white),
      titleSpacing: 0,
      leading: isBackButtonIsShown!
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: InkWell(
                onTap: () {
                  Navigator.pop(
                    context,
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: SvgPicture.asset(
                    icBackButtonWithoutTail!
                        ? ImageConstant.icBackButtonWithoutTail
                        : ImageConstant.icBackButton,
                    matchTextDirection: true,
                    width: icBackButtonWithoutTail! ? 24 : 13,
                    height: icBackButtonWithoutTail! ? 24 : 13,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          : null,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(toolbarHeight!);
}
