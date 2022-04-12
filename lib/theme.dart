import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'global.dart';

class ThemeConfig {
  static ThemeData createTheme({
    required Brightness brightness,
    required Color primary,
    required Color secondary,
    required Color primaryText,
    required Color secondaryText,
    required Color buttonColor,
    required Color disabled,
    required Color error,
  }) {
    final baseTextTheme = brightness == Brightness.dark
        ? Typography.blackMountainView
        : Typography.whiteMountainView;

    return ThemeData(
      brightness: brightness,
      buttonColor: buttonColor,
      canvasColor: secondary,
      cardColor: secondary,
      dividerColor: disabled,
      focusColor: primary,
      indicatorColor: primary,
      backgroundColor: secondary,
      primaryColor: primary,
      accentColor: primary,
      errorColor: error,
      toggleableActiveColor: primary,
      colorScheme: ColorScheme(
        primary: primary,
        primaryVariant: primary,
        secondary: secondary,
        secondaryVariant: secondary,
        surface: primary,
        background: secondary,
        error: error,
        onPrimary: secondary,
        onSecondary: primary,
        onSurface: Colors.black.withOpacity(0.12),
        onBackground: primary,
        onError: secondary,
        brightness: brightness,
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: buttonColor,
        padding: EdgeInsets.symmetric(
          vertical: 15.h,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          minimumSize: MaterialStateProperty.all<Size>(Size(158.0.w,46.h)),
          backgroundColor: MaterialStateProperty.all<Color>(buttonColor),
          elevation: MaterialStateProperty.all<double>(0),
        ),
      ),
      iconTheme: IconThemeData(
        size: 12.r,
        color: Global.black,
      ),
      inputDecorationTheme: InputDecorationTheme(
        fillColor: Global.white,
        filled: true,
        labelStyle: TextStyle(color: Global.gray),
        focusColor: Global.gray,
        focusedBorder: InputBorder.none,
        contentPadding: EdgeInsets.zero,
        isDense: true,
        suffixStyle: TextStyle(
          color: Global.black,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2.5.r),
          borderSide: BorderSide(color: Global.white),
        ),
        //hoverColor: Global.white,
      ),
      checkboxTheme: CheckboxThemeData(
        checkColor: MaterialStateProperty.all<Color>(secondaryText),
        fillColor: MaterialStateProperty.all<Color>(Global.white),
      ),
      fontFamily: 'Roboto',
      textTheme: TextTheme(
        headline5: baseTextTheme.headline5!.copyWith(
          color: primaryText,
          fontSize: 14.0.sp,
          fontWeight: FontWeight.w900,
          letterSpacing: 0.18,
        ),
        headline6: baseTextTheme.headline6!.copyWith(
          color: primaryText,
          fontSize: 24.0.sp,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.25,
        ),
        bodyText1: baseTextTheme.bodyText1!.copyWith(
          color: primaryText,
          fontSize: 16.0.sp,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.0,
        ),
        bodyText2: baseTextTheme.bodyText2!.copyWith(
          color: primaryText.withOpacity(0.6),
          fontSize: 16.4.sp,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.25,
        ),
        button: baseTextTheme.button!.copyWith(
          color: secondaryText,
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          letterSpacing: 1.25,
        ),
        subtitle1: baseTextTheme.subtitle1!.copyWith(
          color: secondaryText,
          fontSize: 16.sp,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.15,
        ),
        subtitle2: baseTextTheme.subtitle2!.copyWith(
          color: secondaryText,
          fontSize: 48.sp,
          fontWeight: FontWeight.w800,
          letterSpacing: 1.25,
        ),
      ),
    );
  }

  static ThemeData get theme => createTheme(
        brightness: Brightness.light,
        primary: Global.mediumBlue,
        secondary: Colors.black,
        primaryText: Global.white,
        secondaryText: Global.black,
        buttonColor: Global.white,
        disabled: Colors.black,
        error: Colors.red,
      );
}