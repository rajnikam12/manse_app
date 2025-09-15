import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

// Constants for theming and layout
const _primaryColor = Colors.deepOrange; // Saffron
const _accentColor = Color(0xFF1E3A8A); // Deep Blue
const _goldColor = Colors.amber; // Gold
const _backgroundGradient = LinearGradient(
  colors: [_primaryColor, Colors.deepOrangeAccent],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
);
const _cardColor = Colors.white;
const _shadowColor = Colors.black26;
const _timelineItemWidth = 120.0;
const _timelineItemHeight = 150.0;
const _imageHeightFraction = 0.3;

class TimelineScreen extends StatefulWidget {
  const TimelineScreen({super.key});

  @override
  State<TimelineScreen> createState() => _TimelineScreenState();
}

class _TimelineScreenState extends State<TimelineScreen>
    with SingleTickerProviderStateMixin {
  final List<HistoricalMilestone> _milestones = const [
    HistoricalMilestone(
      year: 1630,
      title: 'Birth of Shivaji Maharaj',
      description:
          'Born on February 19, 1630, at Shivneri Fort to Shahaji Bhonsle and Jijabai.',
      icon: Icons.star,
      color: Colors.orange,
      imagePath: 'ets/images/shivneri_fort.jpgass',
    ),
    HistoricalMilestone(
      year: 1645,
      title: 'Capture of Torna Fort',
      description:
          'Captured Torna Fort at age 16, marking the beginning of his conquests.',
      icon: Icons.castle,
      color: Colors.red,
      imagePath: 'assets/images/torna_fort.jpg',
    ),
    HistoricalMilestone(
      year: 1659,
      title: 'Battle of Pratapgad',
      description:
          'Defeated Afzal Khan in a historic battle, strengthening Maratha power.',
      icon: Icons.shield,
      color: Colors.blue,
      imagePath: 'assets/images/pratapgad_battle.jpg',
    ),
    HistoricalMilestone(
      year: 1664,
      title: 'Sack of Surat',
      description:
          'Raided the Mughal port city of Surat, showcasing Maratha naval strength.',
      icon: Icons.directions_boat,
      color: Colors.teal,
      imagePath: 'assets/images/surat_raid.jpg',
    ),
    HistoricalMilestone(
      year: 1674,
      title: 'Coronation as Chhatrapati',
      description:
          'Crowned as Chhatrapati at Raigad Fort, establishing the Maratha Empire.',
      icon: Icons.account_balance,
      color: Colors.purple,
      imagePath: 'assets/images/raigad_coronation.jpg',
    ),
    HistoricalMilestone(
      year: 1680,
      title: 'Passing of Shivaji Maharaj',
      description:
          'Passed away on April 3, 1680, leaving a legacy of valor and governance.',
      icon: Icons.history,
      color: Colors.grey,
      imagePath: 'assets/images/shivaji_memorial.jpg',
    ),
  ];

  int _selectedYear = 1674;
  late ScrollController _timelineController;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _timelineController = ScrollController();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  void dispose() {
    _timelineController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  /// Cycles to the next milestone and scrolls the timeline to center it.
  void _nextMilestone() {
    setState(() {
      final currentIndex = _milestones.indexWhere(
        (m) => m.year == _selectedYear,
      );
      final nextIndex = (currentIndex + 1) % _milestones.length;
      _selectedYear = _milestones[nextIndex].year;

      // Calculate the offset to center the selected item
      final offset =
          nextIndex * _timelineItemWidth -
          (MediaQuery.of(context).size.width / 2 - _timelineItemWidth / 2);

      _timelineController.animateTo(
        offset.clamp(0.0, _timelineController.position.maxScrollExtent),
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );

      // Restart the animation
      _animationController.reset();
      _animationController.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        primaryColor: _primaryColor,
        scaffoldBackgroundColor: Colors.transparent,
        textTheme: const TextTheme(
          headlineSmall: TextStyle(
            fontFamily: 'Lora',
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
          bodyMedium: TextStyle(fontFamily: 'Lora', color: Colors.grey),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: _goldColor,
          foregroundColor: Colors.white,
        ),
      ),
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(gradient: _backgroundGradient),
          child: SafeArea(
            child: _milestones.isEmpty
                ? const Center(
                    child: Text(
                      'No milestones available',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                : CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: _TimelineSection(
                          milestones: _milestones,
                          selectedYear: _selectedYear,
                          controller: _timelineController,
                          onYearSelected: (year) {
                            setState(() {
                              _selectedYear = year;
                              _animationController.reset();
                              _animationController.forward();
                            });
                          },
                        ),
                      ),
                      SliverFillRemaining(
                        child: _HistorySection(
                          milestones: _milestones,
                          selectedYear: _selectedYear,
                          animationController: _animationController,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
        floatingActionButton: Semantics(
          button: true,
          label: 'Next Milestone in Shivaji Maharaj\'s History',
          child: FloatingActionButton(
            onPressed: _nextMilestone,
            tooltip: 'Next Milestone',
            child: const Icon(Icons.arrow_forward),
          ).animate().scale(duration: 200.ms, curve: Curves.bounceOut),
        ),
      ),
    );
  }
}

class _TimelineSection extends StatelessWidget {
  final List<HistoricalMilestone> milestones;
  final int selectedYear;
  final ScrollController controller;
  final ValueChanged<int> onYearSelected;

  const _TimelineSection({
    required this.milestones,
    required this.selectedYear,
    required this.controller,
    required this.onYearSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      decoration: BoxDecoration(
        color: _cardColor,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: _shadowColor.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          const Text(
            'Maratha Legacy Through Time',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: _primaryColor,
            ),
          ).animate().fadeIn(duration: 600.ms),
          const SizedBox(height: 16),
          SizedBox(
            height: _timelineItemHeight,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              controller: controller,
              itemCount: milestones.length,
              cacheExtent: 1000,
              itemBuilder: (context, index) {
                final milestone = milestones[index];
                final isSelected = milestone.year == selectedYear;
                return _TimelineItem(
                  key: ValueKey(milestone.year),
                  milestone: milestone,
                  isSelected: isSelected,
                  index: index,
                  onTap: () => onYearSelected(milestone.year),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _TimelineItem extends StatelessWidget {
  final HistoricalMilestone milestone;
  final bool isSelected;
  final int index;
  final VoidCallback onTap;

  const _TimelineItem({
    super.key,
    required this.milestone,
    required this.isSelected,
    required this.index,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: 'Milestone: ${milestone.title} in ${milestone.year}',
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: _timelineItemWidth,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 4,
                height: 20,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.grey[300]!, milestone.color],
                  ),
                ),
              ),
              Hero(
                tag: 'milestone-${milestone.year}',
                child:
                    Material(
                          color: Colors.transparent,
                          child: Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? milestone.color
                                  : Colors.white,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: milestone.color,
                                width: 3,
                              ),
                              boxShadow: [
                                if (isSelected)
                                  BoxShadow(
                                    color: milestone.color.withOpacity(0.6),
                                    blurRadius: 16,
                                    spreadRadius: 2,
                                  ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                milestone.year.toString(),
                                style: TextStyle(
                                  color: isSelected
                                      ? Colors.white
                                      : milestone.color,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        )
                        .animate()
                        .scale(duration: 300.ms, curve: Curves.easeInOut)
                        .then(),
              ),
              Expanded(
                child: Container(
                  width: 4,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [milestone.color, Colors.grey[300]!],
                    ),
                  ),
                ),
              ),
              if (isSelected)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    milestone.title,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: milestone.color,
                    ),
                  ),
                ).animate().fadeIn(duration: 400.ms),
            ],
          ),
        ),
      ),
    );
  }
}

