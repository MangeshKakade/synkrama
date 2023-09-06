import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/profile_controlller.dart';
import '../../utils/session_manager.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileState();
}

class _ProfileState extends State<ProfileScreen> {
  final ProfileController controller = Get.put(ProfileController());

  double yOffset = 0.0;

  final SessionService sessionService = Get.find();




  @override
  Widget build(BuildContext context) {
    if (!sessionService.isLoggedIn.value) {
      Future.delayed(Duration.zero, () {
        Get.offNamed('/login');
      });
      return SizedBox.shrink();
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 70),
            Obx(() {
              return CircleAvatar(
                backgroundImage: AssetImage(controller.profileImage.value),
                backgroundColor: Colors.blueGrey,
                radius: 60,
              );
            }),
            SizedBox(height: 20),
            Obx(() {
              return Text(
                'Hi, ${controller.userName}',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              );
            }),
            SizedBox(height: 10),
            Obx(() {
              return controller.vip.value
                  ? Container(
                decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.star, color: Colors.white),
                    SizedBox(width: 5),
                    Text(
                      'VIP',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ],
                ),
              )
                  : SizedBox.shrink();
            }),
            SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Divider(thickness: 1.0, color: Colors.grey),
            ),
            buildOptionRow(Icons.track_changes, 'Tracking Order'),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Divider(thickness: 1.0, color: Colors.grey),
            ),
            buildOptionRow(Icons.confirmation_number, 'Coupons',),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Divider(thickness: 1.0, color: Colors.grey),
            ),
            buildOptionRow(Icons.settings, 'Settings',),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Divider(thickness: 1.0, color: Colors.grey),
            ),
            buildOptionRow(Icons.security, 'Help & Security',),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Divider(thickness: 1.0, color: Colors.grey),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.blueGrey,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.logout,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 10),
                  TextButton(
                    onPressed: () {
                      sessionService.logout();
                      Get.offNamed('/login');
                    },
                    child: Text(
                      'Logout',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),


            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Divider(thickness: 1.0, color: Colors.grey),
            ),
            SizedBox(height: 80,),
          ],
        ),
      ),
    );
  }

  Widget buildOptionRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.blueGrey,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: () {

              },
              icon: Icon(
                icon,
                color: Colors.white,
              ),
            ),
          ),
          TextButton(
            onPressed: () {

            },
            child: Text(
              text,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
