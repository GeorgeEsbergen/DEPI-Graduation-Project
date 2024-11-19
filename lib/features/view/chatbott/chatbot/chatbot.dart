import 'dart:convert';

import 'package:http/http.dart' as http;

class Chatbot {
  final String _url = 'http://10.0.2.2:5000/chat'; // Replace with your IP address

  Future<String> sendMessage(String message) async {
    final response = await http.post(Uri.parse(_url), headers: {
      'Content-Type': 'application/json',
    }, body: jsonEncode({'message': message}));

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['response'];
    } else {
      throw Exception('Failed to load data');
    }
  }
}