class _HistorySection extends StatelessWidget {
  final List<HistoricalMilestone> milestones;
  final int selectedYear;
  final AnimationController animationController;

  const _HistorySection({
    required this.milestones,
    required this.selectedYear,
    required this.animationController,
  });

  @override
  Widget build(BuildContext context) {
    final selectedMilestone = milestones.firstWhere(
      (m) => m.year == selectedYear,
      orElse: () => milestones.first,
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        final imageHeight = constraints.maxHeight * _imageHeightFraction;

        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: AnimatedBuilder(
            animation: animationController,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(0, 20 * (1 - animationController.value)),
                child: Opacity(
                  opacity: animationController.value,
                  child: child,
                ),
              );
            },
            child: Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              color: _cardColor.withOpacity(0.85),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: _goldColor.withOpacity(0.3),
                    width: 2,
                  ),
                ),
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Hero(
                          tag: 'milestone-${selectedMilestone.year}',
                          child: Container(
                            width: 64,
                            height: 64,
                            decoration: BoxDecoration(
                              color: selectedMilestone.color.withOpacity(0.2),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: selectedMilestone.color,
                                width: 2,
                              ),
                            ),
                            child: Icon(
                              selectedMilestone.icon,
                              color: selectedMilestone.color,
                              size: 32,
                            ),
                          ).animate().scale(delay: 100.ms, duration: 300.ms),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                selectedMilestone.year.toString(),
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey,
                                ),
                              ).animate().fadeIn(
                                delay: 200.ms,
                                duration: 400.ms,
                              ),
                              Text(
                                selectedMilestone.title,
                                style: const TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w700,
                                ),
                              ).animate().fadeIn(
                                delay: 300.ms,
                                duration: 400.ms,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Semantics(
                      label: 'Image for ${selectedMilestone.title}',
                      child: FractionallySizedBox(
                        widthFactor: 1.0,
                        child:
                            Container(
                                  height: imageHeight.clamp(150.0, 300.0),
                                  decoration: BoxDecoration(
                                    color: selectedMilestone.color.withOpacity(
                                      0.15,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: [
                                      BoxShadow(
                                        color: _shadowColor.withOpacity(0.3),
                                        blurRadius: 10,
                                        offset: const Offset(0, 5),
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Image: ${selectedMilestone.imagePath}',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: selectedMilestone.color,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                )
                                .animate()
                                .fadeIn(delay: 400.ms, duration: 500.ms)
                                .moveY(
                                  begin: 20,
                                  end: 0,
                                  curve: Curves.easeOut,
                                ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Semantics(
                      label: 'Description of ${selectedMilestone.title}',
                      child: Text(
                        selectedMilestone.description,
                        style: const TextStyle(
                          fontSize: 16,
                          height: 1.5,
                          color: Colors.grey,
                        ),
                      ).animate().fadeIn(delay: 500.ms, duration: 500.ms),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class HistoricalMilestone {
  final int year;
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final String imagePath;

  const HistoricalMilestone({
    required this.year,
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.imagePath,
  });
}
