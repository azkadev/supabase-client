# Supabase client


## Install
```bash
dart pub add supabase_client
```

## QuickStart
```dart
import 'package:supabase_client/supabase.dart';

void main(List<String> arguments) async {
  var supabase = Database("id", "key");
  await supabase.add("from", {"id": DateTime.now()});
  await supabase.get("from", "id", "^5\$");
  await supabase.getAll("from");
  await supabase.update("from", {"id": 5}, {"id": 10});
  await supabase.delete("from", {"id": 10});
  supabase.on("sandbox", (update) {
    print(update);
  });
}
```