import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:next_gen/features/start_up/presentation/widgets/bottom_sheet.dart';

class AddNewIdeaButton extends StatelessWidget {
  final VoidCallback onIdeaAdded;
  
  const AddNewIdeaButton({
    super.key,
    required this.onIdeaAdded,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final shouldRefresh = await showModalBottomSheet<bool>(
          context: context,
          isScrollControlled: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
          ),
          builder: (context) => const AddIdeaBottomSheet(),
        );
        
        if (shouldRefresh == true) {
          onIdeaAdded();
        }
      },
      child: DottedBorder(
        color: Colors.white.withOpacity(0.5),
        strokeWidth: 1.5,
        borderType: BorderType.RRect,
        dashPattern: const [6, 4],
        radius: Radius.circular(16.r),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 12.h),
          decoration: BoxDecoration(
            color: Colors.grey[800],
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(4.r),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.add,
                  color: Colors.black,
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
      ),
    );
  }
}