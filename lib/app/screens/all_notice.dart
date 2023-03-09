import 'package:dream_touch_admin/app/controller/notice_controller.dart';
import 'package:dream_touch_admin/app/widgets/page_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllNotice extends StatelessWidget {
  AllNotice({Key? key}) : super(key: key);
  final noticeCon = Get.put(NoticeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const PageAppBar(title: "All Notice"),
        body: Obx(() => noticeCon.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : noticeCon.noticeModel.isEmpty
                ? const Center(
                    child: Text("No Notice Available"),
                  )
                : ListView.builder(
                    itemCount: noticeCon.noticeModel.length,
                    itemBuilder: (_, index) {
                      var item = noticeCon.noticeModel[index];
                      return ListTile(
                        title: Text(item.title!),
                        subtitle: Text(item.description!),
                        trailing: InkWell(
                          onTap: (){
                            noticeCon.deleteNotice(item.docId.toString(),index);
                          },
                          child: CircleAvatar(
                            backgroundColor: Colors.black,
                            child: Icon(
                              Icons.delete_forever,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      );
                    },
                  )));
  }
}
