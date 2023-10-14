import 'package:flutter/material.dart';
import 'package:login_note_fb/constants/app_colors.dart';
import 'package:login_note_fb/constants/my_text_styles.dart';

InputDecoration myDecoration({
  required String mHintText,
  required String mLabelText,
  double bRadius = 21.0,
  Color bColor = ColorConstant.gradiantDarkColor,
  Color mFillColor = Colors.white12,
  bool isFilled = true,
  IconData? preFixIconName,
  IconData? surFixIconName,
  VoidCallback? onSurFixIconTap,
  Color mySuffixIconColor = ColorConstant.gradiantDarkColor,
}) {
  return InputDecoration(
    contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
    suffixIconColor: mySuffixIconColor,
    hintText: mHintText,
    hintStyle: mTextStyle12(mFontColor:Colors.black),//ColorConstant. textOnBGColor
    label: Text(mLabelText),
    labelStyle: mTextStyle12(mFontColor:Colors.black),//ColorConstant.textOnBGColor
    fillColor: mFillColor,
    filled: isFilled,
    prefixIcon: preFixIconName != null ? Icon(preFixIconName) : null,
    suffixIcon: surFixIconName != null ? InkWell(onTap: onSurFixIconTap,child: Icon(surFixIconName)) : null,
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(bRadius),
        borderSide: BorderSide(color: bColor)),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(bRadius),
      borderSide: BorderSide(color: bColor),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(bRadius),
      borderSide: BorderSide(color: bColor),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(bRadius),
      borderSide: BorderSide(color: bColor),
    ),
  );
}

Widget hSpacer({double mHeight = 11}){
  return  SizedBox(height: mHeight,);
}

Widget wSpacer({double mWidth = 11}){
  return  SizedBox(width: mWidth,);
}

Widget customElevatedButton ({
  required VoidCallback onTap,
  required String? title,
  IconData? iconName,
  bool isChildText = true,
  Color? buttonBGColor,
  double? mElevation,
  double?mButtonHeight,
  double? mButtonWidth,
  double? bRadius
}){
  return ElevatedButton(
    onPressed: onTap,
    style:ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(bRadius!)),
        backgroundColor: buttonBGColor,
        padding: !isChildText?EdgeInsets.zero:null,
        elevation: mElevation,
        minimumSize: Size(mButtonWidth!, mButtonHeight!)
    ) ,
    child: isChildText ? Text(title!,style: mTextStyle12(mFontColor:ColorConstant.greyColor),):Icon(iconName),);
}

class MyGElevatedButton extends StatelessWidget {
  final BorderRadiusGeometry? borderRadius;
  final double? width;
  final double height;
  final Gradient gradient;
  final VoidCallback? onPressed;
  final Widget child;

  const MyGElevatedButton({
    Key? key,
    required this.onPressed,
    required this.child,
    this.borderRadius,
    this.width,
    this.height = 44.0,
    this.gradient = const LinearGradient(colors: [ColorConstant.gradiantDarkColor,ColorConstant.gradiantLightColor]),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final borderRadius = this.borderRadius ?? BorderRadius.circular(0);
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: borderRadius,
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: borderRadius),
        ),
        child: child,
      ),
    );
  }
}



