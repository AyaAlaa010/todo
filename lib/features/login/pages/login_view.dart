import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:todo/core/service/snakers_service.dart';
import 'package:todo/core/widgets/custom_textfield_widget.dart';
import 'package:todo/features/layout_view.dart';
import 'package:todo/features/register/pages/register_view.dart';
import 'package:todo/firebase_utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/config/common.dart';
import '../../../core/config/constants/app_colors.dart';
import '../../../core/config/constants/app_const.dart';
import '../../../settings_providers.dart';

class LoginView extends StatefulWidget {
  static const routeName = "loginView";

  LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  var formKey = GlobalKey<FormState>();
  var emailController=TextEditingController();
  var passwordController=TextEditingController();
  late var locale;

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    var provider = Provider.of<SettingsProvider>(context);
    var theme = Theme.of(context);
     locale = AppLocalizations.of(context)!;
    return Container(
        decoration: BoxDecoration(
          image: const DecorationImage(
              image: AssetImage("assets/images/auth.png"), fit: BoxFit.cover),
          color: provider.isDark()
              ? AppColors.onPrimaryDarkColor
              : AppColors.onPrimaryColor,
        ),
        child: SafeArea(
          child: Scaffold(
              backgroundColor: Colors.transparent,
              resizeToAvoidBottomInset: true,
              body: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(
                          height: mediaQuery.height * 0.07,
                        ),
                        Text(
                          locale.login,
                          style: theme.textTheme.titleLarge!,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: mediaQuery.height * 0.2,
                        ),
                        Text(
                          locale.welecome_back,
                          style: provider.isDark()
                              ? theme.textTheme.bodyLarge!
                                  .copyWith(color: Colors.white, fontSize: 24)
                              : theme.textTheme.bodyLarge!.copyWith(
                                  color: AppColors.darkText, fontSize: 24),
                        ),
                        const SizedBox(
                          height: 40,
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
                          height: 40,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            _login(context);
                            },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                locale.login,
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

                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          locale.or,
                          textAlign: TextAlign.center,
                          style: provider.isDark()
                              ? theme.textTheme.bodyLarge!
                                  .copyWith(color: Colors.white)
                              : theme.textTheme.bodyLarge!
                                  .copyWith(color: AppColors.darkText),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: (){
                            Navigator.pushNamed(context, RegisterView.routeName);
                          },
                          child: Text(
                            locale.create_new_account,
                            textAlign: TextAlign.center,
                            style: provider.isDark()
                                ? theme.textTheme.bodyLarge!
                                    .copyWith(color: Colors.white)
                                : theme.textTheme.bodyLarge!
                                    .copyWith(color: AppColors.darkText),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )),
        ));
  }
 void _login(BuildContext context){
   if (formKey.currentState!.validate()) {
     FirebaseUtils.login(emailController.text, passwordController.text,context)
         .then((value) {
       if (value) {
         SnackerService.showSuccessMsg(locale.success_login,context);
         EasyLoading.dismiss();
         Navigator.pushReplacementNamed(context, LayoutView.routeName);
       }
     });
   }
 }


}
