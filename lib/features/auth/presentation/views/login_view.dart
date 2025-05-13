import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:next_gen/core/utils/app_colors.dart';
import 'package:next_gen/core/utils/app_text_style.dart';
import 'package:next_gen/core/utils/assets.dart';
import 'package:next_gen/features/auth/presentation/auth/auth_firebase.dart';
import 'package:next_gen/features/auth/presentation/widgets/auth_text_form_field.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  bool _isPasswordVisible = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(
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
                        controller: _emailController,
                        hintText: 'Email',
                        prefix: Icons.email_outlined,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              !value.contains('@')) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 15.h),
                      AuthTextFormField(
                        controller: _passwordController,
                        hintText: 'Password',
                        prefix: Icons.lock_outline,
                        obscureText: !_isPasswordVisible,
                        validator: (value) {
                          if (value == null || value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
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
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() => isLoading = true);
                            await _authService.signInWithEmailAndPassword(
                              context,
                              _emailController.text.trim(),
                              _passwordController.text.trim(),
                            );
                            setState(() => isLoading = false);
                          }
                        },
                      ),
                      SizedBox(height: 15.h),
                      buildButton(
                        text: 'Login with Google',
                        color: AppColors.whiteColor,
                        textColor: AppColors.blackColor,
                        icon: Assets.imagesGoogleIcons,
                        onPressed: () async {
                          setState(() => isLoading = true);
                          await _authService.signInWithGoogle(context);
                          setState(() => isLoading = false);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          if (isLoading)
            Container(
              color: Colors.black.withOpacity(0.3),
              child: const Center(child: CircularProgressIndicator()),
            ),
        ],
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
