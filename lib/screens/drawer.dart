import 'package:flutter/material.dart';
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
      backgroundColor: Colors.cyanAccent.withAlpha(120),
      appBar: AppBar(
        backgroundColor: Colors.cyanAccent.withAlpha(120),
      ),
      drawer: Drawer(
          child: ListView(padding: EdgeInsets.zero, children: [
        DrawerHeader(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CircleAvatar(
                  radius: 40,
                  child: Image.asset(
                    "assets/icons/ic_notes.png",
                    width: 35,
                    height: 35,
                  )),
              Text("Notes")
            ],
          ),
        ),
        ListTile(
          selected: selectedIndex == 0,
          title: Text(
            "Dashboard",
            style: mTextStyle12(
                mWeight: FontWeight.bold,
                mFontColor: selectedIndex == 0 ? Colors.cyan : Colors.black),
          ),
          onTap: () {
            onItemTapped(0);
            Navigator.pop(context);
          },
        ),
        ListTile(
          selected: selectedIndex == 1,
          title: Text(
            "Settings",
            style: mTextStyle12(
                mWeight: FontWeight.bold,
                mFontColor: selectedIndex == 1 ? Colors.cyan : Colors.black),
          ),
          onTap: () {
            onItemTapped(1);
            Navigator.pop(context);
          },
        )
      ])),
      body: drawerItems[selectedIndex],
    );
  }
}
