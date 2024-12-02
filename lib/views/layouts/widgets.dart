import 'package:auth_flutter/helper/constance.dart';
import 'package:flutter/material.dart';

class AppBarCustom extends StatelessWidget implements PreferredSizeWidget {
  const AppBarCustom({super.key, required this.title, this.centerTitle = true});
  final String title;
  final bool centerTitle;
  @override
  Widget build(BuildCo ntext context) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(fontSize: 18),
      ),
      centerTitle: centerTitle,
      backgroundColor: ConstColor.backroundAppBar,
    );
  }

  @override
  Size get preferrdSize => const Size.fromHeight(kTolbarHeight);
}
