import 'package:get/get.dart';
import 'package:seniora_sara/firebase/firebase_configs.dart';
import 'package:seniora_sara/screens/screens.dart';
import '../../screens/homework/homework_screen.dart';
import '../../utils/utils.dart';
import '../auth_controller.dart';
import '../../models/quiz_paper_model.dart';
import '../../screens/quiz/quiz_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeWorkPapersController extends GetxController {
  @override
  void onReady() {
    getAllPapers();
    super.onReady();
  }

  final allPapers = <QuizPaperModel>[].obs;
  final allPaperImages = <String>[].obs;

  Future<void> getAllPapers() async {
    try {
      QuerySnapshot<Map<String, dynamic>> data = await homeWorkPaperFR.get();
      final paperList =
          data.docs.map((paper) => QuizPaperModel.fromSnapshot(paper)).toList();
      allPapers.assignAll(paperList);

      for (var paper in paperList) {}
      allPapers.assignAll(paperList);
    } catch (e) {
      AppLogger.e(e);
    }
  }

  void navigatoQuestions(
      {required QuizPaperModel paper, bool isTryAgain = false}) {
    AuthController _authController = Get.find();

    if (_authController.isLogedIn()) {
      if (isTryAgain) {
        Get.back();
        Get.offNamed(HomeWorkScreen.routeName,
            arguments: paper, preventDuplicates: false);
      } else {
        Get.toNamed(HomeWorkScreen.routeName, arguments: paper);
      }
    } else {
      _authController.showLoginAlertDialog();
    }
  }
}
