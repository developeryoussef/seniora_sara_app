import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../configs/themes/app_colors.dart';
import '../../widgets/common/main_button.dart';
import '../../controllers/auth_controller.dart';
import '../../configs/themes/ui_parameters.dart';
import '../../widgets/common/custom_app_bar.dart';

class LoginScreen extends GetView<AuthController> {
  const LoginScreen({Key? key}) : super(key: key);

  static const String routeName = '/login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const CustomAppBar(),
      body: Container(
          constraints: const BoxConstraints(maxWidth: kTabletChangePoint),
          padding: const EdgeInsets.symmetric(horizontal: 30),
          alignment: Alignment.center,
          decoration: BoxDecoration(gradient: mainGradient(context)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/Picture1.png'),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 60),
                child: Text(
                  'You can signIn by social auth like google account auth and it provides your account picture and username',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: kOnSurfaceTextColor, fontWeight: FontWeight.bold),
                ),
              ),
              MainButton(
                onTap: () {
                  controller.siginInWithGoogle();
                },
                color: Colors.white,
                child: Stack(
                  children: [
                    Center(
                      child: Text(
                        'Sign in  with google',
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
