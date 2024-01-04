import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FeedbackHelper {
  static alertDialog(
      {String? title,
      required String textBtn,
      required VoidCallback? onPressed,
      VoidCallback? onPressReload,
      dynamic content,
      String? leading,
      VoidCallback? leadingOnPressed,
      bool barrierDismissible = false}) {
    if (content.runtimeType == String) {
      content = Text('$content');
    }

    Get.dialog(
        AlertDialog(
          title: title != null
              ? Text(
                  title,
                )
              : null,
          content: content,
          actions: [
            if (leading != null) ...{
              TextButton(
                  onPressed: leadingOnPressed,
                  child: Text(
                    leading,
                    style: const TextStyle(),
                  )),
            },
            ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(),
              child: Text(
                textBtn,
                style: const TextStyle(color: Colors.white),
              ),
            ),
            onPressReload != null
                ? ElevatedButton(
                    onPressed: onPressReload,
                    style: ElevatedButton.styleFrom(),
                    child: const Text(
                      "Muat Ulang",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                : const SizedBox()
          ],
        ),
        barrierDismissible: barrierDismissible);
  }

  static comingSoonAlertDialog() {
    alertDialog(
        title: 'Coming Soon',
        content: 'In development stage...',
        textBtn: 'Ok',
        onPressed: Get.back);
  }

  static snackBar(
      {String? title,
      required String message,
      bool? isValid,
      int? durationSeconds,
      bool mainButton = false,
      String? mainButtonText,
      VoidCallback? mainButtonPressed,
      Color? backgroundColor}) {
    if (Get.isSnackbarOpen) return;

    return Get.showSnackbar(
      GetSnackBar(
        title: title,
        message: message,
        mainButton: mainButton == true
            ? TextButton(
                onPressed: mainButtonPressed,
                child: Text(
                  '$mainButtonText',
                  style: const TextStyle(color: Colors.white),
                ))
            : null,
        duration: durationSeconds == null
            ? const Duration(seconds: 2)
            : Duration(seconds: durationSeconds),
        snackStyle: SnackStyle.FLOATING,
        margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
        borderRadius: 8,
        backgroundColor: backgroundColor ??
            (isValid == true ? Colors.green : Colors.red),
      ),
    );
  }

  static loading() {
    Get.dialog(
        const Center(
          child: CircularProgressIndicator(),
        ),
        barrierDismissible: false);
  }

  static loadingDialog({String? loadingText, bool hideLoadingText = false}) {
    Get.dialog(
        AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Center(child: CircularProgressIndicator()),
              if (!hideLoadingText) ...{
                const SizedBox(height: 16),
                Builder(
                  builder: (context) {
                    if (loadingText != null) {
                      loadingText = loadingText;
                    } else {
                      loadingText = 'Harap Tunggu';
                    }

                    return Text(
                      '$loadingText',
                    );
                  },
                ),
              },
            ],
          ),
        ),
        barrierDismissible: false);
  }

  static closeLoading() {
    Get.back();
  }

  }
