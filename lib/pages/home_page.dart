import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:manse_app/constants/assets.dart';
import 'package:manse_app/pages/drawer.dart';
import 'package:manse_app/pages/widgets/custom_webview.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final bannerImages = [
      Assets.assetsImagesBanner,
      Assets.assetsImagesBanner, // add more image paths
      Assets.assetsImagesBanner,
    ];

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade300,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leadingWidth: 80,
          leading: GestureDetector(
            onTap: () {
              Get.to(
                () => CustomDrawer(),
                transition: Transition.leftToRightWithFade,
              );
            },
            child: Icon(
              Icons.menu_open_outlined,
              color: Colors.black,
              size: 40,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Slider(bannerImages: bannerImages),
              SizedBox(height: 20),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CustomWebView(
                          url: "mnsadhikrut.org/en/independence-day-message/",
                          title: "Letters",
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    height: 160,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.orange.shade300,
                          Colors.orange.shade600,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.mail_outline,
                              size: 36,
                              color: Colors.black,
                            ),
                            SizedBox(width: 12),
                            Text(
                              "Letters",
                              style: Theme.of(context).textTheme.headlineLarge
                                  ?.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12),
                        Text(
                          "Access your letters and important messages easily.",
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(color: Colors.black87, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // ElevatedButton(
              //   onPressed: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //         builder: (context) => const CustomWebView(
              //           url: "mnsadhikrut.org/en/independence-day-message/",
              //           title: "Letters",
              //         ),
              //       ),
              //     );
              //   },
              //   child: Container(
              //     decoration: BoxDecoration(color: Colors.deepOrangeAccent),
              //     child: Text("data"),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class Slider extends StatelessWidget {
  const Slider({super.key, required this.bannerImages});

  final List<String> bannerImages;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: bannerImages.length,
      itemBuilder: (context, index, realIndex) {
        final imagePath = bannerImages[index];
        return Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
            ),
          ),
          // child: Align(
          //   alignment: Alignment.bottomCenter,
          //   child: Container(
          //     padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          //     margin: const EdgeInsets.all(12),
          //     decoration: BoxDecoration(
          //       color: Colors.black.withOpacity(0.4),
          //       borderRadius: BorderRadius.circular(12),
          //     ),
          //     child: Text(
          //       "Banner ${index + 1}",
          //       style: const TextStyle(
          //         color: Colors.white,
          //         fontSize: 16,
          //         fontWeight: FontWeight.w600,
          //       ),
          //     ),
          //   ),
          // ),
        );
      },
      options: CarouselOptions(
        height: 180,
        enlargeCenterPage: true,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        viewportFraction: 1, // show next/previous peek
      ),
    );
  }
}
