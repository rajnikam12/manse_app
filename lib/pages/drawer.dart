import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manse_app/pages/drawer_pages.dart/journey_screen.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              SizedBox(height: 40),
              DrawerSection(
                title: 'Our Journey',
                onTap: () {
                  Get.to(() => TimelineScreen(), transition: Transition.fadeIn);
                },
              ),
              DrawerSection(title: ''),
              DrawerSection(title: ''),
            ],
          ),
        ),
      ),
    );
  }
}

class DrawerSection extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  const DrawerSection({super.key, required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.all(5),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.deepOrange,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.headlineLarge?.copyWith(fontSize: 20),
            ),
            Icon(Icons.arrow_forward_ios_rounded, color: Colors.black),
          ],
        ),
      ),
    );
  }
}
