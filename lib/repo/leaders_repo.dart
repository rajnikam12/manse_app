import 'package:manse_app/models/leaders.dart';
import 'package:manse_app/services/supabase_service.dart';

class LeadersRepository {
  static const String table = 'leaders';

  Future<List<Leader>> fetchAll({int limit = 50}) async {
    final response = await SupabaseService.client
        .from(table)
        .select()
        .order('created_at', ascending: false)
        .limit(limit);

    if (response == null) {
      return [];
    }

    final List data = response as List<dynamic>;
    return data.map((e) => Leader.fromMap(e as Map<String, dynamic>)).toList();
  }

  Future<List<Leader>> fetchPage({
    required int offset,
    required int limit,
    String? searchQuery,
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
        for (final term in terms) {
          query = query.or('name.ilike.%$term%,role.ilike.%$term%');
        }
      }
    }

    final response = await query
        .order('created_at', ascending: false)
        .range(offset, offset + limit - 1);

    if (response == null) {
      return [];
    }

    final List data = response as List<dynamic>;
    return data.map((e) => Leader.fromMap(e as Map<String, dynamic>)).toList();
  }
}
