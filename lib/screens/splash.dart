import 'dart:async';

import 'package:flutter/material.dart';
import 'package:login_note_fb/constants/app_colors.dart';
import 'package:login_note_fb/constants/custom_widget.dart';
import 'package:login_note_fb/constants/global_methods_and_variables.dart';
import 'package:login_note_fb/constants/my_text_styles.dart';
import 'package:login_note_fb/screens/drawer.dart';
import 'package:login_note_fb/screens/sign_up.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 4), () {
      getIsUserLoggedIn();
    });
  }

  getIsUserLoggedIn() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool? getLoginStatus =
        pref.getBool(AppVariables.IS_LOGGED_IN_USER) ?? false;
    String? getUserId = pref.getString(AppVariables.USER_ID) ?? "";
    print("=======>$getUserId,$getLoginStatus");
    if (getLoginStatus) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => MyDrawer(
                    id: getUserId,
                  )));
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const SignUp()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[
              ColorConstant.gradiantDarkColor,
              ColorConstant.gradiantLightColor
            ])),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Note App",
                style: mTextStyle25(
                    mWeight: FontWeight.bold,
                    mFontColor: ColorConstant.fontBlackColor),
              ),
              hSpacer(mHeight: 10),
              CircleAvatar(
                radius: 50,
                backgroundColor: ColorConstant.gradiantDarkColor,
                child: Image.asset(
                  "assets/icons/ic_notes.png",
                  width: 40,
                  height: 40,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
