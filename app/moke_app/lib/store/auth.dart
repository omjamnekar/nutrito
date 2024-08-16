import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:moke_app/util/enums/Prompt.dart';
import 'package:moke_app/util/urls/python_Serv.dart';

class PromptBuilder {
  final storage = FlutterSecureStorage();
  Future<void> login(String username, String password) async {
    final url = URLS.pythonInitial + '/login'; // Ensure this URL is correct
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'username': username, 'password': password}),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final token = data['token'];
      await storage.write(key: 'jwt_token2', value: token);
      print('Login successful');
    } else {
      print('Failed to login: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception('Failed to login');
    }
  }

  Future<void> fetchProtectedData(Function(Map<String, dynamic>) onDataDownload,
      PromptEvent promptType) async {
    final token = await storage.read(key: 'jwt_token2');
    if (token == null) {
      print('No token found');
      throw Exception('No token found');
    }

    final url = URLS.pythonInitial + '/' + promptType.name;
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'data': {
          'imageUrl':
              'https://m.media-amazon.com/images/I/81ol6TS3WOL._AC_UF1000,1000_QL80_.jpg'
        }
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print('Data: $data');
      onDataDownload(data);
    } else {
      print('Failed to fetch data: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  }
}
