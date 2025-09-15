import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manse_app/pages/event_page.dart';
import 'package:manse_app/pages/form.dart';
import 'package:manse_app/pages/home_page.dart';
import 'package:manse_app/pages/leaders.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final NavigationController controller = Get.put(NavigationController());

    return Obx(
      () => Scaffold(
        backgroundColor: Colors.grey.shade300,

        body: controller.screens[controller.selectedIndex.value],
        bottomNavigationBar: CurvedNavigationBar(
          index: controller.selectedIndex.value,
          backgroundColor: Colors.transparent,
          color: Colors.deepOrange,

          animationDuration: Duration(milliseconds: 300),

          items: const <Widget>[
            Icon(Icons.home, color: Colors.white),
            Icon(Icons.group, color: Colors.white),
            Icon(Icons.mail, color: Colors.white),
            Icon(Icons.person, color: Colors.white),
          ],
          onTap: (index) {
            controller.selectedIndex.value = index;
          },
        ),
      ),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final List<Widget> screens = [
    HomePage(), // Home Screen
    EventPage(), // Favorite Screen
    ContactFormPage(), // Search Screen
    LeadersPage(),
  ];
}
