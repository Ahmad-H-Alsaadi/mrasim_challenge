// lib/core/constants/logo_constants.dart

import 'package:flutter/material.dart';

class LogoConstants {
  static const double logoHeight = 150.0;
  static const double logoWidth = 150.0;
}

class Insets {
  static const EdgeInsets allPadding = EdgeInsets.all(16.0);
  static const EdgeInsets allMargin = EdgeInsets.all(16.0);
  static const EdgeInsets symmetricPadding = EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0);
  static const EdgeInsets symmetricMargin = EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0);
  static const EdgeInsets smallPadding = EdgeInsets.all(8.0);
  static const EdgeInsets mediumPadding = EdgeInsets.all(16.0);
  static const EdgeInsets largePadding = EdgeInsets.all(32.0);
}

class Sizes {
  static const double smallSize = 8.0;
  static const double mediumSize = 16.0;
  static const double largeSize = 32.0;
  static const double extraLargeSize = 64.0;
  static const double buttonHeight = 48.0;
  static const double buttonWidth = double.infinity;
  static const double iconSize = 24.0;
}

class Fonts {
  static const String primaryFont = 'Roboto';
  static const String secondaryFont = 'Arial';
}

class TextStyles {
  static const TextStyle heading1 = TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static const TextStyle heading2 = TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static const TextStyle bodyText1 = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.normal,
    color: Colors.black,
  );

  static const TextStyle bodyText2 = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.normal,
    color: Colors.black,
  );

  static const TextStyle buttonText = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
}

class Borders {
  static const BorderRadius smallBorderRadius = BorderRadius.all(Radius.circular(8.0));
  static const BorderRadius mediumBorderRadius = BorderRadius.all(Radius.circular(16.0));
  static const BorderRadius largeBorderRadius = BorderRadius.all(Radius.circular(32.0));

  static const BorderSide defaultBorderSide = BorderSide(
    color: Colors.black,
    width: 1.0,
  );

  static const OutlineInputBorder defaultBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(8.0)),
    borderSide: defaultBorderSide,
  );
}

class Styles {
  static const BoxDecoration containerDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: Borders.mediumBorderRadius,
    boxShadow: [
      BoxShadow(
        color: Colors.black12,
        blurRadius: 8.0,
        offset: Offset(0, 4),
      ),
    ],
  );

  static const BoxDecoration buttonDecoration = BoxDecoration(
    color: Colors.blue,
    borderRadius: Borders.smallBorderRadius,
  );

  static const BoxDecoration cardDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: Borders.largeBorderRadius,
    boxShadow: [
      BoxShadow(
        color: Colors.black26,
        blurRadius: 6.0,
        offset: Offset(0, 2),
      ),
    ],
  );

  // Input Decorations
  static const InputDecoration textFieldDecoration = InputDecoration(
    border: Borders.defaultBorder,
    filled: true,
    fillColor: Colors.white,
    contentPadding: Insets.symmetricPadding,
  );
}
