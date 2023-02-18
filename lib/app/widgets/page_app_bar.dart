import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/text.styles.dart';

class PageAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool? isBackButtonExist;
  final Function? onBackPressed;
  final bool? isOpenPageSettings;
  final double? appBarSize;

  const PageAppBar({
    Key? key,
    required this.title,
    this.isBackButtonExist = true,
    this.isOpenPageSettings = false,
    this.onBackPressed,
    this.appBarSize = 85,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size(MediaQuery.of(context).size.width, appBarSize!),
      child: SizedBox(
        height: appBarSize,
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          elevation: 1,
          shadowColor: Colors.black.withOpacity(.3),
          centerTitle: true,
          leadingWidth: isBackButtonExist! ? 50 : 0,
          leading: isBackButtonExist!
              ? IconButton(
            icon: const Icon(Icons.arrow_back, color: colorText),
            onPressed: () {
              Navigator.pop(context);
            },
          )
              : const SizedBox.shrink(),
          title: Text(title!, style: robotoStyle700Bold.copyWith(fontSize: 20)),
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size(double.maxFinite, appBarSize!);
}
