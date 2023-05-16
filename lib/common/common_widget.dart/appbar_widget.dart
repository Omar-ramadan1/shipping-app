import 'package:flutter/material.dart';
import '../../constant/colors.dart';


class Appbar_widget extends StatelessWidget with PreferredSizeWidget {
  final String title;
  final Widget iconButton;
  Appbar_widget(this.title,this.iconButton);
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(130),
      child: AppBar(
        backgroundColor: AppColor.mainAppColor,
        bottomOpacity: 0.0,
        centerTitle: true,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(
              Icons.menu_outlined,
              size: 29,
            ),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        elevation: 0,
        actions: [
          // Icon(Icons.sync),
          iconButton,
          Text("   "),
        ],
        title: Text(
          title,
          style: TextStyle(fontSize: 19),
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize

  Size get preferredSize => Size.fromHeight(65);
}
