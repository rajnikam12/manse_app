import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:manse_app/core/config/env.dart';

class SupabaseService {
  static SupabaseClient get client => Supabase.instance.client;

  static Future<void> initialize() async {
    if (!AppEnv.isConfigured) {
      throw StateError('Supabase is not configured. Check your .env');
    }

    await Supabase.initialize(
      url: AppEnv.supabaseUrl,
      anonKey: AppEnv.supabaseAnonKey,
      authOptions: const FlutterAuthClientOptions(autoRefreshToken: true),
    );
  }
}
