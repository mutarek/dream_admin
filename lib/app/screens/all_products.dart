import 'package:dream_touch_admin/app/widgets/page_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/visit_product_controller.dart';

class AllProducts extends StatelessWidget {
  AllProducts({Key? key}) : super(key: key);
  final productCon = Get.put(VisitProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PageAppBar(title: "All Products"),
      body: productCon.isLoading.value?
      Center(
        child: CircularProgressIndicator(),
      ):productCon.productList.isEmpty?
          Center(
            child: Text("No products found."),
          ):
          GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemCount: productCon.productList.length,
            itemBuilder: (_,index){
              return Container(
                child: Text(productCon.productList[index].title!),
              );
            },
          )
    );
  }
}
