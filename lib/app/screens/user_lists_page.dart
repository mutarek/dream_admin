import 'package:cached_network_image/cached_network_image.dart';
import 'package:dream_touch_admin/app/controller/user_liist_controller.dart';
import 'package:dream_touch_admin/app/utils/text.styles.dart';
import 'package:dream_touch_admin/app/widgets/custom_button.dart';
import 'package:dream_touch_admin/app/widgets/page_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'each_profile.dart';

class UserListsPage extends StatelessWidget {
  UserListsPage({Key? key}) : super(key: key);
  final userCon = Get.put(UserListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PageAppBar(title: 'User Lists'),
      body: Obx(() => Padding(
            padding: const EdgeInsets.all(10),
            child: userCon.isLoading.value
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                    itemCount: userCon.userModel.length,
                    itemBuilder: (_, index) {
                      var user = userCon.userModel[index];
                      return Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        margin: const EdgeInsets.all(5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Stack(
                              children: [
                                Align(
                                  child: CircleAvatar(
                                    radius: 25,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: CachedNetworkImage(
                                        placeholder: (context, url) => const CircularProgressIndicator(),
                                        imageUrl: user.userProfile!,
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      user.is_approved == true
                                          ? const Icon(
                                              Icons.verified,
                                              color: Colors.green,
                                            )
                                          : const Icon(Icons.access_time_sharp, color: Colors.red),
                                      const SizedBox(
                                        width: 10,
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const Divider(thickness: 1, color: Colors.black),
                            Text(user.userName!, style: robotoStyle700Bold.copyWith(fontSize: 14)),
                            Text("Code: ${user.permitCode!}", style: robotoStyle700Bold.copyWith(fontSize: 14)),
                            Padding(
                              padding: const EdgeInsets.only(left: 8,right: 8,bottom: 5),
                              child: CustomButton(
                                btnTxt: "Visit",height: 20,onTap: (){
                                  Get.to(()=> EachProfilePage(user));
                              }),
                            )
                          ],
                        ),
                      );
                    },
                  ),
          )),
    );
  }
}
