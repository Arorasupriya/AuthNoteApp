import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_note_fb/constants/app_colors.dart';
import 'package:login_note_fb/constants/custom_widget.dart';
import 'package:login_note_fb/constants/global_methods_and_variables.dart';
import 'package:login_note_fb/constants/my_text_styles.dart';
import 'package:login_note_fb/screens/drawer.dart';
import 'package:login_note_fb/screens/sign_up.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  var formKey = GlobalKey<FormState>();

  var txtEmailController = TextEditingController();
  var txtPasswordController = TextEditingController();

  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
              top: 40, bottom: MediaQuery.of(context).viewInsets.bottom + 20),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Sign In",
                  style: mTextStyle25(
                      mWeight: FontWeight.bold,
                      mFontColor: ColorConstant.mattBlackColor),
                ),
                hSpacer(mHeight: 40),
                FittedBox(
                  fit: BoxFit.contain,
                  child: Text(
                    "Sign in with one of the following.",
                    style: mTextStyle12(
                        mWeight: FontWeight.w500, mFontColor: Colors.blueGrey),
                  ),
                ),
                hSpacer(mHeight: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: 50,
                      width: 80,
                      child: ElevatedButton(
                          onPressed: () {},
                          child: Image.asset(
                            "assets/icons/ic_google.png",
                            height: 25,
                            width: 25,
                            fit: BoxFit.contain,
                          )),
                    ),
                    SizedBox(
                      height: 50,
                      width: 80,
                      child: ElevatedButton(
                          onPressed: () {},
                          child: Image.asset(
                            "assets/icons/ic_apple_logo.png",
                            height: 25,
                            width: 25,
                            fit: BoxFit.contain,
                          )),
                    ),
                  ],
                ),
                hSpacer(mHeight: 40),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your email address";
                    }
                    return null;
                  },
                  controller: txtEmailController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  decoration: myDecoration(
                      mHintText: "Enter Your Email", mLabelText: "Email"),
                ),
                hSpacer(mHeight: 20),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter password";
                    } else if (value.isNotEmpty) {
                      if (value.length < 8) {
                        return "Must be at least 8 characters";
                      }
                    }
                    return null;
                  },
                  controller: txtPasswordController,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  obscureText: isPasswordVisible,
                  obscuringCharacter: "*",
                  decoration: myDecoration(
                      mHintText: "Password",
                      mLabelText: "Password",
                      surFixIconName: isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      onSurFixIconTap: () {
                        isPasswordVisible = !isPasswordVisible;
                        setState(() {});
                      }),
                ),
                hSpacer(mHeight: 20),
                Center(
                  child: SizedBox(
                    width: 300,
                    height: 50,
                    child: ElevatedButton(
                        onPressed: () async {
                          late bool isLoggedIn;
                          late String userId;
                          if (formKey.currentState!.validate()) {
                            var auth = FirebaseAuth.instance;
                            try {
                              var credential =
                                  await auth.signInWithEmailAndPassword(
                                      email: txtEmailController.text.toString(),
                                      password: txtPasswordController.text
                                          .toString());
                              print("SuccessFully logged in ");
                              isLoggedIn = true;
                              userId = credential.user!.uid;
                              print("========> $isLoggedIn,$userId");
                              setUserDataInSP(isLoggedIn, userId);
                              var idData = await getUserIdFromSP();
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          MyDrawer(id: idData)));
                              txtEmailController.clear();
                              txtPasswordController.clear();
                            } on FirebaseAuthException catch (e) {
                              print("error${e.code}");
                            }
                          }
                        },
                        child: Text(
                          "Log in",
                          style: mTextStyle12(
                              mFontColor: Colors.black,
                              mWeight: FontWeight.bold),
                        )),
                  ),
                ),
                hSpacer(mHeight: 30),
                InkWell(
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignUp()));
                  },
                  child: Center(
                    child: RichText(
                      text: TextSpan(
                          text: "Don't have an account?",
                          style: mTextStyle16(),
                          children: const [
                            TextSpan(
                                text: " Sign up",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue))
                          ]),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
