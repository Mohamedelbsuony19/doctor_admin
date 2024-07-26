import 'package:clinic_package/clinic_package.dart';
import 'package:flutter/material.dart';

class SectionHeaderWidget extends StatelessWidget {
  const SectionHeaderWidget({
    super.key,
    required this.title,
    this.subtitle,
    this.themeIcon,
    this.onTap,
    this.showButton = false,
    this.titleFontWeight,
    this.size,
    this.titleStyle,
    this.subtitleStyle,
    this.hasSubtitle = false,
    this.rowMainAxisAlignment = MainAxisAlignment.spaceBetween,
    this.titlePadding = const EdgeInsets.all(16),
    this.subTitlefontWeight = FontWeight.w400,
    this.titleColor = Colors.black,
    this.subTitleColor = Colors.black,
    this.subTitlePadding = const EdgeInsets.all(16),
    this.iconColor = Colors.green,
    this.iconSize = 14,
  });
  final bool hasSubtitle;
  final String title;
  final String? subtitle;
  final bool showButton;
  final IconData? themeIcon;
  final void Function()? onTap;
  final FontWeight? titleFontWeight;
  final double? size;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;
  final MainAxisAlignment rowMainAxisAlignment;
  final EdgeInsets titlePadding;
  final FontWeight subTitlefontWeight;
  final Color titleColor;
  final Color subTitleColor;
  final EdgeInsets subTitlePadding;
  final Color iconColor;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: rowMainAxisAlignment,
        children: [
          Padding(
            padding: titlePadding,
            child: Text(
              title,
              style: titleStyle ??
                  TextStyle(
                    fontWeight: titleFontWeight,
                    color: titleColor,
                    fontSize: size,
                  ),
            ),
          ),
          if (showButton)
            Padding(
              padding: subTitlePadding,
              child: Row(
                children: [
                  Text(
                    subtitle ?? '',
                    style: subtitleStyle ??
                        TextStyle(
                          fontWeight: subTitlefontWeight,
                          color: subTitleColor,
                          fontSize: size,
                        ),
                  ),
                  Icon(
                    themeIcon,
                    color: iconColor,
                    size: iconSize,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                ],
              ),
            )
          else if (hasSubtitle)
            Text(
              subtitle ?? '',
              style: subtitleStyle ??
                  TextStyle(
                    fontWeight: subTitlefontWeight,
                    color: subTitleColor,
                    fontSize: size,
                  ),
            ),
        ],
      ),
    );
  }
}
