import 'package:get/get.dart';
import '../controllers/controllers.dart';
import 'package:seniora_sara/services/services.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(ThemeController());
    //Get.put(PapersDataUploader());
    Get.put(AuthController(), permanent: true);
  }
}
