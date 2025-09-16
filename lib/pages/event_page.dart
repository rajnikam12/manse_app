import 'package:flutter/material.dart';
import 'package:manse_app/models/event.dart';
import 'package:manse_app/pages/widgets/event_card.dart';
import 'package:manse_app/repo/events_repository.dart';
import 'package:shimmer/shimmer.dart';

class EventPage extends StatefulWidget {
  const EventPage({super.key});

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  final EventsRepository _repo = EventsRepository();
  final ScrollController _scrollController = ScrollController();
  final List<Event> _events = [];
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  DateTime? _searchDate;
  DateTime? _lastSearchTs;
  bool _isLoading = true;
  bool _isLoadingMore = false;
  bool _hasMore = true;
  static const int _pageSize = 10;
  int _offset = 0;

  @override
  void initState() {
    super.initState();
    _loadInitial();
    _scrollController.addListener(_onScroll);
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadInitial() async {
    setState(() => _isLoading = true);
    try {
      final page = await _repo.fetchPage(
        offset: _offset,
        limit: _pageSize,
        searchQuery: _searchQuery.isEmpty ? null : _searchQuery,
        onDate: _searchDate,
      );
      setState(() {
        _events.addAll(page);
        _offset += page.length;
        _hasMore = page.length == _pageSize;
      });
    } catch (_) {
      // allow UI to show an empty/error state
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _loadMore() async {
    if (_isLoadingMore || !_hasMore) return;
    setState(() => _isLoadingMore = true);
    try {
      final page = await _repo.fetchPage(
        offset: _offset,
        limit: _pageSize,
        searchQuery: _searchQuery.isEmpty ? null : _searchQuery,
        onDate: _searchDate,
      );
      setState(() {
        _events.addAll(page);
        _offset += page.length;
        _hasMore = page.length == _pageSize;
      });
    } finally {
      if (mounted) setState(() => _isLoadingMore = false);
    }
  }

  void _onScroll() {
    if (!_scrollController.hasClients ||
        _isLoading ||
        _isLoadingMore ||
        !_hasMore)
      return;
    const threshold = 200.0;
    final position = _scrollController.position;
    if (position.maxScrollExtent - position.pixels <= threshold) {
      _loadMore();
    }
  }

  void _onSearchChanged() {
    final now = DateTime.now();
    _lastSearchTs = now;
    Future.delayed(const Duration(milliseconds: 350), () {
      if (_lastSearchTs == now) {
        final newQuery = _searchController.text.trim();
        if (newQuery == _searchQuery) return;
        setState(() {
          _searchQuery = newQuery;
          _searchDate = _parseDate(newQuery);
          _events.clear();
          _offset = 0;
          _hasMore = true;
          _isLoading = true;
        });
        _loadInitial();
      }
    });
  }

  DateTime? _parseDate(String input) {
    final m = RegExp(r'^\\d{4}-\\d{2}-\\d{2}\$');
    if (m.hasMatch(input)) {
      try {
        final dt = DateTime.parse(input);
        return dt;
      } catch (_) {}
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30),
              Text(
                'Events : ',
                style: Theme.of(context).textTheme.displayLarge,
              ),
              SizedBox(height: 10),
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search events or YYYY-MM-DD date',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        tooltip: 'Pick date',
                        icon: const Icon(Icons.calendar_today),
                        onPressed: _pickDate,
                      ),
                      if (_searchQuery.isNotEmpty)
                        IconButton(
                          tooltip: 'Clear text',
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _searchController.clear();
                          },
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              if (_searchDate != null)
                Wrap(
                  spacing: 8,
                  children: [
                    InputChip(
                      label: Text(_formatYmd(_searchDate!)),
                      onDeleted: () {
                        setState(() {
                          _searchDate = null;
                          _events.clear();
                          _offset = 0;
                          _hasMore = true;
                          _isLoading = true;
                        });
                        _loadInitial();
                      },
                    ),
                  ],
                ),
              if (_searchDate != null) const SizedBox(height: 10),

              Expanded(
                child: _isLoading
                    ? ListView.separated(
                        controller: _scrollController,
                        itemCount: 6,
                        separatorBuilder: (_, __) => const SizedBox(height: 12),
                        itemBuilder: (context, index) => Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100,
                          child: const EventShimmerCard(),
                        ),
                      )
                    : _events.isEmpty
                    ? Center(
                        child: Text(
                          'No events found',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      )
                    : ListView.separated(
                        controller: _scrollController,
                        itemCount:
                            _events.length +
                            (_isLoadingMore || _hasMore ? 1 : 0),
                        separatorBuilder: (_, __) => const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          if (index >= _events.length) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8.0,
                              ),
                              child: Center(
                                child: _hasMore
                                    ? Shimmer.fromColors(
                                        baseColor: Colors.grey.shade300,
                                        highlightColor: Colors.grey.shade100,
                                        child: const EventShimmerCard(),
                                      )
                                    : Text(
                                        'No more events',
                                        style: Theme.of(
                                          context,
                                        ).textTheme.bodySmall,
                                      ),
                              ),
                            );
                          }
                          final e = _events[index];
                          return EventCard(
                            imagePath: e.imageUrl,
                            title: e.title,
                            dateTime: _formatDate(e.dateTime),
                            location: e.location,
                            description: e.description,
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime dt) {
    // Simple format: Sep 20, 2025 | 6:00 PM
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    final h = dt.hour % 12 == 0 ? 12 : dt.hour % 12;
    final m = dt.minute.toString().padLeft(2, '0');
    final ampm = dt.hour >= 12 ? 'PM' : 'AM';
    return '${months[dt.month - 1]} ${dt.day}, ${dt.year} | $h:$m $ampm';
  }

  String _formatYmd(DateTime dt) {
    final mm = dt.month.toString().padLeft(2, '0');
    final dd = dt.day.toString().padLeft(2, '0');
    return '${dt.year}-$mm-$dd';
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final initial = _searchDate ?? DateTime(now.year, now.month, now.day);
    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(2000),
      lastDate: DateTime(now.year + 5),
    );
    if (picked != null) {
      setState(() {
        _searchDate = picked;
        _events.clear();
        _offset = 0;
        _hasMore = true;
        _isLoading = true;
      });
      _loadInitial();
    }
  }
}
