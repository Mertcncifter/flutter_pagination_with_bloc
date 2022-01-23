import 'dart:convert';

import 'package:blocpagination/feature/pagination/model/user.dart';
import 'package:flutter/services.dart';

Future ioGetUsers(int page, Function(dynamic jsonDyn) successTrue,
    Function(dynamic message) successFalse) async {
  try {
    var list = json
        .decode(await rootBundle.loadString('assets/user.json'))
        .map((data) => User.fromJson(data))
        .toList();
    String call = jsonEncode(list
            .sublist(page * 25)
            .take(25)
            .toList()
            .map((i) => i.toJson())
            .toList())
        .toString();
    await successTrue(jsonDecode("{\"items\":" + call + "}"));
  } catch (e) {
    await successFalse("Error");
  }
}
