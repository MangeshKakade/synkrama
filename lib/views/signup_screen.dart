import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../controllers/signup_controller.dart';

class SignUpScreen extends GetView<SignUpController> {
  final RxBool _acceptedTerms = false.obs;

  final GlobalKey<FormState> nameFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> emailFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> passwordFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> confirmPasswordFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Lottie.asset(
                'assets/lottie/register.json',
                width: 200,
                height: 200,
                fit: BoxFit.contain,
              ),
              SizedBox(height: 40),
              Form(
                key: nameFormKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: TextFormField(
                  controller: controller.nameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    labelStyle: TextStyle(fontFamily: 'Poppins'),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Name is required';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 20),
              Form(
                key: emailFormKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: TextFormField(
                  controller: controller.emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(fontFamily: 'Poppins'),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Email is required';
                    }
                    if (!GetUtils.isEmail(value)) {
                      return 'Enter a valid email address';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 20),
              Form(
                key: passwordFormKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: TextFormField(
                  controller: controller.passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(fontFamily: 'Poppins'),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Password is required';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 20),
              Form(
                key: confirmPasswordFormKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: TextFormField(
                  controller: controller.confirmPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    labelStyle: TextStyle(fontFamily: 'Poppins'),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Confirm Password is required';
                    }
                    if (value != controller.passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
              ),
              Obx(
                    () => CheckboxListTile(
                  title: Text(
                    'I accept the Terms and Conditions',
                    style: TextStyle(fontSize: 13, fontFamily: 'Poppins'),
                  ),
                  value: _acceptedTerms.value,
                  onChanged: (value) {
                    _acceptedTerms.value = value!;
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_acceptedTerms.value &&
                        nameFormKey.currentState!.validate() &&
                        emailFormKey.currentState!.validate() &&
                        passwordFormKey.currentState!.validate() &&
                        confirmPasswordFormKey.currentState!.validate()) {
                      try {
                        final UserCredential userCredential =
                        await _auth.createUserWithEmailAndPassword(
                          email: controller.emailController.text,
                          password: controller.passwordController.text,
                        );
                        final User? user = userCredential.user;
                        if (user != null) {
                          Get.snackbar(
                            'Registration Successful',
                            'You have successfully registered your account.',
                            backgroundColor: Colors.green,
                            colorText: Colors.white,
                          );
                          Get.toNamed('/login');
                        } else {

                        }
                      } catch (e) {
                        print(e);
                      }
                    } else if (!_acceptedTerms.value) {
                      Get.defaultDialog(
                        title: 'Accept Terms',
                        middleTextStyle: TextStyle(fontFamily: 'Poppins'),
                        content: Text(
                          'Please accept the Terms and Conditions before signing up.',
                          style: TextStyle(fontFamily: 'Poppins'),
                        ),
                        confirm: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueGrey,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onPressed: () {
                            Get.back();
                          },
                          child: Text('OK',
                              style: TextStyle(fontFamily: 'Poppins')),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueGrey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontFamily: 'Poppins'),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Get.toNamed('/login');
                },
                child: Text(
                  'Already have an account? Log in',
                  style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 16,
                      fontFamily: 'Poppins'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
