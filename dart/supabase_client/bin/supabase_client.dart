import 'package:supabase_client/supabase.dart';

void main(List<String> arguments) async {
  var supabase = Database("id", "key");
  supabase.on("sandbox", (update) {
    print(update);
  });
}
