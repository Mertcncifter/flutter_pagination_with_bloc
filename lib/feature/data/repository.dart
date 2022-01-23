import 'dart:convert';
import 'package:blocpagination/feature/services/service.dart';

class Repository {
  Future<String> getUsers(int page) async {
    String callback = "";
    await ioGetUsers(page, (jsonDyn) async {
      callback = "{\"success\":true,\"message\":\"\", \"data\":{\"items\":" +
          jsonEncode(jsonDyn["items"]) +
          "}}";
    }, (message) async {
      callback =
          "{\"success\":false,\"message\":\"" + message + "\", \"data\":{}}";
    });
    return callback;
  }
}
