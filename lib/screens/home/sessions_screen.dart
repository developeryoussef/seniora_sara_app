// ignore_for_file: unused_local_variable, unnecessary_cast

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../configs/themes/light_theme.dart';
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

class SessionsScreen extends GetView<MyDrawerController> {
  const SessionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                      child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('sessions')
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return LinearProgressIndicator(
                              color: kPrimayLightColorLT,
                            );
                          }
                          return ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              var data = snapshot.data!.docs[index].data()
                                  as Map<String, dynamic>;
                              return Padding(
                                padding: const EdgeInsets.all(20),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color:
                                          Color.fromARGB(255, 247, 255, 247)),
                                  child: Center(
                                    child: ListTile(
                                      contentPadding: EdgeInsets.all(8),
                                      leading: Container(
                                        height: 65,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: Color.fromARGB(
                                              255, 220, 240, 235),
                                        ),
                                        child:
                                            Image.asset('assets/Picture1.png'),
                                      ),
                                      title: Text(data['title'],
                                          style: cardTitleTs(context)),
                                      subtitle: Text(data['subtitle']),
                                      onTap: () async {
                                        await launchUrl(Uri.parse(
                                            data['linkurl'].toString()));
                                      },
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
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
