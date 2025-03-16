import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthTextFormField extends StatelessWidget {
  const AuthTextFormField({
    super.key,
    required this.hintText,
    required this.prefix,
    this.suffixIcon,
    this.validator,
    this.keyboardType,
    this.onChanged,
    this.obscureText,
  });

  final String? Function(String?)? validator;
  final String hintText;
  final Widget? suffixIcon;
  final IconData prefix;
  final TextInputType? keyboardType;
  final void Function(String)? onChanged;
  final bool? obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText ?? false,
      keyboardType: keyboardType,
      onChanged: onChanged,
      validator: validator ??
          (value) {
            if (value!.isEmpty) {
              return 'هذا الحقل مطلوب';
            }
            return null;
          },
      decoration: InputDecoration(
        filled: true, 
        fillColor: Colors.white, 
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          color: Colors.grey.shade500, 
        ),
        border: _buildBorder(),
        focusedBorder: _buildBorder(),
        enabledBorder: _buildBorder(),

        prefixIcon: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: Colors.white, 
                  borderRadius: BorderRadius.circular(4.r),
                ),
                child: Icon(prefix, size: 18.w, color: Colors.black),
              ),
              SizedBox(width: 10.w), // مسافة صغيرة
              Container(
                width: 1.w,
                height: 20.h,
                color: Colors.grey.shade400, // لون الخط الفاصل
              ),
            ],
          ),
        ),
        suffixIcon: suffixIcon,
      ),
    );
  }

  OutlineInputBorder _buildBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(4.r),
      borderSide: BorderSide(
        color: Colors.grey.shade400,
        width: 1.w,
      ),
    );
  }
}
