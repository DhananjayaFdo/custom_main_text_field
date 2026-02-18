# custom_main_text_field

A highly customizable Flutter text field widget with password visibility toggle, validation, focus states, and 40+ styling options.

## Features

✨ **Password toggle** – show/hide password with one tap  
🎯 **Form validation** – integrates with Flutter Form  
🎨 **40+ customization options** – colors, borders, padding, icons  
👁️ **Focus states** – visual feedback when focused  
🔒 **Forgot password button** – built-in for login forms  
📏 **Character counter** – with customizable display  
🚫 **Read-only mode** – for display-only fields  
⌨️ **Input formatters** – phone, card numbers, etc  
🌈 **Theme-aware** – respects Material theme  
⚡ **Zero dependencies** – Flutter only

---

## Installation

```yaml
dependencies:
  custom_main_text_field: ^1.0.0
```

---

## Quick Start

```dart
import 'package:custom_main_text_field/custom_main_text_field.dart';

CustomTextField(
  controller: emailController,
  hint: 'Enter email',
  title: 'Email',
  prefixIcon: Icons.email,
  validator: (v) => v?.isEmpty ?? true ? 'Required' : null,
)
```

---

## Examples

### 1. Basic text field

```dart
CustomTextField(
  controller: nameController,
  hint: 'Enter your name',
  title: 'Full Name',
)
```

### 2. Password field

```dart
CustomTextField(
  controller: passwordController,
  hint: 'Enter password',
  title: 'Password',
  isPassword: true,
  prefixIcon: Icons.lock,
)
```

### 3. Password with "Forgot password?"

```dart
CustomTextField(
  controller: passwordController,
  hint: 'Enter password',
  title: 'Password',
  isPassword: true,
  prefixIcon: Icons.lock,
  showForgotPassword: true,
  onForgotPasswordTap: () => Navigator.push(...),
)
```

### 4. With prefix icon

```dart
CustomTextField(
  controller: emailController,
  hint: 'email@example.com',
  title: 'Email',
  prefixIcon: Icons.email,
  keyboardType: TextInputType.emailAddress,
)
```

### 5. With suffix icon

```dart
CustomTextField(
  controller: searchController,
  hint: 'Search...',
  suffixIcon: Icons.search,
  onSuffixIconTap: () => performSearch(),
)
```

### 6. Custom colors

```dart
CustomTextField(
  controller: controller,
  hint: 'Enter text',
  fillColor: Colors.blue.shade50,
  borderColor: Colors.blue.shade200,
  focusedBorderColor: Colors.blue,
  prefixIconColor: Colors.blue,
)
```

### 7. Multi-line textarea

```dart
CustomTextField(
  controller: notesController,
  hint: 'Enter notes',
  title: 'Notes',
  maxLines: 5,
  minLines: 3,
)
```

### 8. Phone number with formatter

```dart
CustomTextField(
  controller: phoneController,
  hint: '(123) 456-7890',
  title: 'Phone',
  prefixIcon: Icons.phone,
  keyboardType: TextInputType.phone,
  inputFormatters: [
    FilteringTextInputFormatter.digitsOnly,
    LengthLimitingTextInputFormatter(10),
  ],
)
```

### 9. With validation

```dart
CustomTextField(
  controller: emailController,
  hint: 'email@example.com',
  title: 'Email',
  isRequired: true,
  prefixIcon: Icons.email,
  validator: (value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!value.contains('@')) {
      return 'Enter valid email';
    }
    return null;
  },
  autovalidateMode: AutovalidateMode.onUserInteraction,
)
```

### 10. Read-only field

```dart
CustomTextField(
  controller: TextEditingController(text: 'Read only value'),
  title: 'User ID',
  readOnly: true,
  fillColor: Colors.grey.shade100,
)
```

---

## API Reference

### Core Properties

| Parameter      | Type                         | Default  | Description          |
| -------------- | ---------------------------- | -------- | -------------------- |
| `controller`   | `TextEditingController`      | required | Text controller      |
| `validator`    | `String? Function(String?)?` | null     | Validation function  |
| `keyboardType` | `TextInputType`              | `text`   | Keyboard type        |
| `onChanged`    | `ValueChanged<String>?`      | null     | Text change callback |
| `onTap`        | `VoidCallback?`              | null     | Tap callback         |

### Icons

| Parameter         | Type            | Default | Description          |
| ----------------- | --------------- | ------- | -------------------- |
| `isPassword`      | `bool`          | false   | Show password toggle |
| `prefixIcon`      | `IconData?`     | null    | Leading icon         |
| `suffixIcon`      | `IconData?`     | null    | Trailing icon        |
| `prefixIconColor` | `Color?`        | null    | Prefix icon color    |
| `suffixIconColor` | `Color?`        | null    | Suffix icon color    |
| `onSuffixIconTap` | `VoidCallback?` | null    | Suffix tap handler   |
| `iconSize`        | `double`        | 20      | Icon size            |

### Text & Labels

| Parameter           | Type         | Default | Description           |
| ------------------- | ------------ | ------- | --------------------- |
| `title`             | `String?`    | null    | Label above field     |
| `hint`              | `String`     | ''      | Placeholder text      |
| `labelText`         | `String?`    | null    | Floating label        |
| `showFloatingLabel` | `bool`       | false   | Enable floating label |
| `isRequired`        | `bool`       | false   | Show asterisk         |
| `titleStyle`        | `TextStyle?` | null    | Title text style      |
| `hintStyle`         | `TextStyle?` | null    | Hint text style       |

### Styling

| Parameter            | Type                  | Default   | Description          |
| -------------------- | --------------------- | --------- | -------------------- |
| `fillColor`          | `Color?`              | White     | Background color     |
| `borderColor`        | `Color?`              | Divider   | Normal border color  |
| `focusedBorderColor` | `Color?`              | Primary   | Focused border color |
| `errorBorderColor`   | `Color?`              | Error     | Error border color   |
| `borderRadius`       | `double`              | 12        | Corner radius        |
| `borderWidth`        | `double`              | 1.5       | Normal border width  |
| `focusedBorderWidth` | `double`              | 2.0       | Focused border width |
| `padding`            | `EdgeInsetsGeometry?` | bottom 20 | Outer padding        |
| `contentPadding`     | `EdgeInsetsGeometry?` | 16 all    | Inner padding        |

### Behavior

| Parameter             | Type                        | Default | Description            |
| --------------------- | --------------------------- | ------- | ---------------------- |
| `enabled`             | `bool`                      | true    | Enable/disable         |
| `readOnly`            | `bool`                      | false   | Read-only mode         |
| `maxLines`            | `int?`                      | 1       | Max lines              |
| `maxLength`           | `int?`                      | null    | Max characters         |
| `showCounter`         | `bool`                      | true    | Show character count   |
| `autovalidateMode`    | `AutovalidateMode?`         | null    | Validation mode        |
| `inputFormatters`     | `List<TextInputFormatter>?` | null    | Input formatters       |
| `unfocusOnTapOutside` | `bool`                      | true    | Unfocus on outside tap |

### Special Features

| Parameter             | Type            | Default            | Description                 |
| --------------------- | --------------- | ------------------ | --------------------------- |
| `showForgotPassword`  | `bool`          | false              | Show forgot password button |
| `onForgotPasswordTap` | `VoidCallback?` | null               | Forgot password handler     |
| `forgotPasswordText`  | `String`        | 'Forgot password?' | Button text                 |

---

## Use Cases

✅ Login forms  
✅ Registration forms  
✅ Profile edit screens  
✅ Search bars  
✅ Comment/note fields  
✅ Settings forms  
✅ Any text input!

---

## License

MIT
