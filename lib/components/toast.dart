import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

void Toast({
  required BuildContext context,
  required String title,
  required String description,
  required bool isSuccess,
}) {
  toastification.show(
    context: context,
    title: Text(title),
    description: Text(description),
    autoCloseDuration: const Duration(seconds: 4),
    type: isSuccess ? ToastificationType.success : ToastificationType.error,
    style: ToastificationStyle.fillColored,
  );
}
