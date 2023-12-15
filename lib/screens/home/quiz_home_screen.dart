import '../screens.dart';
import 'custom_drawer.dart';
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
import '../../controllers/common/drawer_controller.dart';
import '../../controllers/quiz_paper/quiz_controller.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:seniora_sara/configs/themes/ui_parameters.dart';
import 'package:seniora_sara/configs/themes/app_icons_icons.dart';
import '../../controllers/quiz_paper/quiz_papers_controller.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import '../../controllers/leader_board/leader_board_controller.dart';
// ignore_for_file: unused_import

class HomeScreen extends GetView<MyDrawerController> {
  const HomeScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    QuizPaperController _quizePprContoller = Get.put(QuizPaperController());
    final AuthController _auth = Get.find();
    final user = _auth.getUser();
    return Scaffold(
        body: GetBuilder<MyDrawerController>(
      builder: (_) => ZoomDrawer(
        controller: _.zoomDrawerController,
        borderRadius: 50.0,
        showShadow: true,
        angle: 0.0,
        style: DrawerStyle.DefaultStyle,
        menuScreen: const CustomDrawer(),
        backgroundColor: Colors.white.withOpacity(0.5),
        slideWidth: MediaQuery.of(context).size.width * 0.6,
        mainScreen: Container(
          decoration: BoxDecoration(gradient: mainGradient(context)),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(kMobileScreenPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Transform.translate(
                        offset: const Offset(-10, 0),
                        child: CircularButton(
                          child: const Icon(
                            Icons.menu,
                            size: 25,
                          ),
                          onTap: controller.toggleDrawer,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          children: [
                            Builder(
                              builder: (_) {
                                String label = 'Hello Student';
                                if (user != null) {
                                  label = 'Hello ${user.displayName}';
                                }
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    user != null
                                        ? CircleAvatar(
                                            backgroundImage: NetworkImage(
                                                '${user.photoURL}'),
                                            radius: 40,
                                            backgroundColor: Colors.grey,
                                          )
                                        : Container(),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(label,
                                        style: kDetailsTS.copyWith(
                                            color: kOnSurfaceTextColor,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      const Text('Signora Sara Quizes and Homeworks',
                          style: kHeaderTS),
                      const SizedBox(height: 15),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.5),
                    child: ContentArea(
                      addPadding: false,
                      child: Obx(
                        () => LiquidPullToRefresh(
                          height: 115,
                          springAnimationDurationInMilliseconds: 500,
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.5),
                          onRefresh: () async {
                            _quizePprContoller.getAllPapers();
                          },
                          child: ListView.separated(
                            padding: UIParameters.screenPadding,
                            shrinkWrap: true,
                            itemCount: _quizePprContoller.allPapers.length,
                            itemBuilder: (BuildContext context, int index) {
                              return QuizPaperCard(
                                model: _quizePprContoller.allPapers[index],
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return const SizedBox(
                                height: 20,
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
