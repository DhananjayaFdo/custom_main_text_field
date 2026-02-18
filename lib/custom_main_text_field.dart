/// A highly customizable text field widget for Flutter with extensive styling,
/// validation, password visibility toggle, and special features like "Forgot password?" button.
///
/// Quick start:
/// ```dart
/// import 'package:custom_main_text_field/custom_main_text_field.dart';
///
/// CustomTextField(
///   controller: emailController,
///   hint: 'Enter email',
///   title: 'Email',
///   prefixIcon: Icons.email,
///   validator: (v) => v?.isEmpty ?? true ? 'Required' : null,
/// )
/// ```
library custom_main_text_field;

export 'src/custom_main_text_field.dart';
