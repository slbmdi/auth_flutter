import 'package:auth_flutter/controller/auth_controller.dart';
import 'package:auth_flutter/views/layouts/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Register extends StatefulWidget {
  const Register({super.key});
  static TextEditingController firstName = TextEditingController();
  static TextEditingController lastName = TextEditingController();
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool obscureText = true;
  final authController = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: const AppBarCustom(
        title: "مشخصات کاربر",
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: Register.firstName,
              decoration: const InputDecoration(
                hintText: "نام خود را وارد کنید",
                hintStyle: TextStyle(fontSize: 13),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: Register.lastName,
              decoration: const InputDecoration(
                hintText: "نام خانوادگی خود را وارد کنید",
                hintStyle: TextStyle(fontSize: 13),
              ),
            ),

            // TextFormField(
            //   decoration: InputDecoration(
            //       hintText: "رمز عبور خود وارد کنید",
            //       hintStyle: const TextStyle(fontSize: 13),
            //       suffixIcon: GestureDetector(
            //         onTap: () {
            //           setState(() {
            //             obscureText = !obscureText;
            //           });
            //         },
            //         child: Icon(
            //             obscureText ? Icons.visibility : Icons.visibility_off),
            //       )),
            //   obscureText: obscureText,
            //   obscuringCharacter: '*',
            // ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () async {
                      var res = await authController.register(
                          firstName: Register.firstName.text,
                          lastName: Register.lastName.text);
                      if (res == true) {
                        Get.offAllNamed('/home');
                      } else {
                        Get.snackbar('خطا', res, backgroundColor: Colors.red);
                      }
                    },
                    child: const Text('ثبت اطلاعات')))
          ],
        ),
      ),
    ));
  }
}
