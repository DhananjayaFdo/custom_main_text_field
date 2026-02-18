import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:custom_main_text_field/custom_main_text_field.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Custom Text Field Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const ExamplePage(),
    );
  }
}

class ExamplePage extends StatefulWidget {
  const ExamplePage({super.key});

  @override
  State<ExamplePage> createState() => _ExamplePageState();
}

class _ExamplePageState extends State<ExamplePage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();
  final _notesController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CustomTextField Examples'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            // 1. Basic
            const Text('1 · Basic', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            CustomTextField(
              controller: _nameController,
              hint: 'Enter your name',
              title: 'Full Name',
            ),

            // 2. With prefix icon
            const Text('2 · With prefix icon', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            CustomTextField(
              controller: _emailController,
              hint: 'email@example.com',
              title: 'Email',
              prefixIcon: Icons.email,
              keyboardType: TextInputType.emailAddress,
              validator: (v) => v?.isEmpty ?? true ? 'Required' : null,
            ),

            // 3. Password field
            const Text('3 · Password', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            CustomTextField(
              controller: _passwordController,
              hint: 'Enter password',
              title: 'Password',
              isPassword: true,
              isRequired: true,
              prefixIcon: Icons.lock,
              showForgotPassword: true,
              onForgotPasswordTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Forgot password tapped')),
                );
              },
            ),

            // 4. Phone with formatter
            const Text('4 · Phone number', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            CustomTextField(
              controller: _phoneController,
              hint: '(123) 456-7890',
              title: 'Phone',
              prefixIcon: Icons.phone,
              keyboardType: TextInputType.phone,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(10),
              ],
            ),

            // 5. Multi-line
            const Text('5 · Multi-line', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            CustomTextField(
              controller: _notesController,
              hint: 'Enter notes...',
              title: 'Notes',
              maxLines: 5,
              minLines: 3,
            ),

            // 6. Custom styled
            const Text('6 · Custom colors', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            CustomTextField(
              controller: TextEditingController(),
              hint: 'Custom styled field',
              title: 'Styled',
              fillColor: Colors.blue.shade50,
              borderColor: Colors.blue.shade200,
              focusedBorderColor: Colors.blue,
              prefixIcon: Icons.star,
              prefixIconColor: Colors.blue,
            ),

            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Form is valid! ✅')),
                    );
                  }
                },
                child: const Text('Validate Form'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
