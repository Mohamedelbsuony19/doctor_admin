import 'package:flutter/material.dart';

class TotTextFormFiledSearchAtom extends StatelessWidget {
  const TotTextFormFiledSearchAtom({
    super.key,
    this.radius = 10,
    this.borderColor,
    this.suffixIcon,
    this.focusedBorderColor,
    this.validator,
    this.onChanged,
    required this.controller,
    this.icon,
    this.isPrefix = false, this.onTap,
  });
  final Widget? icon;
  final double? radius;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final void Function(String?)? onChanged;
  final TextEditingController controller;
  final bool isPrefix;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      autovalidateMode: AutovalidateMode.disabled,
      controller: controller,
      cursorColor: focusedBorderColor,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        prefixIcon: isPrefix ? icon ?? const Icon(Icons.search) : null,
        suffixIcon: isPrefix ? null : icon ?? const Icon(Icons.search),
        hintStyle: Theme.of(context)
            .textTheme
            .titleMedium!
            .copyWith(color: Colors.black87),
        hintText: Localizations.localeOf(context).toString() == "ar"
            ? "بحث"
            : "Search",
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius!),
            borderSide: BorderSide(color: borderColor!)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius!),
          borderSide: BorderSide(color: focusedBorderColor!),
        ),
      ),
      onChanged: onChanged,
    );
  }
}
