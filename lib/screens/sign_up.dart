import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_note_fb/constants/app_colors.dart';
import 'package:login_note_fb/constants/custom_widget.dart';
import 'package:login_note_fb/constants/my_text_styles.dart';
import 'package:login_note_fb/model/user_model.dart';
import 'package:login_note_fb/screens/sign_in.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  var formKey = GlobalKey<FormState>();
  var txtNameController = TextEditingController();
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
                  "Sign Up",
                  style: mTextStyle25(
                      mWeight: FontWeight.bold,
                      mFontColor: ColorConstant.mattBlackColor),
                ),
                hSpacer(mHeight: 40),
                FittedBox(
                  fit: BoxFit.contain,
                  child: Text(
                    "Sign up with one of the following.",
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
                      return "Please enter your full name";
                    }
                    return null;
                  },
                  controller: txtNameController,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  decoration: myDecoration(
                      mHintText: "Enter Your Name", mLabelText: "Name"),
                ),
                hSpacer(mHeight: 20),
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
                          if (formKey.currentState!.validate()) {
                            var auth = FirebaseAuth.instance;

                            try {
                              var name = txtNameController.text.toString();
                              var email = txtEmailController.text.toString();
                              var password =
                                  txtPasswordController.text.toString();

                              var credential =
                                  await auth.createUserWithEmailAndPassword(
                                      email: email, password: password);

                              var db = FirebaseFirestore.instance;
                              db
                                  .collection("users")
                                  .doc(credential.user!.uid)
                                  .set(UserModel(
                                          email: email,
                                          name: name,
                                          id: credential.user!.uid)
                                      .toJson());
                              print(
                                  "user added id ===> ${credential.user!.uid}");

                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignIn()));
                              txtNameController.clear();
                              txtEmailController.clear();
                              txtPasswordController.clear();
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'weak-password') {
                                print('The password provided is too weak.');
                              } else if (e.code == 'email-already-in-use') {
                                print(
                                    'The account already exists for that email.');
                              }
                              print(e.code);
                            } catch (e) {
                              print(e);
                            }
                          }
                        },
                        child: Text(
                          "Create Account",
                          style: mTextStyle12(
                              mFontColor: Colors.black,
                              mWeight: FontWeight.bold),
                        )),
                  ),
                ),
                hSpacer(mHeight: 40),
                InkWell(
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignIn()));
                  },
                  child: Center(
                    child: RichText(
                      text: TextSpan(
                          text: "Already have an account?",
                          style: mTextStyle16(),
                          children: const [
                            TextSpan(
                                text: " Log in",
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
