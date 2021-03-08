import 'package:flutter/material.dart';

extension BuildContextX on BuildContext {
  Future<void> showSnackBar(
      {String message, String actionText = 'Okay', VoidCallback onPressed}) {
    final showAction = actionText != null && actionText.isNotEmpty;

    final controller = ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message ?? 'This feature is in progress'),
        behavior: SnackBarBehavior.floating,
        action: showAction
            ? SnackBarAction(
                label: actionText ?? 'Okay', onPressed: onPressed ?? () {})
            : null,
      ),
    );

    return controller.closed;
  }

  ThemeData get theme => this.theme;
  bool get isDarkTheme => theme.brightness == Brightness.dark;
}
