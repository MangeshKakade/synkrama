import 'package:get/get.dart';
import 'package:synkrama/views/dashboard_screen.dart';
import 'package:synkrama/views/login_screen.dart';
import 'package:synkrama/views/signup_screen.dart';
import 'package:synkrama/views/splash_screen.dart';

var routes = [
  GetPage(name: '/', page: () => SplashScreen()),
  GetPage(name: '/login', page: () => LoginScreen()),
  GetPage(name: '/signup', page: () => SignUpScreen()),
  GetPage(name: '/dashboard', page: () => DashboardScreen()),

];
