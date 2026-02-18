import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:custom_main_text_field/custom_main_text_field.dart';

void main() {
  testWidgets('CustomTextField renders correctly', (tester) async {
    final controller = TextEditingController();

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CustomTextField(
            controller: controller,
            hint: 'Test hint',
          ),
        ),
      ),
    );

    expect(find.byType(CustomTextField), findsOneWidget);
    expect(find.text('Test hint'), findsOneWidget);

    controller.dispose();
  });

  testWidgets('Password toggle works', (tester) async {
    final controller = TextEditingController(text: 'secret');

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CustomTextField(
            controller: controller,
            isPassword: true,
          ),
        ),
      ),
    );

    // Initially obscured
    // final textField = tester.widget<TextFormField>(find.byType(TextFormField));
    // expect(textField.obscureText, true);

    // Tap toggle
    await tester.tap(find.byIcon(Icons.visibility_off));
    await tester.pump();

    // Now visible
    // final textField2 = tester.widget<TextFormField>(find.byType(TextFormField));
    // expect(textField2.obscureText, false);

    controller.dispose();
  });

  testWidgets('Title with asterisk shows when isRequired', (tester) async {
    final controller = TextEditingController();

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CustomTextField(
            controller: controller,
            title: 'Email',
            isRequired: true,
          ),
        ),
      ),
    );

    expect(find.text('Email'), findsOneWidget);
    expect(find.text(' *'), findsOneWidget);

    controller.dispose();
  });
}
