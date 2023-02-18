import 'package:dream_touch_admin/app/controller/auth_controller.dart';
import 'package:dream_touch_admin/app/screens/home_page.dart';
import 'package:dream_touch_admin/app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../controller/auth_provider.dart';
import '../utils/text.styles.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';

class LoginPage extends StatelessWidget {
  final emailController = TextEditingController();

  final passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, authProvider, child) {
      return Scaffold(
          body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.admin_panel_settings, size: 50, color: AppColors.primaryColorLight),
            Text(
              "Admin Login",
              style: robotoStyle700Bold.copyWith(fontSize: 25),
            ),
            const SizedBox(height: 50),
            CustomTextField(
              hintText: 'Admin Email',
              isShowBorder: true,
              borderRadius: 11,
              verticalSize: 14,
              controller: emailController,
            ),
            const SizedBox(height: 20),
            CustomTextField(
              hintText: 'Admin Password',
              isShowBorder: true,
              borderRadius: 11,
              verticalSize: 14,
              controller: passController,
            ),
            const SizedBox(height: 20),
            authProvider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: CustomButton(
                      onTap: () {
                        if (emailController.text.isEmpty) {
                        } else if (passController.text.isEmpty) {
                        } else {
                          authProvider.login(emailController.text, passController.text).then((value) {
                            if (value) {
                              authProvider.saveLoginState();
                              Get.offAll(const AdminHome());
                            } else {}
                          });
                        }
                      },
                      btnTxt: "Click to Login",
                    ),
                  )
          ],
        ),
      ));
    });
  }
}
