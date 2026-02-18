import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A highly customizable text field widget with extensive styling and behavior options.
///
/// Features:
/// * Password visibility toggle
/// * Prefix and suffix icons
/// * Form validation
/// * Custom styling (colors, borders, padding)
/// * Focus state management
/// * Character counter
/// * "Forgot password?" button
/// * Read-only mode
/// * Auto-capitalization
/// * Input formatters
/// * And much more!
///
/// Example:
/// ```dart
/// CustomTextField(
///   controller: emailController,
///   hint: 'Enter email',
///   title: 'Email',
///   prefixIcon: Icons.email,
///   validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
/// )
/// ```
class CustomTextField extends StatefulWidget {
  // ── Core ──────────────────────────────────────────────────────────────────
  
  /// Controller for the text field
  final TextEditingController controller;
  
  /// Validation function
  final String? Function(String?)? validator;
  
  /// Keyboard type
  final TextInputType keyboardType;
  
  /// Called when the field is tapped
  final VoidCallback? onTap;
  
  /// Called when the text changes
  final ValueChanged<String>? onChanged;
  
  /// Called when the user submits the field
  final ValueChanged<String>? onFieldSubmitted;

  // ── Icons ─────────────────────────────────────────────────────────────────
  
  /// Whether this is a password field (shows visibility toggle)
  final bool isPassword;
  
  /// Prefix icon (shown at the start)
  final IconData? prefixIcon;
  
  /// Suffix icon (shown at the end)
  final IconData? suffixIcon;
  
  /// Color for prefix icon
  final Color? prefixIconColor;
  
  /// Color for suffix icon
  final Color? suffixIconColor;
  
  /// Called when suffix icon is tapped
  final VoidCallback? onSuffixIconTap;
  
  /// Size of icons
  final double iconSize;

  // ── Text ──────────────────────────────────────────────────────────────────
  
  /// Text alignment
  final TextAlign textAlign;
  
  /// Label shown above the field
  final String? title;
  
  /// Floating label text (inside field when empty)
  final String? labelText;
  
  /// Hint text (placeholder)
  final String hint;
  
  /// Whether to show floating label
  final bool showFloatingLabel;
  
  /// Text style for title
  final TextStyle? titleStyle;
  
  /// Color for title text
  final Color? titleColor;
  
  /// Text style for input text
  final TextStyle? textStyle;
  
  /// Text style for hint
  final TextStyle? hintStyle;
  
  /// Text style for floating label
  final TextStyle? labelStyle;
  
  /// Whether field is required (shows asterisk)
  final bool isRequired;

  // ── Styling ───────────────────────────────────────────────────────────────
  
  /// Padding around the entire widget
  final EdgeInsetsGeometry? padding;
  
  /// Padding inside the text field
  final EdgeInsetsGeometry? contentPadding;
  
  /// Fill color for the field
  final Color? fillColor;
  
  /// Border color (normal state)
  final Color? borderColor;
  
  /// Border color when focused
  final Color? focusedBorderColor;
  
  /// Border color when there's an error
  final Color? errorBorderColor;
  
  /// Border radius
  final double borderRadius;
  
  /// Border width (normal state)
  final double borderWidth;
  
  /// Border width when focused
  final double focusedBorderWidth;

  // ── Behavior ──────────────────────────────────────────────────────────────
  
  /// Whether the field is read-only
  final bool readOnly;
  
  /// Whether to auto-focus
  final bool autofocus;
  
  /// Maximum number of lines
  final int? maxLines;
  
  /// Minimum number of lines
  final int? minLines;
  
  /// Maximum character length
  final int? maxLength;
  
  /// Text capitalization mode
  final TextCapitalization textCapitalization;
  
  /// Auto-validate mode
  final AutovalidateMode? autovalidateMode;
  
  /// Focus node
  final FocusNode? focusNode;
  
  /// Autofill hints
  final Iterable<String>? autofillHints;
  
  /// Input formatters
  final List<TextInputFormatter>? inputFormatters;
  
