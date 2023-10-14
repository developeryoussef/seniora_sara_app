import '../screens.dart';
import 'package:get/get.dart';
import '../../widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import '../../firebase/loading_status.dart';
import '../../models/quiz_paper_model.dart';
import '../../configs/themes/app_colors.dart';
import '../../models/leader_boaed_model.dart';
import '../../controllers/auth_controller.dart';
import 'package:easy_separator/easy_separator.dart';
import '../../configs/themes/custom_text_styles.dart';
import '../../controllers/profile/profile_controller.dart';
import '../../controllers/quiz_paper/quiz_controller.dart';
import 'package:seniora_sara/configs/themes/ui_parameters.dart';
import '../../controllers/leader_board/leader_board_controller.dart';
// ignore_for_file: unused_import

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({Key? key}) : super(key: key);

  static const String routeName = '/profile';

  @override
  Widget build(BuildContext context) {
    final AuthController _auth = Get.find<AuthController>();
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const CustomAppBar(),
      body: BackgroundDecoration(
        showGradient: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: UIParameters.screenPadding.copyWith(top: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 35,
                        foregroundImage:
                            NetworkImage(_auth.getUser()!.photoURL!),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        _auth.getUser()!.displayName ?? '',
                        style: kHeaderTS,
                      )
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Text(
                      'My recent tests ',
                      style: TextStyle(
                          color: kOnSurfaceTextColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Obx(
                () => ContentArea(
                  addPadding: false,
                  child: ListView.separated(
                    padding: UIParameters.screenPadding,
                    itemCount: controller.allRecentTest.length,
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(
                        height: 15,
                      );
                    },
                    itemBuilder: (BuildContext context, int index) {
                      return RecentQuizCard(
                          recentTest: controller.allRecentTest[index]);
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
