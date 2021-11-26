import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:infinity_scroll_app/models/passanger_model.dart';

class PassangerService {
  Future<PassangerModel?> getPassanger(
      {bool isRefresh = false, required int currentPage}) async {
    try {
      final Uri uri = Uri.parse(
          "https://api.instantwebtools.net/v1/passenger?page=$currentPage&size=10");
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        final result = PassangerModel.fromJson(data);
        PassangerModel passangerModel = result;
        // ignore: avoid_print
        print(response.body);
        return passangerModel;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
