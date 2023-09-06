import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/session_manager.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  var isPasswordHidden = true.obs;

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  RxBool obscurePassword = true.obs;
  RxString emailError = ''.obs;
  RxString passwordError = ''.obs;

  @override
  void onInit() {
    super.onInit();
    emailController.text = '';
    passwordController.text = '';
  }



  Future<void> login() async {
    emailError.value = validateEmail(emailController.text);
    passwordError.value = validatePassword(passwordController.text);

    if (emailError.value.isEmpty && passwordError.value.isEmpty) {
      try {
        final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        final User? user = userCredential.user;
        if (user != null) {
          Get.snackbar(
            'Login Successful',
            'Email: ${user.email}',
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
          final SessionService sessionService = Get.find();
          sessionService.login();
          Get.toNamed('/dashboard');
        } else {

        }
      } catch (e) {
        if (e is FirebaseAuthException) {
          if (e.code == 'user-not-found') {
            Get.snackbar(
              'Login Error',
              'Your email is not registered. Please register your account.',
              backgroundColor: Colors.red,
              colorText: Colors.white,
            );
          } else {
            print(e);
          }
        }
      }
    } else {
      Get.snackbar(
        'Login Error',
        '${emailError.value}\n${passwordError.value}',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }



  String validateEmail(String value) {
    if (value.isEmpty) {
      return 'Email is required';
    } else if (!GetUtils.isEmail(value)) {
      return 'Please enter a valid email';
    }
    return '';
  }

  String validatePassword(String value) {
    if (value.isEmpty) {
      return 'Password is required';
    } else if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return '';
  }



}
