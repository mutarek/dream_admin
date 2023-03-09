import 'package:cached_network_image/cached_network_image.dart';
import 'package:dream_touch_admin/app/utils/text.styles.dart';
import 'package:dream_touch_admin/app/widgets/page_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/visit_product_controller.dart';

class AllProducts extends StatelessWidget {
  final productCon = Get.put(VisitProductController());

  @override
  Widget build(BuildContext context) {
    productCon.getAllProducts();
    return Scaffold(
        appBar: const PageAppBar(title: "All Products"),
        body: Obx(()=>
        productCon.isLoading.value?
    const Center(
    child: CircularProgressIndicator(),
    ):ListView.builder(
    itemCount: productCon.productList.length,
      itemBuilder: (_, index) {
        var data = productCon.productList[index];
        return Container(
          padding: const EdgeInsets.all(5),
          child: Column(
            children: [
              Stack(
                children: [
                  CachedNetworkImage(
                    imageUrl: data.image!,
                    placeholder: (context, url) => const CircularProgressIndicator(),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                    height: 130,
                    width: double.infinity,
                    fit: BoxFit.fitWidth,
                  ),
                  Positioned(
                    right: 10,
                    top: 10,
                    child: InkWell(
                      onTap: (){
                        productCon.deleteProduct(data.docID.toString(),index);
                      },
                      child: const CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.delete,
                          size: 30,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    child: Column(
                      children: [
                        Text(
                          data.title!,
                          style: robotoStyle700Bold.copyWith(fontSize: 22, color: Colors.white),
                        ),
                        Text(
                          data.description!,
                          style: robotoStyle700Bold.copyWith(fontSize: 12, color: Colors.white),
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        );
      },
    )));
  }
}
