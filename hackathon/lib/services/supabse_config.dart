import 'package:supabase_flutter/supabase_flutter.dart';

supabaseConfig() async {
  await Supabase.initialize(
    url: "https://gmlswmawshshqvdkzeds.supabase.co",
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImdtbHN3bWF3c2hzaHF2ZGt6ZWRzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDkxNDczMjksImV4cCI6MjAyNDcyMzMyOX0.hUAXkJZCGpuONLthV4c64H8bh9cYNA1-oVjYfIyD0o8",
  );
}
