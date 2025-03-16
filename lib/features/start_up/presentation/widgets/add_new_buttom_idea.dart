import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dotted_border/dotted_border.dart'; // مكتبة للحدود المتقطعة

class AddNewIdeaButton extends StatelessWidget {
  const AddNewIdeaButton({super.key});

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      color: Colors.white.withOpacity(0.5), // لون الحدود
      strokeWidth: 1.5, // سمك الحدود
      borderType: BorderType.RRect, // حواف دائرية
      dashPattern: const [6, 4], // نمط التقطيع (6px خط - 4px فراغ)
      radius: Radius.circular(16.r), // تدوير الحواف
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
          color: Colors.grey[800], // لون الخلفية
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // أيقونة داخل دائرة
            Container(
              padding: EdgeInsets.all(4.r),
              decoration: const BoxDecoration(
                color: Colors.white, // لون الدائرة
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.add,
                color: Colors.black, // لون الأيقونة
                size: 18.sp,
              ),
            ),
            SizedBox(width: 8.w),
            Text(
              "Add New Idea",
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
