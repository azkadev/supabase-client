import 'package:supabase/supabase.dart';

class Database {
  late SupabaseClient client;
  Database(String id, String key) {
    client = SupabaseClient("https://$id.supabase.co", key);
  }

  dynamic add(String from, datas) async {
    var response = await client.from(from).insert(datas).execute();
    if (response.hasError) {
      throw response.error!.toJson();
    }
    return true;
  }

  dynamic delete(String from, datas) async {
    var response = await client.from(from).delete().match(datas).execute();
    if (response.hasError) {
      throw response.error!.toJson();
    }
    return response.data;
  }

  dynamic get(String from, String dataId, searchData) async {
    var response = await client.from(from).select().execute();
    if (response.hasError) {
      throw response.error!.toJson();
    }
    for (var index = 0; index < response.data.length; index++) {
      var loopData = response.data[index];
      if (RegExp(searchData.toString(), caseSensitive: false)
          .hasMatch(loopData[dataId.toString()].toString())) {
        return loopData;
      }
    }
    return false;
  }

  dynamic getAll(String from) async {
    var response = await client.from(from).select().execute();
    if (response.hasError) {
      throw response.error!.toJson();
    }
    return response.data;
  }

  dynamic insert(String from, datas) async {
    var response = await client.from(from).insert(datas).execute();
    if (response.hasError) {
      throw response.error!.toJson();
    }
    return true;
  }

  dynamic update(String from, dataOrigin, dataUpdate) async {
    var response =
        await client.from(from).update(dataUpdate).match(dataOrigin).execute();
    if (response.hasError) {
      throw response.error!.toJson();
    }
    return response.data;
  }

  void on(String from, callback) {
    if (from.isEmpty) {
      throw {
        "message": "Tolong isi from ya !"
      };
    }
    client.from(from).on(SupabaseEventTypes.all, (update) {
      var json_data = {};
      json_data["type"] = update.eventType.toLowerCase();
      json_data["new_data"] = update.newRecord;
      json_data["old_data"] = update.oldRecord;
      return callback(json_data);
    }).subscribe();
  }
}

String typeData(data) {
  return data.runtimeType
      .toString()
      .toLowerCase()
      .replaceAll(RegExp(r"<.*"), "")
      .replaceAll(RegExp(r"_internallinkedhashmap"), "object")
      .replaceAll(RegExp(r"_"), "")
      .replaceAll(RegExp("^list\$", caseSensitive: false), "object")
      .replaceAll(RegExp("^int\$", caseSensitive: false), "number")
      .replaceAll(RegExp("^bool\$", caseSensitive: false), "boolean");
}

String typeof(data) {
  return data.runtimeType
      .toString()
      .toLowerCase()
      .replaceAll(RegExp(r"<.*"), "")
      .replaceAll(RegExp(r"_internallinkedhashmap"), "object")
      .replaceAll(RegExp(r"_"), "")
      .replaceAll(RegExp("^list\$", caseSensitive: false), "array")
      .replaceAll(RegExp("^int\$", caseSensitive: false), "number")
      .replaceAll(RegExp("^bool\$", caseSensitive: false), "boolean");
}

bool getBoolean(data) {
  var check = typeof(data);
  if (check == "string") {
    if (data.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  } else if (check == "object") {
    if (data.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  } else if (check == "array") {
    if (data.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  } else if (check == "number") {
    if (data < 0) {
      return true;
    } else if (data.isOdd) {
      return true;
    } else {
      return false;
    }
  } else if (check == "boolean") {
    return data;
  } else {
    return false;
  }
}
