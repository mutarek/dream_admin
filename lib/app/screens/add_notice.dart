import 'package:cached_network_image/cached_network_image.dart';
import 'package:dream_touch_admin/app/widgets/page_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';

import '../controller/product_provider.dart';
import '../model/user_model.dart';
import '../utils/text.styles.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';

class AddNotice extends StatefulWidget {
  AddNotice({Key? key}) : super(key: key);
  @override
  State<AddNotice> createState() => _AddProductsState();
}

class _AddProductsState extends State<AddNotice> {
  final titleController = TextEditingController();
  final descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductsProvider>(builder: (context, taskProvider, child) {
      return Scaffold(
        appBar: const PageAppBar(title: "Add products"),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Text("Add A Title", style: robotoStyle600SemiBold.copyWith(fontSize: 15))),
                const SizedBox(height: 5),
                CustomTextField(
                  hintText: 'Title',
                  isShowBorder: true,
                  borderRadius: 11,
                  verticalSize: 14,
                  controller: titleController,
                ),
                const SizedBox(height: 10),
                Text("Add A Note", style: robotoStyle600SemiBold.copyWith(fontSize: 14)),
                const SizedBox(height: 5),
                CustomTextField(
                  hintText: 'Note',
                  isShowBorder: true,
                  borderRadius: 11,
                  verticalSize: 14,
                  maxLines: 3,
                  controller: descController,
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
        bottomSheet: Container(
          padding: const EdgeInsets.all(5),
          height: 50,
          child: taskProvider.isLoading
              ? const Center(
            child: CircularProgressIndicator(),
          )
              : CustomButton(
              radius: 15,
              btnTxt: "Create",
              onTap: () {
                taskProvider.addNotice(titleController.text, descController.text, "Products", (status) {
                  if (status) {
                    Get.back();
                  } else {}
                });
              }),
        ),
      );
    });
  }
}
