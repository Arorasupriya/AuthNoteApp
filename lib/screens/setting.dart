import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
    return Scaffold(
      backgroundColor: Colors.cyanAccent.withAlpha(120),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Settings",
              style: mTextStyle16(
                  mWeight: FontWeight.bold, mFontColor: Colors.white),
            ),
            const SizedBox(
              height: 20,
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
                          color: Colors.white,
                        ),
                        wSpacer(),
                        Text("Sign out",
                            style: mTextStyle16(
                                mWeight: FontWeight.w400,
                                mFontColor: Colors.white))
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
