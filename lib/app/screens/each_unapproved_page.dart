import 'package:cached_network_image/cached_network_image.dart';
import 'package:dream_touch_admin/app/controller/product_provider.dart';
import 'package:dream_touch_admin/app/utils/text.styles.dart';
import 'package:dream_touch_admin/app/widgets/page_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../model/user_model.dart';

class EachUnAproved extends StatelessWidget {
  const EachUnAproved(this.userModel, {Key? key}) : super(key: key);
  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductsProvider>(
      builder: (context, productProvider,child) {
        return Scaffold(
          appBar: PageAppBar(title: userModel.userName!),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: CircleAvatar(
                      radius: 50,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: userModel.userProfile!,
                          progressIndicatorBuilder: (context, url, downloadProgress) => CircularProgressIndicator(value: downloadProgress.progress),
                          errorWidget: (context, url, error) => const Icon(Icons.error),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(onPressed: (){
                    productProvider.reopenAccount(userModel.docId.toString(), (status){
                      if (status){
                        Fluttertoast.showToast(msg: "Account is Activated");
                        Get.back();
                        Get.back();
                      }
                      else{
                        Fluttertoast.showToast(msg: "Something went wrong");
                      }
                    });
                  }, child: const Text("Approve")),
                  const SizedBox(height: 10),
                  Text("User Name: ${userModel.userName!}",style: robotoStyle700Bold.copyWith(fontSize: 15)),
                  Text("Team No: ${userModel.teamNo!}",style: robotoStyle700Bold.copyWith(fontSize: 15)),
                  Text("Email: ${userModel.email!}",style: robotoStyle700Bold.copyWith(fontSize: 15)),
                  Text("Password : ${userModel.password!}",style: robotoStyle700Bold.copyWith(fontSize: 15)),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("User Nid or Birth",style: robotoStyle700Bold.copyWith(fontSize: 17),),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: CachedNetworkImage(
                      fit: BoxFit.fitWidth,
                      width: double.infinity,
                      imageUrl: userModel.nidOrBirth!,
                      progressIndicatorBuilder: (context, url, downloadProgress) => CircularProgressIndicator(value: downloadProgress.progress),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}
