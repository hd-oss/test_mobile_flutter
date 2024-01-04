import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:test_mobile_flutter/app/data/model/post_model.dart';

import '../../../data/repository/posts_repository.dart';
import '../../widget_feedback.dart';

class FormController extends GetxController {
  final formKey = GlobalKey<FormBuilderState>();
  final repository = PostsRepository();
  late PostModel? postModel;

  final state = Get.parameters['state'];
  final data = Get.arguments;
  final isloading = true.obs;

  @override
  void onInit() {
    super.onInit();
    if (state == 'edit_post') {
      postModel = data as PostModel?;
    } else {
      isloading(false);
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> onSaveFormField() async {
    Map<String, dynamic> resultBody = {};
    print('${formKey.currentState?.value['body']}');
    if (formKey.currentState!.saveAndValidate()) {
      try {
        FeedbackHelper.loading();

        resultBody = {
          'title': formKey.currentState?.value['title'],
          'body': formKey.currentState?.value['body'],
          'userId': 1,
        };
        final result = state == 'add_post'
            ? await repository.addMyPost(resultBody)
            : await repository.editMyPost(postModel!.id.toString(),resultBody);

        FeedbackHelper.closeLoading();
        Get.dialog(
          AlertDialog(
            content: Text(result.toString()),
            actions: [
              ElevatedButton(
                onPressed: () => Get.back(closeOverlays: true),
                child: const Text('Ok', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
          barrierDismissible: false,
        );
      } catch (e) {
        print(e);
        FeedbackHelper.closeLoading();
        FeedbackHelper.alertDialog(
            content: e.toString().tr,
            textBtn: 'OK',
            onPressed: () => Get.back());
      }
    } else {
      FeedbackHelper.snackBar(message: 'Please check back', isValid: false);
    }
  }
}
