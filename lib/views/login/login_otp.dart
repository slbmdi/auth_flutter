import "dart:async";
import "package:auth_flutter/controller/auth_controller.dart";
import "package:auth_flutter/helper/constance.dart";
import "package:auth_flutter/views/layouts/widgets.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:pin_code_fields/pin_code_fields.dart";

class LoginOtp extends StatelessWidget {
  const LoginOtp({super.key});
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final authController = Get.find<AuthController>();
    return SafeArea(
        child: Scaffold(
      appBar: const AppBarCustom(title: "دریافت کد"),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Text("کد را وارد کنید"),
              Container(
                  padding: const EdgeInsets.all(8),
                  child: OtpCode(formKey: formKey)),
              // ignore: prefer_const_constructors
              SizedBox(
                width: double.infinity,
                child: const Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("کد ارسال نشده است؟"),
                      SizedBox(
                        width: 5,
                      ),
                      CounterDown(),
                    ],
                  ),
                ),
              ),
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () async {
                        var res = await authController
                            .checkCode(OtpCode.textEditingController.text);
                        if (res == true) {
                          Get.offAllNamed('/home');
                        } else if (res == 'register') {
                          Get.toNamed('/login/register');
                        } else {
                          Get.snackbar('خطا', res, backgroundColor: Colors.red);
                        }
                      },
                      child: const Text('مرحله بعد')))
            ],
          ),
        ),
      ),
    ));
  }
}

class OtpCode extends StatefulWidget {
  const OtpCode({super.key, required this.formKey});
  final GlobalKey formKey;
  static TextEditingController textEditingController = TextEditingController();

  @override
  State<OtpCode> createState() => _OtpCodeState();
}

class _OtpCodeState extends State<OtpCode> {
  late StreamController<ErrorAnimationType> errorController;

  bool hasError = false;
  String currentText = "";

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: PinCodeTextField(
          autoDisposeControllers: false,
          appContext: context,
          pastedTextStyle: TextStyle(
            color: ConstColor.backgroundAppBar,
            fontWeight: FontWeight.bold,
          ),
          length: 4,
          blinkWhenObscuring: true,
          animationType: AnimationType.fade,
          pinTheme: PinTheme(
            fieldOuterPadding: EdgeInsets.zero,
            shape: PinCodeFieldShape.box,
            borderRadius: BorderRadius.circular(5),
            fieldHeight: 50,
            fieldWidth: 40,
            activeFillColor: Colors.white,
            activeColor: Colors.black,
            inactiveColor: Colors.black,
            inactiveFillColor: Colors.white,
            selectedFillColor: Colors.white,
          ),
          cursorColor: Colors.black,
          animationDuration: const Duration(milliseconds: 300),
          enableActiveFill: true,
          errorAnimationController: errorController,
          controller: OtpCode.textEditingController,
          keyboardType: TextInputType.number,
          boxShadows: const [
            BoxShadow(
              offset: Offset(0, 1),
              color: Colors.black12,
              blurRadius: 10,
            )
          ],
          onCompleted: (v) async {
            final authController = Get.find<AuthController>();

            var res = await authController
                .checkCode(OtpCode.textEditingController.text);
            if (res == true) {
              Get.offAllNamed('/home');
            } else if (res == 'register') {
              Get.toNamed('/login/register');
            } else {
              Get.snackbar('خطا', res, backgroundColor: Colors.red);
            }
          },
          // onTap: () {
          //   print("Pressed");
          // },
          onChanged: (value) {
            debugPrint(value);
            setState(() {
              currentText = value;
            });
          },
          beforeTextPaste: (text) {
            debugPrint("Allowing to paste $text");
            //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
            //but you can show anything you want here, like your pop up saying wrong paste format or etc
            return true;
          }),
    );
  }
}

class CounterDown extends StatefulWidget {
  const CounterDown({super.key});

  @override
  State<CounterDown> createState() => _CounterDownState();
}

class _CounterDownState extends State<CounterDown> {
  late Timer timer;
  String text = "";
  int addMin = 1;
  DateTime counterDown = DateTime.now();
  bool isSend = false;

  @override
  void initState() {
    runCounterDown();
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () async {
          if (isSend) {
            final authController = Get.find<AuthController>();
            await authController.login(authController.mobile);
            counterDown = DateTime.now();
            runCounterDown();
          }
        },
        child: Text(text));
  }

  void runCounterDown() {
    counterDown = counterDown.add(Duration(minutes: addMin));
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      var now = DateTime.now();

      var distance = counterDown.difference(now);

      var min = distance.inMinutes;
      var sec = distance.inSeconds % 60;

      String secondText = "$sec";
      String minText = "0$min";
      if (sec < 10) {
        secondText = "0$sec";
      }

      if (min == 0 && sec == 0) {
        setState(() {
          text = "برای ارسال مجدد کلیک کنید";
          isSend = true;
          timer.cancel();
        });

        return;
      }

      setState(() {
        text = "$minText:$secondText";
      });
    });
  }
}
