import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:swifty_companion/components/toast.dart';
import 'dart:convert';

import 'package:swifty_companion/hive_helper.dart';

class ApiCall {
  static const String _baseUrl = 'https://api.intra.42.fr/v2';

  static Future<Map<String, dynamic>?> getUserByLogin(
    String login,
    BuildContext context,
  ) async {
    try {
      final String token = await HiveHelper.get('token');
      final response = await http.get(
        Uri.parse('$_baseUrl/users/$login'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        Toast(
          context: context,
          title: 'Error ${response.statusCode}',
          description: '${response.reasonPhrase}',
          isSuccess: false,
        );
      }
    } catch (e) {
      final str = e.toString();
      String description = str.split(':')[1];
        if (description.contains('Failed host lookup')) {
          description = 'No Internet';
        }
        Toast(
          context: context,
          title: 'Error',
          description: description,
          isSuccess: false,
        );
        print(str);
      // rethrow;
    }
  }
}
