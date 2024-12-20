import 'package:flutter/material.dart';
import 'package:my_pokedex/Helpers/text_styles.dart';

extension StringUtils on String {
  String get capitalizeFirst =>
      this[0].toUpperCase() + this.substring(1).toLowerCase();
}

extension GetStringUtils on String {
  String get capitalizeFirstGet =>
      this[0].toUpperCase() + this.substring(1).toLowerCase();
}


extension Intutils on int {
  String get nullCheck => this != null ? this.toString() : "N/A";
}

Row buildAboutInformation(String title, String information) {
  return Row(
    mainAxisSize: MainAxisSize.max,
    children: [
      Expanded(
        flex: 4,
        child: Text(
          title,
          style: AppTextStyle.smallBold.copyWith(color: Color(0xFFB4B5BE)),
        ),
      ),
      Expanded(
        flex: 6,
        child: Text(
          ":\t\t\t" + information,
          style: AppTextStyle.smallBold,
        ),
      ),
    ],
  );
}
