import 'package:flutter/material.dart';
import 'package:login_note_fb/constants/app_colors.dart';
import 'package:login_note_fb/constants/my_text_styles.dart';
import 'package:login_note_fb/screens/dashboard.dart';
import 'package:login_note_fb/screens/setting.dart';

class MyDrawer extends StatefulWidget {
  late String id;

  MyDrawer({super.key, required this.id});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  int selectedIndex = 0;
  List<Widget> drawerItems = [];
  String title = "";

  @override
  void initState() {
    super.initState();
    drawerItems = [
      Dashboard(id: widget.id),
      const MySetting(),
    ];
  }

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text(
          title,
          style: mTextStyle16(mWeight: FontWeight.bold),
        ),
        backgroundColor: ColorConstant.gradiantDarkColor,
      ),
      drawer: Drawer(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topRight: Radius.circular(100),bottomLeft: Radius.circular(100) ) ,
        ),
        backgroundColor:ColorConstant.gradiantDarkColor ,
          child: ListView(padding: EdgeInsets.zero, children: [
        DrawerHeader(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CircleAvatar(
                backgroundColor: ColorConstant.gradiantLightColor,
                  radius: 40,
                  child: Image.asset(
                    "assets/icons/ic_notes.png",
                    width: 35,
                    height: 35,
                  )),
              Text("Notes",style: mTextStyle16(mWeight: FontWeight.bold),)
            ],
          ),
        ),
        ListTile(
          selectedTileColor: ColorConstant.gradiantLightColor,
          selected: selectedIndex == 0,
          title: Text(
            "Dashboard",
            style: mTextStyle16(
                mWeight: FontWeight.bold,
                mFontColor: ColorConstant.fontBlackColor),
          ),
          onTap: () {
            title = "Dashboard";

            onItemTapped(0);

            Navigator.pop(context);
          },
        ),
        ListTile(
          selectedTileColor: ColorConstant.gradiantLightColor,
          selected: selectedIndex == 1,
          title: Text(
            "Settings",
            style: mTextStyle16(
                mWeight: FontWeight.bold,
                mFontColor: ColorConstant.fontBlackColor),
          ),
          onTap: () {
            title = "Settings";
            onItemTapped(1);
            Navigator.pop(context);
          },
        )
      ])),
      body: drawerItems[selectedIndex],
    );
  }
}
