import 'package:manse_app/models/event.dart';
import 'package:manse_app/services/supabase_service.dart';

class EventsRepository {
  static const String table = 'events';

  Future<List<Event>> fetchLatest({int limit = 50}) async {
    final response = await SupabaseService.client
        .from(table)
        .select()
        .order('date_time', ascending: false)
        .limit(limit);

    final List data = response as List<dynamic>;
    return data.map((e) => Event.fromMap(e as Map<String, dynamic>)).toList();
  }

  Future<List<Event>> fetchPage({
    required int offset,
    required int limit,
    String? searchQuery,
    DateTime? onDate,
  }) async {
    var query = SupabaseService.client.from(table).select();

    if (searchQuery != null && searchQuery.trim().isNotEmpty) {
      final raw = searchQuery.trim();
      final terms = raw
          .split(RegExp(r"\s+"))
          .map((t) => t.trim())
          .where((t) => t.length >= 2)
          .toList();
      if (terms.isNotEmpty) {
        // Apply OR across fields for each term; chaining .or combines with AND between calls
        for (final term in terms) {
          query = query.or(
            'title.ilike.%' +
                term +
                '%,location.ilike.%' +
                term +
                '%,description.ilike.%' +
                term +
                '%',
          );
        }
      }
    }

    if (onDate != null) {
      final start = DateTime(onDate.year, onDate.month, onDate.day).toUtc();
      final end = start.add(const Duration(days: 1));
      query = query
          .gte('date_time', start.toIso8601String())
          .lt('date_time', end.toIso8601String());
    }

    final response = await query
        .order('date_time', ascending: false)
        .range(offset, offset + limit - 1);

    final List data = response as List<dynamic>;
    return data.map((e) => Event.fromMap(e as Map<String, dynamic>)).toList();
  }
}
