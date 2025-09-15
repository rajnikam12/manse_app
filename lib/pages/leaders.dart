import 'package:flutter/material.dart';
import 'package:manse_app/pages/widgets/custom_card.dart';

class LeadersPage extends StatelessWidget {
  const LeadersPage({super.key});

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
                  'Our Leaders : ',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                SizedBox(height: 10),
                CustomCard(),
                CustomCard(),
                CustomCard(),
                CustomCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
