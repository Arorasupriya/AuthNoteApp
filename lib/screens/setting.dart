import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_note_fb/constants/app_colors.dart';
import 'package:login_note_fb/constants/custom_widget.dart';
import 'package:login_note_fb/constants/global_methods_and_variables.dart';
import 'package:login_note_fb/constants/my_text_styles.dart';
import 'package:login_note_fb/screens/sign_in.dart';

class MySetting extends StatefulWidget {
  const MySetting({super.key});

  @override
  State<MySetting> createState() => _SettingState();
}

class _SettingState extends State<MySetting> {
  @override
  Widget build(BuildContext context) {
    var DEVICE_SIZE = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        height: DEVICE_SIZE.height,
        width: DEVICE_SIZE.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              ColorConstant.gradiantDarkColor,
              ColorConstant.gradiantLightColor
            ]
          )
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              Expanded(
                child: ListView.separated(
                  separatorBuilder: (BuildContext context, int index) {
                    return const Divider(
                      color: Colors.black,
                      height: 2,
                    );
                  },
                  itemCount: 1,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () async {
                        var isLoggedIn = false;
                        var userId = "";
                        setUserDataInSP(isLoggedIn, userId);
                        await FirebaseAuth.instance.signOut();
                        print("u are successfully logout");
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => SignIn()));
                      },
                      child: Row(
                        children: [
                          const Icon(
                            Icons.logout,
                            size: 25,
                            color: ColorConstant.fontBlackColor,
                          ),
                          wSpacer(),
                          Text("Sign out",
                              style: mTextStyle16(
                                  mWeight: FontWeight.w400,
                                  mFontColor: ColorConstant.fontBlackColor))
                        ],
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
