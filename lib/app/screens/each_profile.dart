import 'package:cached_network_image/cached_network_image.dart';
import 'package:dream_touch_admin/app/controller/product_provider.dart';
import 'package:dream_touch_admin/app/utils/text.styles.dart';
import 'package:dream_touch_admin/app/widgets/custom_button.dart';
import 'package:dream_touch_admin/app/widgets/page_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';

import '../model/user_model.dart';
import '../widgets/custom_text_field.dart';
import 'add_earning_method.dart';
import 'add_products_screen.dart';

class EachProfilePage extends StatelessWidget {
  EachProfilePage(this.userModel, {Key? key}) : super(key: key);
  final UserModel userModel;
  final failedController = TextEditingController();
  final successController = TextEditingController();
  final walletController = TextEditingController();
  final paymentHistory = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductsProvider>(builder: (context, productsProvider, child) {
      return Scaffold(
        appBar: PageAppBar(
          title: userModel.userName,
        ),
        body: ListView(
          children: [
            const SizedBox(height: 10),
            CircleAvatar(
              radius: 34,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: CachedNetworkImage(
                  placeholder: (context, url) => const CircularProgressIndicator(),
                  imageUrl: userModel.userProfile!,
                ),
              ),
            ),
            const SizedBox(height: 30),
            Align(
                alignment: Alignment.center,
                child: Text("Team No: ${userModel.teamNo!}", style: robotoStyle700Bold.copyWith(fontSize: 20))),
            const SizedBox(height: 30),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(3),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(3),
                    child: CustomButton(
                      btnTxt: "Failed Report",
                      onTap: () {
                        Get.bottomSheet(Container(
                          padding: const EdgeInsets.all(10),
                          height: 250,
                          width: double.infinity,
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(25),
                                topRight: Radius.circular(25),
                              ),
                              color: Colors.white),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 10),
                              Text("Add Failed Report", style: robotoStyle600SemiBold.copyWith(fontSize: 14)),
                              const SizedBox(height: 5),
                              CustomTextField(
                                hintText: 'Failed Report',
                                isShowBorder: true,
                                borderRadius: 11,
                                verticalSize: 14,
                                maxLines: 3,
                                controller: failedController,
                              ),
                              const SizedBox(height: 10),
                              productsProvider.isLoading
                                  ? const Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : CustomButton(
                                      onTap: () {
                                        productsProvider.updateFailedReport(failedController.text, userModel.docId.toString(), (status) {
                                          if (status) {
                                            failedController.clear();
                                            if (Get.isBottomSheetOpen ?? false) {
                                              Get.back();
                                            }
                                          } else {
                                            Fluttertoast.showToast(msg: "Something went wrong");
                                          }
                                        });
                                        //taskProvider.clearCoverProfile();
                                        //taskProvider.pickImage();
                                      },
                                      btnTxt: "Update Failed Report",
                                    ),
                              const SizedBox(height: 30),
                            ],
                          ),
                        ));
                      },
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                // Expanded(
                //   flex: 1,
                //   child: Padding(
                //       padding: const EdgeInsets.all(3),
                //       child: CustomButton(
                //           btnTxt: "Add Notice",
                //           onTap: () {
                //             Get.to(() => AddProducts(userModel, isFromNotice: true));
                //           })),
                // ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(3),
                    child: CustomButton(
                        btnTxt: "Success Report",
                        onTap: () {
                          Get.bottomSheet(Container(
                            padding: const EdgeInsets.all(10),
                            height: 250,
                            width: double.infinity,
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(25),
                                  topRight: Radius.circular(25),
                                ),
                                color: Colors.white),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 10),
                                Text("Add Success Report", style: robotoStyle600SemiBold.copyWith(fontSize: 14)),
                                const SizedBox(height: 5),
                                CustomTextField(
                                  hintText: 'Success Report',
                                  isShowBorder: true,
                                  borderRadius: 11,
                                  verticalSize: 14,
                                  maxLines: 3,
                                  controller: successController,
                                ),
                                const SizedBox(height: 10),
                                productsProvider.isLoading
                                    ? const Center(
                                        child: CircularProgressIndicator(),
                                      )
                                    : CustomButton(
                                        onTap: () {
                                          productsProvider.updateSuccessReport(successController.text, userModel.docId.toString(),
                                              (status) {
                                            if (status) {
                                              successController.clear();
                                              if (Get.isBottomSheetOpen ?? false) {
                                                Get.back();
                                              }
                                            } else {
                                              Fluttertoast.showToast(msg: "Something went wrong");
                                            }
                                          });
                                          //taskProvider.clearCoverProfile();
                                          //taskProvider.pickImage();
                                        },
                                        btnTxt: "Update Success Report",
                                      ),
                                const SizedBox(height: 30),
                              ],
                            ),
                          ));
                        }),
                  ),
                )
              ],
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Padding(
                      padding: const EdgeInsets.all(3),
                      child: CustomButton(
                          btnTxt: "Update Wallet",
                          onTap: () {
                            Get.bottomSheet(Container(
                              padding: const EdgeInsets.all(10),
                              height: 250,
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(25),
                                    topRight: Radius.circular(25),
                                  ),
                                  color: Colors.white),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 10),
                                  Text("Update Wallet", style: robotoStyle600SemiBold.copyWith(fontSize: 14)),
                                  const SizedBox(height: 5),
                                  CustomTextField(
                                    hintText: 'Amount',
                                    isShowBorder: true,
                                    borderRadius: 11,
                                    verticalSize: 14,
                                    maxLines: 3,
                                    controller: walletController,
                                  ),
                                  const SizedBox(height: 10),
                                  productsProvider.isLoading
                                      ? const Center(
                                          child: CircularProgressIndicator(),
                                        )
                                      : CustomButton(
                                          onTap: () {
                                            productsProvider.updateWallet(walletController.text, userModel.docId.toString(), (status) {
                                              if (status) {
                                                walletController.clear();
                                                if (Get.isBottomSheetOpen ?? false) {
                                                  Get.back();
                                                }
                                              } else {
                                                Fluttertoast.showToast(msg: "Something went wrong");
                                              }
                                            });
                                          },
                                          btnTxt: "Update Wallet",
                                        ),
                                  const SizedBox(height: 30),
                                ],
                              ),
                            ));
                          })),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(3),
                    child: CustomButton(
                      btnTxt: "Off Account",
                      onTap: () {
                        Get.defaultDialog(
                            title: 'Waring Account',
                            content: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const SizedBox(
                                  height: 20.0,
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: Text("Cancel", style: robotoStyle600SemiBold.copyWith(fontSize: 15))),
                                const SizedBox(
                                  width: 10.0,
                                ),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.red,
                                      onPrimary: Colors.black,
                                    ),
                                    onPressed: () {
                                      productsProvider.changeAccountStatus(userModel.docId.toString(), (status) {
                                        if (status) {
                                          Get.back();
                                        } else {}
                                      });
                                    },
                                    child: Text("Off Account", style: robotoStyle600SemiBold.copyWith(fontSize: 15))),
                              ],
                            ),
                            radius: 10.0);
                      },
                    ),
                  ),
                )
              ],
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(3),
                    child: CustomButton(
                        btnTxt: "ReOpen Account",
                        onTap: () {
                          productsProvider.reopenAccount(userModel.docId.toString(), (status) {
                            if (status) {
                              Fluttertoast.showToast(msg: "Account Open Successfully");
                            } else {
                              Fluttertoast.showToast(msg: "Something went wrong");
                            }
                          });
                        }),
                  ),
                )
              ],
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(3),
                    child: CustomButton(
                        btnTxt: "Payment Method",
                        onTap: () {
                          Get.to(() => AddEarningMethod(userModel: userModel));
                        }),
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            Text("User Nid or Birth", style: robotoStyle700Bold.copyWith(fontSize: 15)),
            const SizedBox(height: 10),
            CachedNetworkImage(
              imageUrl: userModel.nidOrBirth!,
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ],
        ),
      );
    });
  }
}
