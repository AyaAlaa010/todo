import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:todo/core/config/constants/app_colors.dart';
import 'package:todo/settings_providers.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/config/common.dart';
import '../../../core/config/constants/app_const.dart';
import '../../../core/service/snakers_service.dart';
import '../../../core/widgets/custom_textfield_widget.dart';
import '../../../firebase_utils.dart';
import '../../layout_view.dart';

class RegisterView extends StatefulWidget {
  static String routeName="RegisterView";

   RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  var formKey=GlobalKey<FormState>();
  late var locale;

  var emailController=TextEditingController();

  var passwordController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<SettingsProvider>(context)!;
     locale = AppLocalizations.of(context)!;
    var mediaQuery=MediaQuery.of(context).size;
    var theme=Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image:Image.asset( "assets/images/auth.png").image,fit: BoxFit.cover
        ),
        color: provider.isDark()?  AppColors.onPrimaryDarkColor:AppColors.onPrimaryColor
      ),
      child:  SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(

            child: Padding(padding: EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key:formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                   SizedBox(height: mediaQuery.height*0.07,),
                  Text(locale.create_account,textAlign: TextAlign.center,style:theme.textTheme.titleLarge ,),
                 SizedBox(height:mediaQuery.height*0.2,),
                  Text(
                    locale.full_name,
                    style: provider.isDark()
                        ? theme.textTheme.labelMedium!
                        .copyWith(fontWeight: FontWeight.bold)
                        : theme.textTheme.labelMedium!.copyWith(
                        color: AppColors.darkText,
                        fontWeight: FontWeight.bold),
                  ),
                  CustomTextField(
                    validator: (value) {
                      if (value == null ||
                          value.toString().trim().isEmpty) {
                        return  locale.full_name_empty;
                      }
                      return null;
                    },
                    suffixIcon: Icon(
                      Icons.person,
                      color: provider.isDark()
                          ? Colors.white
                          : AppColors.nav_color,
                    ),
                    hintText: locale.enter_name,
                    textInputType: TextInputType.text,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    locale.email,
                    style: provider.isDark()
                        ? theme.textTheme.labelMedium!
                        .copyWith(fontWeight: FontWeight.bold)
                        : theme.textTheme.labelMedium!.copyWith(
                        color: AppColors.darkText,
                        fontWeight: FontWeight.bold),
                  ),

                  CustomTextField(
                    controller: emailController,
                    validator: (value) {
                      if (value == null ||
                          value.toString().trim().isEmpty) {
                        return locale.email_empty;
                      }
                      if (!Common.checkRegexFormat(
                          AppConst.REGEX_EMAILE, value.toString())) {
                        return locale.valid_email;
                      }
                      return null;
                    },
                    suffixIcon: Icon(
                      Icons.mail,
                      color: provider.isDark()
                          ? Colors.white
                          : AppColors.nav_color,
                    ),
                    hintText: locale.enter_email,
                    textInputType: TextInputType.emailAddress,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    locale.password,
                    style: provider.isDark()
                        ? theme.textTheme.labelMedium!
                        .copyWith(fontWeight: FontWeight.bold)
                        : theme.textTheme.labelMedium!.copyWith(
                        color: AppColors.darkText,
                        fontWeight: FontWeight.bold),
                  ),
                  CustomTextField(
                    controller: passwordController,
                    validator: (value) {
                      if (value == null ||
                          value.toString().trim().isEmpty) {
                        return locale.password_empty;
                      }
                      if (!Common.checkRegexFormat(
                          AppConst.REGEX_PASSWORD, value.toString())) {
                        return locale.strong_password;
                      }
                      return null;
                    },
                    suffixIcon: Icon(
                      Icons.remove_red_eye,
                      color: provider.isDark()
                          ? Colors.white
                          : AppColors.nav_color,
                    ),
                    hintText: locale.enter_password,
                    isObscure: true,
                    obscureCharacter: "*",
                    textInputType: TextInputType.text,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    locale.confirm_password,
                    style: provider.isDark()
                        ? theme.textTheme.labelMedium!
                        .copyWith(fontWeight: FontWeight.bold)
                        : theme.textTheme.labelMedium!.copyWith(
                        color: AppColors.darkText,
                        fontWeight: FontWeight.bold),
                  ),
                  CustomTextField(
                    validator: (value) {
                      if (value == null ||
                          value.toString().trim().isEmpty) {
                        return  locale.confirm_password_empty;
                      }
                  if(passwordController.text!= value){
                    return locale.confirm_not_match_password;
                  }
                      return null;
                    },
                    suffixIcon: Icon(
                      Icons.remove_red_eye,
                      color: provider.isDark()
                          ? Colors.white
                          : AppColors.nav_color,
                    ),
                    hintText: locale.enter_confirm_password,
                    isObscure: true,
                    obscureCharacter: "*",
                    textInputType: TextInputType.text,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _register();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          locale.create_account,
                          style: provider.isDark()
                              ? theme.textTheme.labelMedium!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.darkText)
                              : theme.textTheme.labelMedium!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        Icon(
                          Icons.arrow_forward_outlined,
                          color: provider.isDark()
                              ? AppColors.nav_color
                              : Colors.white,
                        )
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)),
                        padding: EdgeInsets.symmetric(
                            horizontal: 15, vertical: 8)),
                  ),
                ],

              ),
            ),

            ),
          ),
        ),
      ),
    );
  }

  void _register() {
    if (formKey.currentState!.validate()) {
      FirebaseUtils(context)
          .createAccount(emailController.text, passwordController.text)
          .then((value) {
        if (value) {
          SnackerService(context).showSuccessMsg(locale.account_created_success);
          EasyLoading.dismiss();
          Navigator.pushNamedAndRemoveUntil(context, LayoutView.routeName, (route) => false,);
        }
      });
    }
  }
}

