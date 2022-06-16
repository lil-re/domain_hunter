import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  String title;
  List<Widget>? actions;
  bool displayNavigation;
  VoidCallback? onNavigationTap;

  CustomAppBar({
    Key? key,
    required this.title,
    this.actions,
    this.displayNavigation = false,
    this.onNavigationTap,
  }) : super(key: key);

  Widget? _getLeading() {
    return displayNavigation
        ? IconButton(
      onPressed: onNavigationTap,
      icon: const Icon(
        Icons.keyboard_arrow_left_rounded,
        color: Colors.black,
        size: 34,
      ),
    )
        : null;
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      leading: _getLeading(),
      centerTitle: false,
      elevation: 0,
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w600,
          fontSize: 28,
        ),
      ),
      actions: actions,
    );
  }
}
