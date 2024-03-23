import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../settings_providers.dart';
import '../config/constants/app_colors.dart';

class CustomTextField extends StatefulWidget {
  bool  isObscure;
  bool isPassword;
  String  obscureCharacter;
  String? hintText;
  Icon? suffixIcon;

  int maxLines;
  int ? maxLength;
  final void Function(String?)? onChanged;
   String ?  initialValue;
  TextInputType? textInputType;
  FormFieldValidator<String>? validator;
  TextEditingController ?  controller;
  CustomTextField(
      {super.key,
      this.isObscure = false,
        this.isPassword=false,
      this.hintText,
      this.obscureCharacter = "*",
      this.suffixIcon,
      this.maxLines = 1,
        this.maxLength,
      this.textInputType,
        this.initialValue,
      this.validator,
      this.controller,
       this.onChanged,
      });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SettingsProvider>(context);
    var theme = Theme.of(context);
    return TextFormField(
       onChanged: widget.onChanged,
       initialValue: widget.initialValue,
      keyboardType: widget.textInputType,
      obscureText: widget.isObscure!,
      maxLines: widget.maxLines,
      maxLength: widget.maxLength,
      controller: widget.controller,
      onFieldSubmitted: (value){
      },
      obscuringCharacter: widget.obscureCharacter!,
      decoration: InputDecoration(
        suffixIcon: InkWell(
            onTap: () {
              setState(() {
                if(widget.isPassword){
                widget.isObscure = !widget.isObscure;
                }
              });
            },
            child: widget.suffixIcon),
        hintText: widget.hintText,
        focusedBorder: const UnderlineInputBorder(
            borderSide:
                 BorderSide(color: AppColors.primaryColor, width: 2.5)),
        errorBorder: const UnderlineInputBorder(
            borderSide:  BorderSide(color: Colors.red, width: 2.5)),
        errorStyle:theme.textTheme.labelMedium!.copyWith(color:Colors.red)
      ),
      validator: widget.validator,
      style: provider.isDark()
          ? theme.textTheme.labelMedium!
          : theme.textTheme.labelMedium!.copyWith(color: AppColors.darkText),
    );
  }
}
