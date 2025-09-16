import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math' as math;

// Modern Design System
class AppTheme {
  static const primaryColor = Color(0xFFFF6B35);
  static const secondaryColor = Color(0xFF004E89);
  static const accentColor = Color(0xFFFFB627);
  static const surfaceColor = Color(0xFFFAFAFA);
  static const backgroundColor = Color(0xFFF5F5F7);
  static const cardColor = Colors.white;
  static const textPrimary = Color(0xFF1A1A1A);
  static const textSecondary = Color(0xFF666666);
  static const textTertiary = Color(0xFF999999);
  static const dividerColor = Color(0xFFE5E5EA);

  // Gradients
  static const primaryGradient = LinearGradient(
    colors: [Color(0xFFFF6B35), Color(0xFFFF8E53)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const successGradient = LinearGradient(
    colors: [Color(0xFF00C896), Color(0xFF00E5A0)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const errorGradient = LinearGradient(
    colors: [Color(0xFFFF4757), Color(0xFFFF6B7A)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const warningGradient = LinearGradient(
    colors: [Color(0xFFFFB627), Color(0xFFFFC940)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Shadows
  static const cardShadow = [
    BoxShadow(color: Color(0x0A000000), blurRadius: 12, offset: Offset(0, 4)),
    BoxShadow(color: Color(0x08000000), blurRadius: 6, offset: Offset(0, 2)),
  ];

  static const elevatedShadow = [
    BoxShadow(color: Color(0x12000000), blurRadius: 24, offset: Offset(0, 8)),
    BoxShadow(color: Color(0x0A000000), blurRadius: 12, offset: Offset(0, 4)),
  ];
}

enum TimelineEventType {
  foundation,
  success,
  decline,
  movement,
  policy,
  crisis,
  achievement,
}

class TimelineItem {
  final String year;
  final String title;
  final String description;
  final String detailedDescription;
  final String imagePath;
  final TimelineEventType eventType;
  final IconData icon;
  final List<String> keyPoints;

  const TimelineItem({
    required this.year,
    required this.title,
    required this.description,
    required this.detailedDescription,
    required this.imagePath,
    required this.eventType,
    required this.icon,
    this.keyPoints = const [],
  });

  Color get color {
    switch (eventType) {
      case TimelineEventType.foundation:
        return AppTheme.primaryColor;
      case TimelineEventType.success:
      case TimelineEventType.achievement:
        return const Color(0xFF00C896);
      case TimelineEventType.decline:
      case TimelineEventType.crisis:
        return const Color(0xFFFF4757);
      case TimelineEventType.movement:
        return AppTheme.accentColor;
      case TimelineEventType.policy:
        return AppTheme.secondaryColor;
    }
  }

  LinearGradient get gradient {
    switch (eventType) {
      case TimelineEventType.foundation:
        return AppTheme.primaryGradient;
      case TimelineEventType.success:
      case TimelineEventType.achievement:
        return AppTheme.successGradient;
      case TimelineEventType.decline:
      case TimelineEventType.crisis:
        return AppTheme.errorGradient;
      case TimelineEventType.movement:
      case TimelineEventType.policy:
        return AppTheme.warningGradient;
    }
  }
}

class JourneyScreen extends StatefulWidget {
  const JourneyScreen({super.key});

  @override
  State<JourneyScreen> createState() => _JourneyScreenState();
}

class _JourneyScreenState extends State<JourneyScreen>
    with TickerProviderStateMixin {
  Set<int> expandedItems = {};
  late AnimationController _staggerController;
  late AnimationController _floatingController;
  late ScrollController _scrollController;

  final List<TimelineItem> timelineItems = const [
    TimelineItem(
      year: '2006',
      title: 'Foundation of MNS',
      description: 'Raj Thackeray formed MNS after leaving Shiv Sena',
      detailedDescription:
          'The Maharashtra Navnirman Sena was founded on March 9, 2006, in Mumbai by Raj Thackeray after he left the Shiv Sena party. The split occurred due to ideological differences with his cousin Uddhav Thackeray and his sidelining in major party decisions including distribution of election tickets.',
      imagePath:
          'https://via.placeholder.com/400x250/FF6B35/FFFFFF?text=MNS+Foundation+2006',
      eventType: TimelineEventType.foundation,
      icon: Icons.foundation,
      keyPoints: [
        'March 9, 2006 - Official founding',
        'Split from Shiv Sena',
        'Ideological differences with Uddhav Thackeray',
      ],
    ),
    TimelineItem(
      year: '2008',
      title: 'North Indian Migration Movement',
      description:
          'MNS launched aggressive campaign against North Indian migrants',
      detailedDescription:
          'In 2008, MNS launched a controversial movement against North Indian migrants in Maharashtra, particularly targeting taxi drivers, auto-rickshaw drivers, and other workers from Uttar Pradesh and Bihar. This campaign was based on the "Marathi Manus" ideology.',
      imagePath:
          'https://via.placeholder.com/400x250/FFB627/FFFFFF?text=Migration+Movement+2008',
      eventType: TimelineEventType.movement,
      icon: Icons.people_alt_outlined,
      keyPoints: [
        '"Marathi Manus" ideology',
        'Targeted taxi/auto drivers',
        'Controversial protests',
      ],
    ),
    TimelineItem(
      year: '2009',
      title: 'Electoral Breakthrough',
      description:
          'MNS won 13 assembly seats in Maharashtra Assembly elections',
      detailedDescription:
          'In the 2009 Maharashtra Assembly elections, MNS achieved its best-ever electoral performance by winning 13 seats out of 288, securing approximately 5.7% of the total vote share. This established Raj Thackeray as a significant political force.',
      imagePath:
          'https://via.placeholder.com/400x250/00C896/FFFFFF?text=Electoral+Victory+2009',
      eventType: TimelineEventType.success,
      icon: Icons.how_to_vote_outlined,
      keyPoints: [
        '13 assembly seats won',
        '5.7% vote share',
        'Best electoral performance',
      ],
    ),
    TimelineItem(
      year: '2012',
      title: 'Toll Plaza Agitation',
      description: 'Led massive protests against toll collection',
      detailedDescription:
          'In 2012, MNS led a major agitation against toll collection on highways in Maharashtra. Raj Thackeray and MNS workers organized protests at various toll plazas, arguing that citizens were being unnecessarily taxed for using roads.',
      imagePath:
          'https://via.placeholder.com/400x250/FFB627/FFFFFF?text=Toll+Agitation+2012',
      eventType: TimelineEventType.movement,
      icon: Icons.traffic_outlined,
      keyPoints: [
        'Highway toll protests',
        'Public support gained',
        'Media attention',
      ],
    ),
    TimelineItem(
      year: '2014',
      title: 'Support for Modi & Electoral Decline',
      description:
          'Raj Thackeray supported Narendra Modi but MNS won only 1 seat',
      detailedDescription:
          'In 2014, Raj Thackeray expressed support for Narendra Modi for the post of Prime Minister. However, in the Maharashtra Assembly elections, MNS suffered a major defeat, winning only 1 seat compared to 13 in 2009.',
      imagePath:
          'https://via.placeholder.com/400x250/FF4757/FFFFFF?text=Electoral+Decline+2014',
      eventType: TimelineEventType.decline,
      icon: Icons.trending_down_outlined,
      keyPoints: [
        'Supported Modi for PM',
        'Won only 1 seat',
        'Major electoral defeat',
      ],
    ),
    TimelineItem(
      year: '2017',
      title: 'Loudspeaker Campaign',
      description: 'Launched campaign against loudspeakers at mosques',
      detailedDescription:
          'In 2017, MNS launched a campaign against the use of loudspeakers at mosques for azaan, arguing that it caused noise pollution. This campaign created significant communal tensions in Maharashtra.',
      imagePath:
          'https://via.placeholder.com/400x250/004E89/FFFFFF?text=Loudspeaker+Campaign+2017',
      eventType: TimelineEventType.policy,
      icon: Icons.volume_off_outlined,
      keyPoints: [
        'Noise pollution concerns',
        'Communal tensions',
        'Policy-focused campaign',
      ],
    ),
    TimelineItem(
      year: '2019',
      title: 'Zero Seats & Alliance Politics',
      description:
          'MNS did not contest Lok Sabha elections, won 0 assembly seats',
      detailedDescription:
          'In 2019, MNS chose not to contest the Lok Sabha elections and instead urged supporters to vote for the NCP-Congress alliance. However, in the Assembly elections, MNS contested but failed to win a single seat.',
      imagePath:
          'https://via.placeholder.com/400x250/FF4757/FFFFFF?text=Zero+Seats+2019',
      eventType: TimelineEventType.crisis,
      icon: Icons.block_outlined,
      keyPoints: [
        'Did not contest Lok Sabha',
        'Supported NCP-Congress',
        'Zero assembly seats',
      ],
    ),
    TimelineItem(
      year: '2020',
      title: 'COVID-19 Relief Work',
      description: 'MNS organized relief work during pandemic',
      detailedDescription:
          'During the COVID-19 pandemic in 2020-2021, MNS workers organized relief work including distribution of food, medicines, and essential supplies to needy families. This was seen as an attempt to rebuild the party\'s public image.',
      imagePath:
          'https://via.placeholder.com/400x250/00C896/FFFFFF?text=COVID+Relief+2020',
      eventType: TimelineEventType.achievement,
      icon: Icons.health_and_safety_outlined,
      keyPoints: [
        'Food distribution',
        'Medical supplies',
        'Image rebuilding effort',
      ],
    ),
    TimelineItem(
      year: '2022',
      title: 'Ayodhya Visit & Hindu Agenda',
      description:
          'Raj Thackeray visited Ayodhya, signaling shift towards Hindutva',
      detailedDescription:
          'In June 2022, Raj Thackeray visited Ayodhya and offered prayers at the Ram Temple construction site. This visit was seen as a significant shift in MNS\'s political strategy, moving towards a more pronounced Hindu nationalist agenda.',
      imagePath:
          'https://via.placeholder.com/400x250/004E89/FFFFFF?text=Ayodhya+Visit+2022',
      eventType: TimelineEventType.policy,
      icon: Icons.temple_hindu_outlined,
      keyPoints: [
        'Ram Temple visit',
        'Hindu nationalist shift',
        'Strategic realignment',
      ],
    ),
    TimelineItem(
      year: '2024',
      title: 'Return to Modi Support & Electoral Rout',
      description: 'MNS failed to win any assembly seat, hitting historic low',
      detailedDescription:
          'In 2024, Raj Thackeray changed his stance and reaffirmed support for Narendra Modi and the NDA government. However, in the Maharashtra Assembly elections, MNS suffered its worst-ever defeat, failing to win a single seat.',
      imagePath:
          'https://via.placeholder.com/400x250/FF4757/FFFFFF?text=Electoral+Rout+2024',
      eventType: TimelineEventType.crisis,
      icon: Icons.crisis_alert_outlined,
      keyPoints: ['Reaffirmed Modi support', 'Zero seats won', 'Historic low'],
    ),
  ];

  @override
  void initState() {
    super.initState();
    _staggerController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _floatingController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    _scrollController = ScrollController();

    // Start stagger animation
    _staggerController.forward();
    _floatingController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _staggerController.dispose();
    _floatingController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _toggleExpansion(int index) {
    HapticFeedback.mediumImpact();
    setState(() {
      if (expandedItems.contains(index)) {
        expandedItems.remove(index);
      } else {
        expandedItems.clear(); // Only one expanded at a time for better UX
        expandedItems.add(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        primaryColor: AppTheme.primaryColor,
        colorScheme: Theme.of(context).colorScheme.copyWith(
          primary: AppTheme.primaryColor,
          secondary: AppTheme.accentColor,
        ),
      ),
      child: Scaffold(
        backgroundColor: AppTheme.backgroundColor,
        body: CustomScrollView(
          controller: _scrollController,
          physics: const BouncingScrollPhysics(),
          slivers: [
            _buildSliverAppBar(),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 100),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final delay = index * 150.0;
                  return AnimatedBuilder(
                    animation: _staggerController,
                    builder: (context, child) {
                      final slideAnimation =
                          Tween<Offset>(
                            begin: const Offset(0, 1),
                            end: Offset.zero,
                          ).animate(
                            CurvedAnimation(
                              parent: _staggerController,
                              curve: Interval(
                                (delay / 1200).clamp(0.0, 1.0),
                                ((delay + 300) / 1200).clamp(0.0, 1.0),
                                curve: Curves.easeOutCubic,
                              ),
                            ),
                          );

                      final fadeAnimation = Tween<double>(begin: 0, end: 1)
                          .animate(
                            CurvedAnimation(
                              parent: _staggerController,
                              curve: Interval(
                                (delay / 1200).clamp(0.0, 1.0),
                                ((delay + 200) / 1200).clamp(0.0, 1.0),
                              ),
                            ),
                          );

                      return SlideTransition(
                        position: slideAnimation,
                        child: FadeTransition(
                          opacity: fadeAnimation,
                          child: _buildTimelineItem(
                            timelineItems[index],
                            index,
                            index == timelineItems.length - 1,
                          ),
                        ),
                      );
                    },
                  );
                }, childCount: timelineItems.length),
              ),
            ),
          ],
        ),
        floatingActionButton: _buildFloatingActionButton(),
      ),
    );
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      expandedHeight: 120,
      floating: false,
      pinned: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: const BoxDecoration(
            gradient: AppTheme.primaryGradient,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(32),
              bottomRight: Radius.circular(32),
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: const Icon(
                      Icons.timeline,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'MNS Political Journey',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            letterSpacing: -0.5,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            '2006 - 2024 • 18 Years',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTimelineItem(TimelineItem item, int index, bool isLast) {
    final isExpanded = expandedItems.contains(index);

    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Timeline indicator
            SizedBox(
              width: 60,
              child: Column(
                children: [
                  // Timeline node
                  AnimatedBuilder(
                    animation: _floatingController,
                    builder: (context, child) {
                      final floatingOffset =
                          math.sin(
                            _floatingController.value * 2 * math.pi +
                                index * 0.5,
                          ) *
                          2;

                      return Transform.translate(
                        offset: Offset(0, floatingOffset),
                        child: Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            gradient: item.gradient,
                            shape: BoxShape.circle,
                            boxShadow: isExpanded
                                ? AppTheme.elevatedShadow
                                : AppTheme.cardShadow,
                            border: Border.all(color: Colors.white, width: 3),
                          ),
                          child: Icon(item.icon, color: Colors.white, size: 24),
                        ),
                      );
                    },
                  ),
                  // Timeline line
                  if (!isLast)
                    Expanded(
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        width: 3,
                        margin: const EdgeInsets.only(top: 8),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              item.color.withOpacity(0.8),
                              item.color.withOpacity(0.2),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            // Content
            Expanded(child: _buildTimelineCard(item, index, isExpanded)),
          ],
        ),
      ),
    );
  }

  Widget _buildTimelineCard(TimelineItem item, int index, bool isExpanded) {
    return GestureDetector(
      onTap: () => _toggleExpansion(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOutCubic,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppTheme.cardColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: isExpanded ? AppTheme.elevatedShadow : AppTheme.cardShadow,
          border: Border.all(
            color: isExpanded
                ? item.color.withOpacity(0.3)
                : Colors.transparent,
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCardHeader(item, isExpanded),
            const SizedBox(height: 16),
            _buildCardContent(item, isExpanded),
            if (isExpanded) ...[
              const SizedBox(height: 20),
              _buildExpandedContent(item),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildCardHeader(TimelineItem item, bool isExpanded) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            gradient: item.gradient,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: item.color.withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Text(
            item.year,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
              letterSpacing: 0.5,
            ),
          ),
        ),
        const Spacer(),
        AnimatedRotation(
          duration: const Duration(milliseconds: 300),
          turns: isExpanded ? 0.5 : 0,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppTheme.surfaceColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.keyboard_arrow_down_rounded,
              color: AppTheme.textSecondary,
              size: 20,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCardContent(TimelineItem item, bool isExpanded) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          item.title,
          style: const TextStyle(
            color: AppTheme.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            height: 1.3,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          item.description,
          style: const TextStyle(
            color: AppTheme.textSecondary,
            fontSize: 15,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildExpandedContent(TimelineItem item) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOutCubic,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Divider
          Container(
            height: 1,
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  item.color.withOpacity(0.3),
                  Colors.transparent,
                ],
              ),
            ),
          ),
          // Image with loading state
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: AspectRatio(
              aspectRatio: 16 / 10,
              child: Image.network(
                item.imagePath,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    decoration: BoxDecoration(
                      color: AppTheme.surfaceColor,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                            : null,
                        color: item.color,
                        strokeWidth: 3,
                      ),
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          item.color.withOpacity(0.1),
                          item.color.withOpacity(0.05),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.image_outlined,
                          size: 48,
                          color: item.color.withOpacity(0.6),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Timeline Image',
                          style: TextStyle(
                            color: item.color.withOpacity(0.8),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 20),
          // Key points
          if (item.keyPoints.isNotEmpty) ...[
            Text(
              'Key Highlights',
              style: TextStyle(
                color: item.color,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            ...item.keyPoints.map(
              (point) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 6, right: 12),
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: item.color,
                        shape: BoxShape.circle,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        point,
                        style: const TextStyle(
                          color: AppTheme.textSecondary,
                          fontSize: 14,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
          // Detailed description
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.surfaceColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: item.color.withOpacity(0.1), width: 1),
            ),
            child: Text(
              item.detailedDescription,
              style: const TextStyle(
                color: AppTheme.textPrimary,
                fontSize: 15,
                height: 1.6,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    return AnimatedBuilder(
      animation: _floatingController,
      builder: (context, child) {
        final scale =
            1 + math.sin(_floatingController.value * 2 * math.pi) * 0.05;

        return Transform.scale(
          scale: scale,
          child: FloatingActionButton(
            onPressed: () {
              _scrollController.animateTo(
                0,
                duration: const Duration(milliseconds: 800),
                curve: Curves.easeInOutCubic,
              );
            },
            backgroundColor: AppTheme.primaryColor,
            elevation: 8,
            child: const Icon(
              Icons.keyboard_arrow_up_rounded,
              color: Colors.white,
              size: 28,
            ),
          ),
        );
      },
    );
  }
}
