import 'package:auth_flutter/controller/auth_controller.dart';
import 'package:auth_flutter/views/layouts/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Login extends StatelessWidget {
  const Login({super.key});
  static TextEditingController mobileController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authController = Get.put(AuthController());

    //!

    return SafeArea(
        child: Scaffold(
      appBar: const AppBarCustom(
        title: "ورود کاربران",
      ),

      //!
      body: Padding(
        padding: const EdgeInsets.all(11.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                'assets/images/logo.png',
                width: 100,
              ),
            ),
            //! 36.37
            const Text('لطفا شماره خود را وارد کنید'),
            const Text('پیامک به این شماره ارسال خواهد شد'),
            const SizedBox(
              height: 10,
            ),
            //!
            TextFormField(
              controller: mobileController,
              decoration: const InputDecoration(
                hintText: "شماره موبایل وارد کنید",
                hintStyle: TextStyle(fontSize: 13),
              ),
            ),
            //!43
            const SizedBox(
              height: 10,
            ),
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () async {
                      var res =
                          await authController.login(mobileController.text);
                      if (res == true) {
                        Get.toNamed('/login/otp');
                      } else {
                        Get.snackbar('خطا', res, backgroundColor: Colors.red);
                      }
                    },
                    child: const Text('ارسال ')))
          ],
        ),
      ),
    ));
  }
}
