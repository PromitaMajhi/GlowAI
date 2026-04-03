import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // Use 10.0.2.2 for Android Emulator connecting to localhost, or change to suitable IP
  static const String baseUrl = 'http://10.0.2.2:5000';

  static Future<Map<String, dynamic>> askSkinProblem(String message) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/ask'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'message': message}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['reply'];
      } else {
        throw Exception('Failed to load response');
      }
    } catch (e) {
      print('Error calling API: $e');
      throw Exception('Network error or server unavailable');
    }
  }
}
