import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';

class NewsCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String companyName;
  final String date;
  final String logoUrl;

  const NewsCard({
    required this.imageUrl,
    required this.title,
    required this.companyName,
    required this.date,
    required this.logoUrl,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image with gradient overlay
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.r),
                  topRight: Radius.circular(16.r),
                ),
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  width: double.infinity,
                  height: 180.h,
                  fit: BoxFit.cover,
                  placeholder:
                      (context, url) => Container(
                        height: 180.h,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16.r),
                            topRight: Radius.circular(16.r),
                          ),
                        ),
                        child: const Center(child: CircularProgressIndicator()),
                      ),
                  errorWidget:
                      (context, url, error) => Container(
                        height: 180.h,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16.r),
                            topRight: Radius.circular(16.r),
                          ),
                        ),
                        child: const Icon(
                          Icons.article,
                          size: 50,
                          color: Colors.grey,
                        ),
                      ),
                ),
              ),
              // Gradient overlay
              Container(
                height: 180.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16.r),
                    topRight: Radius.circular(16.r),
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [Colors.black.withOpacity(0.7), Colors.transparent],
                  ),
                ),
              ),
              // Source name in the bottom-left corner of image
              Positioned(
                left: 12.w,
                bottom: 12.h,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    companyName,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Content section
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    height: 1.4,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 12.h),

                // Date and read time
                Row(
                  children: [
                    Icon(Icons.calendar_today, size: 14.sp, color: Colors.grey),
                    SizedBox(width: 4.w),
                    Text(
                      _formatDate(date),
                      style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                    ),
                    SizedBox(width: 12.w),
                    Icon(Icons.timer, size: 14.sp, color: Colors.grey),
                    SizedBox(width: 4.w),
                    Text(
                      '3 min read', // You can calculate this based on content length
                      style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),

                // Divider
                Divider(height: 1.h, color: Colors.grey[200]),
                SizedBox(height: 8.h),

                // Footer with logo and save button
                Row(
                  children: [
                    // Publisher logo
                    CircleAvatar(
                      radius: 14.r,
                      backgroundColor: Colors.grey[200],
                      backgroundImage:
                          logoUrl.isNotEmpty ? NetworkImage(logoUrl) : null,
                      child:
                          logoUrl.isEmpty
                              ? Icon(
                                Icons.public,
                                size: 14.sp,
                                color: Colors.grey,
                              )
                              : null,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      companyName,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.grey[600],
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(String dateString) {
    try {
      final dateTime = DateTime.parse(dateString);
      return '${_getMonthName(dateTime.month)} ${dateTime.day}, ${dateTime.year}';
    } catch (e) {
      return dateString;
    }
  }

  String _getMonthName(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return months[month - 1];
  }
}
