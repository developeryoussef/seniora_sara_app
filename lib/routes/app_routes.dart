import 'package:get/get.dart';
import 'package:seniora_sara/controllers/quiz_paper/home_work_controller.dart';
import 'package:seniora_sara/controllers/quiz_paper/homeworkscontroller.dart';
import 'package:seniora_sara/screens/home/homework_home_screen.dart';
import 'package:seniora_sara/screens/homework/answercheck_screen.dart';
import 'package:seniora_sara/screens/homework/homework_screen.dart';
import 'package:seniora_sara/screens/homework/homeworkoverview_screen.dart';
import 'package:seniora_sara/screens/viewcontroller.dart';
import '../screens/screens.dart';
import '../screens/splash/splash.dart';
import '../controllers/common/drawer_controller.dart';
import '../controllers/profile/profile_controller.dart';
import '../controllers/quiz_paper/quiz_controller.dart';
import '../screens/onboarding/app_indroduction_screen.dart';
import '../controllers/quiz_paper/quiz_papers_controller.dart';
import '../controllers/leader_board/leader_board_controller.dart';
// ignore_for_file: unnecessary_import

class AppRoutes {
  static List<GetPage> pages() => [
        GetPage(
          page: () => const SplashScreen(),
          name: SplashScreen.routeName,
        ),
        GetPage(
            page: () => ViewController(),
            name: ViewController.routeName,
            binding: BindingsBuilder(() {
              Get.put(QuizPaperController());
              Get.put(MyDrawerController());
              Get.put(HomeWorkPapersController());
            })),
        GetPage(page: () => const LoginScreen(), name: LoginScreen.routeName),
        GetPage(
            page: () => const ProfileScreen(),
            name: ProfileScreen.routeName,
            binding: BindingsBuilder(() {
              Get.put(QuizPaperController());
            })),
        GetPage(
            page: () => LeaderBoardScreen(),
            name: LeaderBoardScreen.routeName,
            binding: BindingsBuilder(() {
              Get.put(LeaderBoardController());
            })),
        GetPage(
            page: () => QuizeScreen(),
            name: QuizeScreen.routeName,
            binding: BindingsBuilder(() {
              Get.put<QuizController>(QuizController());
            })),
        GetPage(
            page: () => const AnswersCheckScreen(),
            name: AnswersCheckScreen.routeName),
        GetPage(
            page: () => const QuizOverviewScreen(),
            name: QuizOverviewScreen.routeName),
        GetPage(page: () => const Resultcreen(), name: Resultcreen.routeName),
        //
        //
        //
        //
        GetPage(
            page: () => HomeWorkScreen(),
            name: HomeWorkScreen.routeName,
            binding: BindingsBuilder(() {
              Get.put<HomeWorkController>(HomeWorkController());
            })),
        GetPage(
            page: () => const HomeworkAnswersCheckScreen(),
            name: HomeworkAnswersCheckScreen.routeName),
        GetPage(
            page: () => const HomeWorkOverviewScreen(),
            name: HomeWorkOverviewScreen.routeName),
      ];
}
