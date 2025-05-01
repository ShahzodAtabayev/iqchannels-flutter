import 'package:flutter/material.dart';
import 'package:iqchannels/iqchannels.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _iqchannelsPlugin = IQChannels();

  Future<void> _configure(BuildContext context) async {
    try {
      await _iqchannelsPlugin.configure(
        address: 'https://chatapi.beeline.uz',
        channel: 'test-segment',
      );
      _showSnackBar(context, 'Configured!');
    } catch (e) {
      _showSnackBar(context, 'Configuration failed: $e');
    }
  }

  Future<void> _login(BuildContext context) async {
    try {
      await _iqchannelsPlugin.login('your-auth-token');
      _showSnackBar(context, 'Logged in!');
    } catch (e) {
      _showSnackBar(context, 'Login failed: $e');
    }
  }

  Future<void> _logout(BuildContext context) async {
    try {
      await _iqchannelsPlugin.logout();
      _showSnackBar(context, 'Logged out!');
    } catch (e) {
      _showSnackBar(context, 'Logout failed: $e');
    }
  }

  Future<void> _loginAnonymous(BuildContext context) async {
    try {
      await _iqchannelsPlugin.loginAnonymous();
      _showSnackBar(context, 'Anonymous login done!');
    } catch (e) {
      _showSnackBar(context, 'Anonymous login failed: $e');
    }
  }

  Future<void> _logoutAnonymous(BuildContext context) async {
    try {
      await _iqchannelsPlugin.logoutAnonymous();
      _showSnackBar(context, 'Anonymous logout done!');
    } catch (e) {
      _showSnackBar(context, 'Anonymous logout failed: $e');
    }
  }

  Future<void> _openChat(BuildContext context) async {
    try {
      await _iqchannelsPlugin.openChat();
      _showSnackBar(context, 'Chat opened!');
    } catch (e) {
      _showSnackBar(context, 'Failed to open chat: $e');
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Builder(
        // ← Builder qo‘shib, contextni to‘g‘rilaymiz
        builder: (context) => Scaffold(
          appBar: AppBar(title: const Text('IQChannels Plugin Example')),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                ElevatedButton(
                  onPressed: () => _configure(context),
                  child: const Text('Configure'),
                ),
                ElevatedButton(
                  onPressed: () => _login(context),
                  child: const Text('Login'),
                ),
                ElevatedButton(
                  onPressed: () => _logout(context),
                  child: const Text('Logout'),
                ),
                ElevatedButton(
                  onPressed: () => _loginAnonymous(context),
                  child: const Text('Login Anonymous'),
                ),
                ElevatedButton(
                  onPressed: () => _logoutAnonymous(context),
                  child: const Text('Logout Anonymous'),
                ),
                ElevatedButton(
                  onPressed: () => _openChat(context),
                  child: const Text('Open Chat'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
