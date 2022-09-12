import 'package:firebase_todolist/controllers/controllers.dart';
import 'package:firebase_todolist/ui/auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_todolist/ui/components/components.dart';
import 'package:firebase_todolist/ui/ui.dart';
import 'package:get/get.dart';

class HomeUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      init: AuthController(),
      builder: ((controller) => controller.firestoreUser.value?.uid == null
          ? Center(
              child: SignInUI(),
            )
          : Scaffold(
              appBar: AppBar(
                title: Text('home.title'.tr),
                actions: [
                  IconButton(
                    onPressed: () {
                      Get.to(SettingsUI());
                    },
                    icon: Icon(Icons.settings),
                  ),
                ],
              ),
              body: Center(
                  child: Column(
                children: [
                  SizedBox(
                    height: 120,
                  ),
                  Avatar(controller.firestoreUser.value!),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FormVerticalSpace(),
                      Text(
                        'home.uidLabel'.tr +
                            ': ' +
                            controller.firestoreUser.value!.uid,
                        style: TextStyle(fontSize: 16),
                      ),
                      FormVerticalSpace(),
                      Text(
                        'home.nameLabel'.tr +
                            ': ' +
                            controller.firestoreUser.value!.name,
                        style: TextStyle(fontSize: 16),
                      ),
                      FormVerticalSpace(),
                      Text(
                        'home.emailLabel'.tr +
                            ': ' +
                            controller.firestoreUser.value!.email,
                        style: TextStyle(fontSize: 16),
                      ),
                      FormVerticalSpace(),
                      Text(
                        'home.adminLabel'.tr +
                            ': ' +
                            controller.admin.value.toString(),
                        style: TextStyle(fontSize: 16),
                      ),
                      FormVerticalSpace(),
                      PrimaryButton(
                        labelText: 'Start creating tasks'.tr,
                        onPressed: () => Get.to(TaskPage()),
                      ),
                    ],
                  )
                ],
              )),
            )),
    );
  }
}
