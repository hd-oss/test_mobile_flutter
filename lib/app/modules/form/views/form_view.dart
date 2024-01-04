import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:get/get.dart';

import '../controllers/form_controller.dart';

class FormView extends GetView<FormController> {
  const FormView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:
              Text(controller.state == 'add_post' ? 'Add Post' : 'Edit Post'),
          centerTitle: true,
        ),
        body: GetBuilder<FormController>(
          builder: (controller) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: FormBuilder(
              key: controller.formKey,
              child: Column(
                children: [
                  FormBuilderTextField(
                    initialValue: controller.state == 'add_post'
                        ? ''
                        : controller.postModel!.title,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: "Title",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (value) =>
                        controller.formKey.currentState?.value['title'] == ''
                            ? 'Title cannot be empty'
                            : null,
                    name: 'title',
                  ).paddingOnly(bottom: 12),
                  FormBuilderTextField(
                    initialValue: controller.state == 'add_post'
                        ? ''
                        : controller.postModel!.body,
                    keyboardType: TextInputType.multiline,
                    maxLines: 5,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: "Description",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (value) =>
                        controller.formKey.currentState?.value['body'] == ''
                            ? 'Description cannot be empty'
                            : null,
                    name: 'body',
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(45),
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onPressed: () => controller.onSaveFormField(),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Save",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ).paddingAll(16),
                ],
              ),
            ),
          ),
        ));
  }
}
