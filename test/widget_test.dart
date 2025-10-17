
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myapp/main.dart';
import 'package:myapp/providers/auth_provider.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Create an instance of AuthProvider for the test.
    final authProvider = AuthProvider();

    // Build our app and trigger a frame.
    // Pass the required authProvider to the MyApp constructor.
    await tester.pumpWidget(MaterialApp(
      home: MyApp(authProvider: authProvider),
    ));

    // Wait for a frame to be rendered.
    await tester.pump();

    // Since the default page is now LoginScreen (due to the router logic
    // when not authenticated), we should verify that the LoginScreen is present.
    // Let's look for a widget unique to the LoginScreen, like the 'LOGIN' button.
    expect(find.widgetWithText(ElevatedButton, 'LOGIN'), findsOneWidget);

    // The original counter test is no longer relevant because the default
    // screen isn't the counter screen anymore.
    // We are commenting it out and replacing it with a more relevant test.

    // expect(find.text('0'), findsOneWidget);
    // expect(find.text('1'), findsNothing);

    // // Tap the '+' icon and trigger a frame.
    // await tester.tap(find.byIcon(Icons.add));
    // await tester.pump();

    // // Verify that our counter has incremented.
    // expect(find.text('0'), findsNothing);
    // expect(find.text('1'), findsOneWidget);
  });
}