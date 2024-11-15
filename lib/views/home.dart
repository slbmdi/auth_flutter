import 'package:auth_flutter/controller/auth_controller.dart';
import 'package:auth_flutter/views/layouts/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Get.put(AuthController());
    return SafeArea(
        child: Scaffold(
      appBar: const AppBarCustom(title: "صفحه اصلی"),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
          future: auth.me(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var user = snapshot.data;
              return Center(
                child: Column(
                  children: [
                    Text(user!.firstName),
                    Text(user.lastName),
                    Text(user.mobile),
                    ElevatedButton.icon(
                      onPressed: () async {
                        await auth.logout();
                        Get.offAllNamed('/login');
                      },
                      icon: const Icon(Icons.logout),
                      label: const Text('خارج شویم'),
                    )
                  ],
                ),
              );
            }

            return const Center(
              child: Icon(Icons.refresh),
            );
          },
        ),
      ),
    ));
  }
}
