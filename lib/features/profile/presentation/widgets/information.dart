import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:next_gen/core/utils/app_colors.dart';
import 'package:next_gen/core/utils/assets.dart';

class TeamMember {
  final String name;
  final String role;
  final IconData icon;
  final String image;

  TeamMember({
    required this.name,
    required this.role,
    required this.icon,
    required this.image,
  });
}

class TeamPage extends StatefulWidget {
  const TeamPage({super.key});

  @override
  State<TeamPage> createState() => _TeamPageState();
}

class _TeamPageState extends State<TeamPage> {
  final List<TeamMember> teamMembers = [
    TeamMember(
      name: 'Omar Hesham',
      role: 'Flutter Developer',
      icon: Icons.phone_android,
      image: Assets.imagesOmar,
    ),
    TeamMember(
      name: 'Abdelrahman Saber',
      role: 'Backend Developer',
      icon: Icons.storage_rounded,
      image: Assets.imagesSaber,
    ),
    TeamMember(
      name: 'Mohamed Mehrez',
      role: 'Frontend Developer',
      icon: Icons.web_rounded,
      image: Assets.imagesMehrez,
    ),
    TeamMember(
      name: 'Youssef Ismail',
      role: 'UI/UX Designer',
      icon: Icons.design_services,
      image: Assets.imagesYousef,
    ),
    TeamMember(
      name: 'Ahmed Elgalad',
      role: 'DevOps Engineer',
      icon: Icons.cloud,
      image: Assets.imagesElgalad,
    ),
    TeamMember(
      name: 'Ahmed Badie',
      role: 'QA & Testing',
      icon: Icons.bug_report,
      image: Assets.imagesBadie,
    ),
    TeamMember(
      name: 'Belal Saleh',
      role: 'Project Manager',
      icon: Icons.leaderboard_rounded,
      image: Assets.imagesBelal,
    ),
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    for (var member in teamMembers) {
      precacheImage(AssetImage(member.image), context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final crossAxisCount = screenWidth < 600 ? 2 : 3;
    final childAspectRatio = screenWidth < 600 ? 0.85 : 0.9;

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        title: Text(
          'Graduation Team',
          style: TextStyle(
            fontSize: 20.sp,
            fontFamily: 'KaushanScript-Regular',
            color: AppColors.colorInCardHome,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
        foregroundColor: AppColors.colorInCardHome,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth < 600 ? 16.w : 32.w,
          vertical: 16.h,
        ),
        child: CustomScrollView(
          slivers: [
            SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final member = teamMembers[index];
                  return _buildTeamCard(member, screenWidth);
                },
                childCount: teamMembers.length,
              ),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                mainAxisSpacing: 20.h,
                crossAxisSpacing: 16.w,
                childAspectRatio: childAspectRatio,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTeamCard(TeamMember member, double screenWidth) {
    final color = _getRoleColor(member.role);
    final avatarRadius = screenWidth < 600 ? 38.r : 42.r;
    final fontSize = screenWidth < 600 ? 13.sp : 14.sp;
    final iconSize = screenWidth < 600 ? 10.w : 10.w;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
      ),
      elevation: 4,
      shadowColor: color.withOpacity(0.2),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          gradient: LinearGradient(
            colors: [Colors.white, color.withOpacity(0.05)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(3.w),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [color, color.withOpacity(0.7)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: color.withOpacity(0.3),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: CircleAvatar(
                  radius: avatarRadius,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: avatarRadius - 2.r,
                    backgroundImage: AssetImage(member.image),
                  ),
                ),
              ),
              SizedBox(height: screenWidth < 600 ? 16.h : 20.h),
              Text(
                member.name,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple[800],
                ),
              ),
              SizedBox(height: screenWidth < 600 ? 8.h : 25.h),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 2.w,
                  vertical: 2.h,
                ),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(color: color.withOpacity(0.3)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(member.icon, size: iconSize, color: color),
                    SizedBox(width: 6.w),
                    Flexible(
                      child: Text(
                        member.role,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: screenWidth < 600 ? 12.sp : 14.sp,
                          color: color,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (screenWidth >= 600) ...[
                SizedBox(height: 16.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildSocialButton(Icons.email, color, screenWidth),
                    SizedBox(width: 12.w),
                    _buildSocialButton(Icons.link, color, screenWidth),
                    SizedBox(width: 12.w),
                    _buildSocialButton(Icons.phone, color, screenWidth),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSocialButton(IconData icon, Color color, double screenWidth) {
    final size = screenWidth < 600 ? 28.w : 32.w;
    return Material(
      color: color.withOpacity(0.1),
      borderRadius: BorderRadius.circular(12.r),
      child: InkWell(
        borderRadius: BorderRadius.circular(12.r),
        onTap: () {},
        child: Padding(
          padding: EdgeInsets.all(8.w),
          child: Icon(icon, size: size - 12.w, color: color),
        ),
      ),
    );
  }

  Color _getRoleColor(String role) {
    if (role.toLowerCase().contains('flutter')) {
      return const Color(0xFF4F46E5);
    } else if (role.toLowerCase().contains('backend')) {
      return const Color(0xFF10B981);
    } else if (role.toLowerCase().contains('frontend')) {
      return const Color(0xFFF59E0B);
    } else if (role.toLowerCase().contains('designer')) {
      return const Color(0xFF8B5CF6);
    } else if (role.toLowerCase().contains('devops')) {
      return const Color(0xFFEC4899);
    } else if (role.toLowerCase().contains('qa') ||
        role.toLowerCase().contains('testing')) {
      return const Color(0xFF14B8A6);
    } else if (role.toLowerCase().contains('manager')) {
      return const Color(0xFFEF4444);
    } else {
      return const Color(0xFF6366F1);
    }
  }
}
