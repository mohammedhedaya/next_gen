import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:next_gen/core/utils/app_colors.dart';
import 'package:next_gen/core/utils/app_text_style.dart';
import 'package:next_gen/core/utils/assets.dart';
import 'package:next_gen/features/auth/presentation/widgets/auth_text_form_field.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: 90.h),
                  Column(
                    children: [
                      Image.asset(
                        Assets.imagesBackgroundImage,
                        width: 199.33.w,
                        height: 80.h,
                      ),
                      SizedBox(height: 30.h),
                      Image.asset(
                        Assets.imagesWelcome,
                        width: 201.w,
                        height: 55.h,
                      ),
                    ],
                  ),

                  SizedBox(height: 40.h),

                  AuthTextFormField(
                    hintText: 'Email',
                    prefix: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) {
                      setState(() {});
                    },
                  ),

                  SizedBox(height: 15.h),

                  AuthTextFormField(
                    hintText: 'Password',
                    prefix: Icons.lock_outline,
                    obscureText: !_isPasswordVisible,
                    onChanged: (value) {
                      setState(() {});
                    },
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                  ),

                  SizedBox(height: 20.h),

                  buildButton(
                    text: 'Login',
                    color: AppColors.buttomTwoInLogin,
                    textColor: AppColors.blackColor,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.push("/bottomNavBar");
                      }
                    },
                  ),
                  SizedBox(height: 15.h),
                  buildButton(
                    text: 'Login with Google',
                    color: AppColors.whiteColor,
                    textColor: AppColors.blackColor,
                    icon: Assets.imagesGoogleIcons,
                  ),
                  SizedBox(height: 15.h),
                  buildButton(
                    text: 'Login with LinkedIn',
                    color: AppColors.buttomFourInLogin,
                    textColor: AppColors.whiteColor,
                    icon: Assets.imagesLinkedInIcons,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildButton({
    required String text,
    required Color color,
    required Color textColor,
    String? icon,
    VoidCallback? onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 50.h,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
        ),
        onPressed: onPressed ?? () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Image.asset(icon, width: 24.w, height: 24.h),
              SizedBox(width: 10.w),
            ],
            Text(text, style: AppStyles.style16W400.copyWith(color: textColor)),
          ],
        ),
      ),
    );
  }
}
