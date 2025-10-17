import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:myapp/providers/auth_provider.dart';

class LoggingOutScreen extends StatefulWidget {
  const LoggingOutScreen({super.key});

  @override
  State<LoggingOutScreen> createState() => _LoggingOutScreenState();
}

class _LoggingOutScreenState extends State<LoggingOutScreen> {
  @override
  void initState() {
    super.initState();
    // Perform the logout action after the first frame is built.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AuthProvider>(context, listen: false).logout();
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 20),
            Text('Logging you out...'),
          ],
        ),
      ),
    );
  }
}
