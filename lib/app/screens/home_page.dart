import 'package:dream_touch_admin/app/screens/add_products_screen.dart';
import 'package:dream_touch_admin/app/screens/all_notice.dart';
import 'package:dream_touch_admin/app/screens/unaproved_aproved_profile.dart';
import 'package:dream_touch_admin/app/screens/user_lists_page.dart';
import 'package:dream_touch_admin/app/utils/text.styles.dart';
import 'package:dream_touch_admin/app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';

import '../controller/auth_provider.dart';
import '../controller/home_provider.dart';
import '../utils/app_colors.dart';
import '../widgets/custom_text_field.dart';
import 'add_notice.dart';
import 'all_products.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({Key? key}) : super(key: key);

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  final emailController = TextEditingController();
  final passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer2<HomeProvider, AuthProvider>(builder: (context, homeProvider, authProvider, child) {
      return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Admin Panel",
                          style: robotoStyle700Bold.copyWith(fontSize: 20),
                        )),
                    const SizedBox(height: 20),
                    Card(
                      child: ListTile(
                        onTap: (){
                          Get.to(UserListsPage());
                        },
                        leading: const Icon(Icons.man),
                        title: Text('User List',style: robotoStyle700Bold.copyWith(fontSize:22)),
                        trailing: const Icon(Icons.arrow_circle_right),
                      ),
                    ),
                    Card(
                      child: ListTile(
                        onTap: (){
                          Get.to(UnaprovedProfileList());
                        },
                        leading: const Icon(Icons.man),
                        title: Text('Unapproved Profile',style: robotoStyle700Bold.copyWith(fontSize:22,color: Colors.red)),
                        trailing: const Icon(Icons.arrow_circle_right),
                      ),
                    ),
                    Card(
                      child: ListTile(
                        onTap: (){
                          Get.to(()=> AddProducts(isFromProduct: true));
                        },
                        leading: const Icon(Icons.production_quantity_limits_rounded),
                        title: Text('Add Products',style: robotoStyle700Bold.copyWith(fontSize:22)),
                        trailing: const Icon(Icons.arrow_circle_right),
                      ),
                    ),
                    Card(
                      child: ListTile(
                        onTap: (){
                          Get.to(()=> AllProducts());
                        },
                        leading: const Icon(Icons.production_quantity_limits_rounded),
                        title: Text('All Products',style: robotoStyle700Bold.copyWith(fontSize:22)),
                        trailing: const Icon(Icons.arrow_circle_right),
                      ),
                    ),
                    Card(
                      child: ListTile(
                        onTap: (){
                          Get.to(()=> AddNotice());
                        },
                        leading: const Icon(Icons.circle_notifications_outlined),
                        title: Text('Add Notice',style: robotoStyle700Bold.copyWith(fontSize:22)),
                        trailing: const Icon(Icons.arrow_circle_right),
                      ),
                    ),
                    Card(
                      child: ListTile(
                        onTap: (){
                          Get.to(()=> AllNotice());
                        },
                        leading: const Icon(Icons.circle_notifications_outlined),
                        title: Text('All Notice',style: robotoStyle700Bold.copyWith(fontSize:22)),
                        trailing: const Icon(Icons.arrow_circle_right),
                      ),
                    ),
                  ],
                )),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Get.bottomSheet(Container(
                padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                    color: AppColors.primaryColorLight),
                height: 200,
                child: Column(
                  children: [
                    CustomTextField(
                      hintText: "Admin Email",
                      controller: emailController,
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      hintText: "Admin Password",
                      controller: passController,
                    ),
                    const SizedBox(height: 10),
                    homeProvider.isLoading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : CustomButton(
                            onTap: () {
                              authProvider.createAccount(emailController.text, passController.text).then((value) {
                                if (value) {
                                  if(Get.isBottomSheetOpen ?? false){
                                    Get.back();
                                    emailController.clear();
                                    passController.clear();
                                    Get.snackbar('Success','Admin Account Created',snackPosition: SnackPosition.BOTTOM);
                                  }
                                }
                              });
                            },
                            btnTxt: "Add New Admin",
                            backgroundColor: Colors.white,
                            textWhiteColor: false)
                  ],
                ),
              ));
            },
            child: const Icon(Icons.add)),
      );
    });
  }
}
