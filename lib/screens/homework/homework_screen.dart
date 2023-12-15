import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:seniora_sara/controllers/quiz_paper/home_work_controller.dart';
import '../../firebase/loading_status.dart';
import '../../widgets/quiz/answer_card.dart';
import '../../configs/themes/app_colors.dart';
import '../../widgets/common/main_button.dart';
import '../../widgets/common/content_area.dart';
import '../../configs/themes/ui_parameters.dart';
import '../../widgets/quiz/countdown_timer.dart';
import '../../widgets/common/custom_app_bar.dart';
import '../../configs/themes/custom_text_styles.dart';
import '../../controllers/quiz_paper/quiz_controller.dart';
import '../../widgets/common/screen_background_decoration.dart';
import 'package:seniora_sara/screens/quiz/quiz_overview_screen.dart';
import '../../widgets/loading_shimmers/quiz_screen_placeholder.dart';
import 'homeworkoverview_screen.dart';
// ignore_for_file: sort_child_properties_last

class HomeWorkScreen extends GetView<HomeWorkController> {
  const HomeWorkScreen({Key? key}) : super(key: key);

  static const String routeName = '/homeworkscreen';

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: controller.onExitOfQuiz,
      child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: CustomAppBar(
            isHomework: true,
            leading: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Obx(
                () => CountdownTimer(
                  time: controller.time.value,
                  color: kOnSurfaceTextColor,
                ),
              ),
              decoration: const ShapeDecoration(
                shape: StadiumBorder(
                    side: BorderSide(color: kOnSurfaceTextColor, width: 2)),
              ),
            ),
            showActionIcon: true,
            titleWidget: Obx(() => Text(
                  'Q. ${(controller.questionIndex.value + 1).toString().padLeft(2, '0')}',
                  style: kAppBarTS,
                )),
          ),
          body: BackgroundDecoration(
            child: Obx(
              () => Column(
                children: [
                  if (controller.loadingStatus.value == LoadingStatus.loading)
                    const Expanded(
                        child: ContentArea(child: QuizScreenPlaceHolder())),
                  if (controller.loadingStatus.value == LoadingStatus.completed)
                    Expanded(
                      child: ContentArea(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.only(top: 20),
                          child: Column(
                            children: [
                              Text(
                                controller.currentQuestion.value!.question,
                                style: kQuizeTS,
                              ),
                              GetBuilder<HomeWorkController>(
                                  id: 'answers_list',
                                  builder: (context) {
                                    return ListView.separated(
                                      itemCount: controller.currentQuestion
                                          .value!.answers.length,
                                      shrinkWrap: true,
                                      padding: const EdgeInsets.only(top: 25),
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      separatorBuilder:
                                          (BuildContext context, int index) {
                                        return const SizedBox(
                                          height: 10,
                                        );
                                      },
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        final answer = controller
                                            .currentQuestion
                                            .value!
                                            .answers[index];
                                       return AnswerCard(
                                          isSelected: answer.identifier ==
                                              controller.currentQuestion.value!
                                                  .selectedAnswer,
                                          onTap: () {
                                            controller.selectAnswer(
                                                answer.identifier);
                                          },
                                          answer:
                                              '${answer.identifier}. ${answer.answer}',
                                        );
                                      },
                                    );
                                  }),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ColoredBox(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: Padding(
                      padding: UIParameters.screenPadding,
                      child: Row(
                        children: [
                          Visibility(
                            visible: controller.isFirstQuestion,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 5.0),
                              child: SizedBox(
                                height: 55,
                                width: 55,
                                child: MainButton(
                                  onTap: () {
                                    controller.prevQuestion();
                                  },
                                  child: const Icon(Icons.arrow_back_ios_new),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Obx(
                              () => Visibility(
                                visible: controller.loadingStatus.value ==
                                    LoadingStatus.completed,
                                child: MainButton(
                                  onTap: () {
                                    controller.islastQuestion
                                        ? Get.toNamed(
                                            HomeWorkOverviewScreen.routeName)
                                        : controller.nextQuestion();
                                  },
                                  title: controller.islastQuestion
                                      ? 'Complete'
                                      : 'Next',
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
