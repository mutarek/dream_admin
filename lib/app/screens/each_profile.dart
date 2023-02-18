import 'package:cached_network_image/cached_network_image.dart';
import 'package:dream_touch_admin/app/utils/text.styles.dart';
import 'package:dream_touch_admin/app/widgets/custom_button.dart';
import 'package:dream_touch_admin/app/widgets/page_app_bar.dart';
import 'package:flutter/material.dart';

import '../model/user_model.dart';

class EachProfilePage extends StatelessWidget {
  const EachProfilePage(this.userModel, {Key? key}) : super(key: key);
  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PageAppBar(
        title: userModel.userName,
      ),
      body: ListView(
        children: [
          SizedBox(height: 10),
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
              child: Text("Team No: ${userModel.teamNo!}",style: robotoStyle700Bold.copyWith(fontSize: 20))),
          SizedBox(height: 30),
          Row(
            children: const [
              Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.all(3),
                    child: CustomButton(btnTxt: "Add Report")),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.all(3),
                  child: CustomButton(btnTxt: "Add Resort"),
                ),
              )
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: const [
              Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.all(3),
                    child: CustomButton(btnTxt: "Add Notice")),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.all(3),
                  child: CustomButton(btnTxt: "Success Report"),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
