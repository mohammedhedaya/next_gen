import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:next_gen/core/utils/app_colors.dart';
import 'package:next_gen/core/utils/app_text_style.dart';
import 'package:next_gen/core/utils/assets.dart';
import 'package:next_gen/features/profile/presentation/widgets/contact_us.dart';
import 'package:next_gen/features/profile/presentation/widgets/profile_menu_widget.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(
              width: 120,
              height: 120,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.asset(Assets.imagesOnboardingThree),
              ),
            ),
            const SizedBox(height: 10),
            Text('Omar Hesham', style: AppStyles.style14W400),
            Text('omar.hesham.213@gmail.com', style: AppStyles.style12W400),
            const SizedBox(height: 20),

            const Divider(),
            const SizedBox(height: 10),

            ///Menu
            ProfileMenuWidget(
              title: 'Our Location',
              icon: LineAwesomeIcons.location_arrow_solid,
              onPress: () {},
              endIcon: true,
            ),
            ProfileMenuWidget(
              title: 'Billing Details',
              icon: LineAwesomeIcons.wallet_solid,
              onPress: () {},
              endIcon: true,
            ),
            ProfileMenuWidget(
              title: 'User Management',
              icon: LineAwesomeIcons.user_check_solid,
              onPress: () {},
              endIcon: true,
            ),

            ProfileMenuWidget(
              title: 'Information',
              icon: LineAwesomeIcons.info_solid,
              onPress: () {},
              endIcon: true,
            ),
            ProfileMenuWidget(
              title: 'Logout',
              icon: LineAwesomeIcons.sign_out_alt_solid,
              textColor: Colors.red,
              onPress: () {},
              endIcon: true,
            ),
            const SizedBox(height: 30),
            const ContactUs(),
          ],
        ),
      ),
    );
  }
}
