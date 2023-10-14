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
            ])),
        child: Form(
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
                        mFontColor: ColorConstant.fontBlackColor),
                  ),
                  hSpacer(mHeight: 40),
                  FittedBox(
                    fit: BoxFit.contain,
                    child: Text(
                      "Sign up with one of the following.",
                      style: mTextStyle12(
                          mWeight: FontWeight.w500,
                          mFontColor: ColorConstant.fontBlackColor),
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
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    ColorConstant.gradiantLightColor),
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
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    ColorConstant.gradiantLightColor),
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
                  hSpacer(mHeight: 40),
                  Center(
                    child: MyGElevatedButton(
                      borderRadius: BorderRadius.circular(12),
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
                            print("user added id ===> ${credential.user!.uid}");

                            gotoNextPage();

                            txtNameController.clear();
                            txtEmailController.clear();
                            txtPasswordController.clear();
                          } on FirebaseAuthException catch (e) {
                            var title = "Sign up Alert";
                            if (e.code == 'weak-password') {
                              var strMessage =
                                  'The password provided is too weak.';
                              ShowAlertBox(strMessage, title);
                            } else if (e.code == 'email-already-in-use') {
                              var strMessage =
                                  'The account already exists for that email.';
                              ShowAlertBox(strMessage, title);
                            }
                            print(e.code);
                          } catch (e) {
                            print(e);
                          }
                        }
                      },
                      child: Text(
                        "Create Account",
                        style: mTextStyle16(mWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  hSpacer(mHeight: 40),
                  InkWell(
                    onTap: () {
                      gotoNextPage();
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
      ),
    );
  }

  void ShowAlertBox(String content, String title) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Ok",
                    style: mTextStyle16(),
                  ))
            ],
          );
        });
  }

  gotoNextPage() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const SignIn()));
  }
}

//region Commented Code
/*
//PrivateMethode
 void ShowAlertBox(String content, String title) {
   showDialog(
       context: context,
       builder: (context) {
         return AlertDialog(
           title: Text(title),
           content: Text(content),
           actions: [
             TextButton(
                 onPressed: () {
                   Navigator.pop(context);
                 },
                 child: Text(
                   "Ok",
                   style: mTextStyle16(),
                 ))
           ],
         );
       });
 }
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

                                 gotoNextPage();

                                 txtNameController.clear();
                                 txtEmailController.clear();
                                 txtPasswordController.clear();
                               } on FirebaseAuthException catch (e) {
                                 var title = "Sign up Alert";
                                 if (e.code == 'weak-password') {
                                   var strMessage =
                                       'The password provided is too weak.';
                                   ShowAlertBox(strMessage, title);
                                 } else if (e.code == 'email-already-in-use') {
                                   var strMessage =
                                       'The account already exists for that email.';
                                   ShowAlertBox(strMessage, title);
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

 */
//endregion
