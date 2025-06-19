import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class AuthService {
  // Replace these with your actual credentials
  static const String clientId =
      'u-s4t2ud-8d2fec4bbb575f3ac215756c34879ea1beada45b93b0462640c0213c5b17fb7b';
  static const String clientSecret =
      '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';
  static const String redirectUri = 'swiftycompanion://auth';

  static const String authUrl = 'https://api.intra.42.fr/oauth/authorize';
  static const String tokenUrl = 'https://api.intra.42.fr/oauth/token';
  static const String apiBaseUrl = 'https://api.intra.42.fr/v2';

  // Step 1: Open the 42 OAuth page
  static Future<void> startLogin() async {
    final Uri authUri = Uri.parse(
      '$authUrl?client_id=$clientId&redirect_uri=$redirectUri&response_type=code&scope=public',
    );

    print('Opening auth URL: $authUri');

    try {
      await launchUrl(authUri, mode: LaunchMode.platformDefault);
    } catch (e) {
      print(
        'Failed to launch with platformDefault, trying externalApplication',
      );
      try {
        await launchUrl(authUri, mode: LaunchMode.externalApplication);
      } catch (e2) {
        print('Failed with externalApplication, trying inAppWebView');
        await launchUrl(authUri, mode: LaunchMode.inAppWebView);
      }
    }
  }

  // Step 2: Exchange the authorization code for an access token
  static Future<String?> exchangeCodeForToken(String code) async {
    print('Exchanging code for token: $code');

    try {
      final response = await http.post(
        Uri.parse(tokenUrl),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {
          'grant_type': 'authorization_code',
          'client_id': clientId,
          'client_secret': clientSecret,
          'code': code,
          'redirect_uri': redirectUri,
        },
      );

      print('Token response status: ${response.statusCode}');
      print('Token response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return data['access_token'];
      } else {
        print('Error getting token: ${response.statusCode} - ${response.body}');
        return null;
      }
    } catch (e) {
      print('Exception during token exchange: $e');
      return null;
    }
  }

  // Step 3: Get user data using the access token
  static Future<void> getUserData(String accessToken) async {
    print('Getting user data with token: $accessToken');

    try {
      final response = await http.get(
        Uri.parse('$apiBaseUrl/me'),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
      );

      print('User data response status: ${response.statusCode}');
      print('User data response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> userData = json.decode(response.body);
        print('✅ Login successful!');
        print('User ID: ${userData['id']}');
        print('Login: ${userData['login']}');
        print('Email: ${userData['email']}');
        print('Full Name: ${userData['usual_full_name']}');
      } else {
        print('❌ Error getting user data: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception during user data fetch: $e');
    }
  }
}
