import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manse_app/pages/detail_page.dart';
import 'package:manse_app/pages/home_page.dart';
import 'package:manse_app/pages/widgets/animation.dart';

class EventCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String dateTime;
  final String location;
  final String? description;

  const EventCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.dateTime,
    required this.location,
    this.description,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(
          () => DetailPage(
            imagePath: imagePath,
            title: title,
            description: description,
            dateTime: dateTime,
            location: location,
          ),
          transition: Transition.rightToLeftWithFade,
          duration: Duration(milliseconds: 500),
        );
      },
      child: SlideAnimation(
        from: SlideFrom.bottom,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 12,
                offset: Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image with gradient overlay
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
                child: Stack(
                  children: [
                    Image.network(
                      imagePath,
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black.withOpacity(0.5),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 12,
                      left: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.deepOrange,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Text(
                          dateTime,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          size: 16,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            location,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    if (description != null) ...[
                      const SizedBox(height: 12),
                      Text(
                        description!,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontSize: 12,
                          color: Colors.black54,
                          fontWeight: FontWeight.w800,
                        ),
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
