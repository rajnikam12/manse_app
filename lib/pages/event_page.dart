import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manse_app/pages/detail_page.dart';
import 'package:manse_app/pages/widgets/event_card.dart';

class EventPage extends StatelessWidget {
  const EventPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30),
                Text(
                  'Events : ',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                SizedBox(height: 10),
                EventCard(
                  imagePath:
                      'https://mnsadhikrut.org/en/wp-content/uploads/2020/08/marathi-chitrapat.jpg',
                  title: 'Flutter Meetup 2025',
                  dateTime: 'Sep 20, 2025 | 6:00 PM',
                  location: 'Mumbai, India',
                  description:
                      'Join us for an exciting meetup to learn Flutter 3.24 featr an exciting meetup to learn Flutter 3.24 featurer an exciting meetup to learn Flutter 3.24 featurer an exciting meetup to learn Flutter 3.24 featureures.',
                ),
                EventCard(
                  imagePath:
                      'https://mnsadhikrut.org/en/wp-content/uploads/2021/08/815130-raj-thackeray-dna-05.jpg',
                  title: 'Flutter Meetup 2025',
                  dateTime: 'Sep 20, 2025 | 6:00 PM',
                  location: 'Mumbai, India',
                  description:
                      'Join us for an exciting meetup to learn Flutter 3.24 featr an exciting meetup to learn Flutter 3.24 featurer an exciting meetup to learn Flutter 3.24 featurer an exciting meetup to learn Flutter 3.24 featureures.',
                ),
                EventCard(
                  imagePath:
                      'http://mnsadhikrut.org/wp-content/uploads/2021/07/mahamorcha-thumb.jpg',
                  title: 'Flutter Meetup 2025',
                  dateTime: 'Sep 20, 2025 | 6:00 PM',
                  location: 'Mumbai, India',
                  description:
                      'Join us for an exciting meetup to learn Flutter 3.24 featr an exciting meetup to learn Flutter 3.24 featurer an exciting meetup to learn Flutter 3.24 featurer an exciting meetup to learn Flutter 3.24 featureures.',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
