import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:synkrama/utils/session_manager.dart';
import 'controllers/dashboard_controller.dart';
import 'controllers/login_controller.dart';
import 'controllers/signup_controller.dart';
import 'firebase_options.dart';
import 'routes.dart';

Future<void> main()  async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      getPages: routes,
      initialBinding: BindingsBuilder(() {
        Get.put(LoginController());
        Get.put(SignUpController());
        Get.put(DashboardController());
        Get.put(SessionService());
      }),
    );
  }
}

