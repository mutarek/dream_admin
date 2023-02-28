import 'package:dream_touch_admin/app/widgets/page_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../controller/product_provider.dart';
import '../model/user_model.dart';
import '../utils/text.styles.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';

class AddEarningMethod extends StatelessWidget {
   AddEarningMethod({required this.userModel,Key? key}) : super(key: key);
  final UserModel userModel;
  final ammountControler = TextEditingController();
  final numberController = TextEditingController();
  final methodController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  Consumer<ProductsProvider>(
      builder: (context, productsProvider,child) {
        return Scaffold(
          appBar: PageAppBar(title: "Add Earning Method"),
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
                      child: Text("Add A Amount", style: robotoStyle600SemiBold.copyWith(fontSize: 15))),
                  const SizedBox(height: 5),
                  CustomTextField(
                    hintText: 'Amount',
                    isShowBorder: true,
                    borderRadius: 11,
                    verticalSize: 14,
                    controller: ammountControler,
                  ),
                  const SizedBox(height: 10),
                  Text("Add A Number", style: robotoStyle600SemiBold.copyWith(fontSize: 14)),
                  const SizedBox(height: 5),
                  CustomTextField(
                    hintText: 'Number',
                    isShowBorder: true,
                    borderRadius: 11,
                    verticalSize: 14,
                    controller: numberController,
                  ),
                  const SizedBox(height: 5),
                  Text("Add A Method", style: robotoStyle600SemiBold.copyWith(fontSize: 14)),
                  const SizedBox(height: 5),
                  CustomTextField(
                    hintText: 'Method',
                    isShowBorder: true,
                    borderRadius: 11,
                    verticalSize: 14,
                    controller: methodController,
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
          bottomSheet: Container(
            padding: const EdgeInsets.all(5),
            height: 50,
            child: productsProvider.isLoading
                ? const Center(
              child: CircularProgressIndicator(),
            )
                : CustomButton(
                radius: 15,
                btnTxt: "Create",
                onTap: () {
                  productsProvider.createPaymentMethod(ammountControler.text, numberController.text, methodController.text,userModel.docId.toString(),(status){
                    if(status){
                      Fluttertoast.showToast(msg: "Payment Has Been Created");
                      Get.back();
                    }
                    else{}
                  });
                }),
          ),
        );
      }
    );
  }
}
