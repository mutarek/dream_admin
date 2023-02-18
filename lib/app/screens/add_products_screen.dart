import 'package:cached_network_image/cached_network_image.dart';
import 'package:dream_touch_admin/app/widgets/page_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/product_provider.dart';
import '../utils/text.styles.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';

class AddProducts extends StatefulWidget {
  const AddProducts(
      {this.isFromProduct = false, this.isFromNotice = false, this.isFromFailure = false, this.isFromSuccess = false, Key? key})
      : super(key: key);
  final bool isFromProduct;
  final bool isFromNotice;
  final bool isFromFailure;
  final bool isFromSuccess;

  @override
  State<AddProducts> createState() => _AddProductsState();
}

class _AddProductsState extends State<AddProducts> {
  final titleController = TextEditingController();
  final descController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Consumer<ProductsProvider>(
      builder: (context, taskProvider,child) {
        return Scaffold(
          appBar: widget.isFromProduct?
          PageAppBar(title: "Add products"):
              widget.isFromFailure?
                  PageAppBar(title: "Add Failure Notice"):
                  widget.isFromSuccess?
                      PageAppBar(title: "Add Success Notice"):
                      PageAppBar(title: "Add Products"),
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
                  const SizedBox(height: 10),
                  Text("Add Related Photos", style: robotoStyle600SemiBold.copyWith(fontSize: 14)),
                  taskProvider.afterConvertImageLists.isNotEmpty
                      ? SizedBox(
                    height: 100,
                    child: Row(
                      children: [
                        Expanded(
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: taskProvider.afterConvertImageLists.length,
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              itemBuilder: (context, index) {
                                return Container(
                                    margin: const EdgeInsets.only(bottom: 15, top: 5, left: 5),
                                    alignment: Alignment.center,
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(5),
                                        child: Stack(
                                          children: [
                                            SizedBox(
                                                height: 100,
                                                child: Image.file(
                                                  taskProvider.afterConvertImageLists[index],
                                                  scale: 1.0,
                                                )),
                                            const SizedBox(width: 5),
                                            Positioned(
                                                right: 5,
                                                top: 5,
                                                child: IconButton(
                                                    onPressed: () {
                                                      //postProvider.clearUserImage(index);
                                                    },
                                                    icon: const Icon(Icons.clear, color: Colors.white)))
                                          ],
                                        )));
                              }),
                        )
                      ],
                    ),
                  )
                      : const SizedBox.shrink(),
                  CustomButton(
                    onTap: () {
                      taskProvider.pickImage();
                    },
                    btnTxt: "Upload Images",
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
          bottomSheet: Container(
            padding: EdgeInsets.all(5),
            height: 50,
            child: taskProvider.isLoading?
            const Center(
              child: CircularProgressIndicator(),
            ):
            CustomButton(
                radius: 15,
                btnTxt: "Create Task",
                onTap: () {

                }),
          ),
        );
      }
    );
  }
}
