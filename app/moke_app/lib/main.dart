import 'package:flutter/material.dart';
import 'package:moke_app/store/auth.dart';
import 'package:moke_app/util/enums/Prompt.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('JWT Authentication')),
        body: AuthWidget(),
      ),
    );
  }
}

class AuthWidget extends StatefulWidget {
  @override
  _AuthWidgetState createState() => _AuthWidgetState();
}

class _AuthWidgetState extends State<AuthWidget> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final PromptBuilder promptBuilder = PromptBuilder();
  Future<void> _login() async {
    try {
      await promptBuilder.login(
          _usernameController.text, _passwordController.text);
      print('Login successful');
    } catch (e) {
      print('Login failed: $e');
    }
  }

  Map<String, dynamic> dataText = {};
  Future<void> _fetchData() async {
    try {
      await promptBuilder.fetchProtectedData((p0) {
        setState(() {
          dataText = p0;
        });
      }, PromptEvent.initialPrompt);
    } catch (e) {
      print('Fetch data failed: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _usernameController,
          decoration: InputDecoration(labelText: 'Username'),
        ),
        TextField(
          controller: _passwordController,
          decoration: InputDecoration(labelText: 'Password'),
          obscureText: true,
        ),
        ElevatedButton(
          onPressed: _login,
          child: Text('Login'),
        ),
        ElevatedButton(
          onPressed: _fetchData,
          child: Text('Fetch Data'),
        ),
        Text(dataText.toString()),
      ],
    );
  }
}