  /// Whether the field is enabled
  final bool enabled;
  
  /// Counter text (overrides default)
  final String? counterText;
  
  /// Whether to show character counter
  final bool showCounter;

  // ── Special Features ──────────────────────────────────────────────────────
  
  /// Shows "Forgot password?" button (useful for password fields)
  final bool showForgotPassword;
  
  /// Called when "Forgot password?" is tapped
  final VoidCallback? onForgotPasswordTap;
  
  /// Text for forgot password button
  final String forgotPasswordText;
  
  /// Whether to unfocus on tap outside
  final bool unfocusOnTapOutside;
  
  /// Error message max lines
  final int errorMaxLines;

  const CustomTextField({
    super.key,
    required this.controller,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.onTap,
    this.onChanged,
    this.onFieldSubmitted,
    
    // Icons
    this.isPassword = false,
    this.prefixIcon,
    this.suffixIcon,
    this.prefixIconColor,
    this.suffixIconColor,
    this.onSuffixIconTap,
    this.iconSize = 20.0,
    
    // Text
    this.textAlign = TextAlign.start,
    this.title,
    this.labelText,
    this.hint = '',
    this.showFloatingLabel = false,
    this.titleStyle,
    this.textStyle,
    this.titleColor,
    this.hintStyle,
    this.labelStyle,
    this.isRequired = false,
    
    // Styling
    this.padding,
    this.contentPadding,
    this.fillColor,
    this.borderColor,
    this.focusedBorderColor,
    this.errorBorderColor,
    this.borderRadius = 12.0,
    this.borderWidth = 1.5,
    this.focusedBorderWidth = 2.0,
    
    // Behavior
    this.readOnly = false,
    this.autofocus = false,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.textCapitalization = TextCapitalization.none,
    this.autovalidateMode,
    this.focusNode,
    this.autofillHints,
    this.inputFormatters,
    this.enabled = true,
    this.counterText,
    this.showCounter = true,
    
    // Special
    this.showForgotPassword = false,
    this.onForgotPasswordTap,
    this.forgotPasswordText = 'Forgot password?',
    this.unfocusOnTapOutside = true,
    this.errorMaxLines = 2,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _obscureText;
  late FocusNode _internalFocusNode;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
    _internalFocusNode = widget.focusNode ?? FocusNode();
    _internalFocusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _internalFocusNode.removeListener(_onFocusChange);
    if (widget.focusNode == null) {
      _internalFocusNode.dispose();
    }
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = _internalFocusNode.hasFocus;
    });
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  OutlineInputBorder _buildBorder({
    bool isFocused = false,
    bool isError = false,
  }) {
    final theme = Theme.of(context);
    Color borderColor;
    double width;

    if (isError) {
      borderColor = widget.errorBorderColor ?? theme.colorScheme.error;
      width = widget.borderWidth;
    } else if (isFocused) {
      borderColor = widget.focusedBorderColor ?? theme.colorScheme.primary;
      width = widget.focusedBorderWidth;
    } else {
      borderColor = widget.borderColor ?? theme.dividerColor;
      width = widget.borderWidth;
    }

    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(widget.borderRadius),
      borderSide: BorderSide(width: width, color: borderColor),
    );
  }

  Widget? _buildPrefixIcon() {
    if (widget.prefixIcon == null) return null;

    final theme = Theme.of(context);
    return Icon(
      widget.prefixIcon,
      color: widget.prefixIconColor ??
          (_isFocused ? theme.colorScheme.primary : theme.hintColor),
      size: widget.iconSize,
    );
  }

  Widget? _buildSuffixIcon() {
    final theme = Theme.of(context);

    // Password visibility toggle has highest priority
    if (widget.isPassword) {
      return IconButton(
        onPressed: _togglePasswordVisibility,
        icon: Icon(
          _obscureText ? Icons.visibility_off : Icons.visibility,
          size: widget.iconSize,
          color: theme.hintColor,
        ),
        splashRadius: 20,
      );
    }

    // Custom suffix icon
    if (widget.suffixIcon != null) {
      return IconButton(
        onPressed: widget.onSuffixIconTap,
        icon: Icon(
          widget.suffixIcon,
          size: widget.iconSize,
          color: widget.suffixIconColor ?? theme.hintColor,
        ),
        splashRadius: 20,
      );
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: widget.padding ?? const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Title with optional "Forgot password?" button
          if (widget.title != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  Flexible(
                    child: Text(
                      widget.title!,
                      style: widget.titleStyle ??
                          theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: widget.titleColor,
                          ),
                    ),
                  ),
                  if (widget.isRequired)
                    Text(
                      ' *',
                      style: widget.titleStyle?.copyWith(
                            color: theme.colorScheme.error,
                          ) ??
                          TextStyle(
                            color: theme.colorScheme.error,
                            fontWeight: FontWeight.w600,
                            fontSize:
                                theme.textTheme.bodyMedium?.fontSize ?? 14,
                          ),
                    ),
                  const Spacer(),
                  if (widget.showForgotPassword)
                    TextButton(
                      onPressed: widget.onForgotPasswordTap,
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: const Size(50, 20),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text(
                        widget.forgotPasswordText,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ),
                ],
              ),
            ),

          // Text Field
          TextFormField(
            controller: widget.controller,
            validator: widget.validator,
            keyboardType: widget.keyboardType,
            onTap: widget.onTap,
            onChanged: widget.onChanged,
            onFieldSubmitted: widget.onFieldSubmitted,
            readOnly: widget.readOnly,
            enabled: widget.enabled,
            focusNode: _internalFocusNode,
            autofocus: widget.autofocus,
            autocorrect: false,
            obscureText: _obscureText,
            textAlign: widget.textAlign,
            textCapitalization: widget.textCapitalization,
            autovalidateMode: widget.autovalidateMode,
            autofillHints: widget.autofillHints,
            inputFormatters: widget.inputFormatters,
            onTapOutside: widget.unfocusOnTapOutside
                ? (event) => FocusManager.instance.primaryFocus?.unfocus()
                : null,
            maxLines: widget.isPassword ? 1 : widget.maxLines,
            minLines: widget.minLines,
            maxLength: widget.maxLength,
            style: widget.textStyle ?? theme.textTheme.bodyMedium,
            decoration: InputDecoration(
              filled: true,
              fillColor: !widget.enabled
                  ? theme.disabledColor.withOpacity(0.05)
                  : widget.fillColor ??
                      theme.inputDecorationTheme.fillColor ??
                      Colors.white,
              contentPadding: widget.contentPadding ??
                  const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 16,
                  ),
              prefixIcon: _buildPrefixIcon(),
              suffixIcon: _buildSuffixIcon(),
              labelText: widget.showFloatingLabel ? widget.labelText : null,
              labelStyle: widget.labelStyle ??
                  theme.textTheme.bodyMedium?.copyWith(
                    color: _isFocused
                        ? theme.colorScheme.primary
                        : theme.hintColor,
                  ),
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              hintText: widget.hint.isNotEmpty ? widget.hint : null,
              hintStyle: widget.hintStyle ??
                  theme.textTheme.bodyMedium?.copyWith(
                    color: theme.hintColor,
                  ),
              counterText: widget.showCounter
                  ? widget.counterText
                  : (widget.maxLength != null ? null : ''),
              counterStyle: theme.textTheme.bodySmall,
              border: _buildBorder(),
              enabledBorder: _buildBorder(),
              focusedBorder: _buildBorder(isFocused: true),
              errorBorder: _buildBorder(isError: true),
              focusedErrorBorder:
                  _buildBorder(isFocused: true, isError: true),
              disabledBorder: _buildBorder(),
              errorStyle: theme.textTheme.bodySmall?.copyWith(
                fontSize: 12,
                color: theme.colorScheme.error,
              ),
              errorMaxLines: widget.errorMaxLines,
            ),
          ),
        ],
      ),
    );
  }
}
