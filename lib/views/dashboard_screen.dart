import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import '../controllers/dashboard_controller.dart';
import 'DashboardScreens/home_screen.dart';
import 'DashboardScreens/order_screen.dart';
import 'DashboardScreens/profile_screen.dart';

class DashboardScreen extends GetView<DashboardController> {
  final List<Widget> _screens = [
    HomeScreen(),
    OrderScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: [
          _buildBottomNavigationBarItem(Icons.home, 'Home', 0),
          _buildBottomNavigationBarItem(Icons.shopping_cart, 'Order', 1),
          _buildBottomNavigationBarItem(Icons.person, 'Profile', 2),
        ],
        currentIndex: controller.currentIndex.value,
        onTap: controller.changeTabIndex,
        activeColor: Colors.deepOrange,
        inactiveColor: Colors.grey,
      ),
      tabBuilder: (context, index) {
        return CupertinoTabView(
          builder: (context) {
            return _screens[index];
          },
        );
      },
    );
  }

  BottomNavigationBarItem _buildBottomNavigationBarItem(
      IconData iconData, String label, int index) {
    return BottomNavigationBarItem(
      icon: ValueListenableBuilder<int>(
        valueListenable: controller.currentIndexNotifier,
        builder: (context, currentIndex, child) {
          final isSelected = currentIndex == index;
          final scaleFactor = isSelected ? 1.2 : 0.8;
          return Transform.scale(
            scale: scaleFactor,
            child: Icon(iconData),
          );
        },
      ),
      label: label,
    );
  }
}
