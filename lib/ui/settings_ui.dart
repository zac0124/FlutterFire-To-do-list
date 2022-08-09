import 'package:firebase_todolist/controllers/controllers.dart';
import 'package:firebase_todolist/models/models.dart';
import 'package:firebase_todolist/ui/auth/auth.dart';
import 'package:firebase_todolist/ui/components/dropdown_picker.dart';
import 'package:firebase_todolist/ui/components/segmented_selector.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_todolist/constants/constants.dart';

class SettingsUI extends StatelessWidget {
  const SettingsUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('settings.title'.tr),
      ),
      body: _buildLayoutSection(context),
    );
  }

  Widget _buildLayoutSection(BuildContext context) {
    return ListView(
      children: [
        languageListTile(context),
        themeListTile(context),
        ListTile(
          title: Text('settings.updateProfile'.tr),
          trailing: ElevatedButton(
            onPressed: () async {
              Get.to(UpdateProfileUI());
            },
            child: Text('settings.updateProfile'.tr),
          ),
        ),
        ListTile(
          title: Text('settings.signOut'.tr),
          trailing: ElevatedButton(
            onPressed: () async {
              AuthController.to.signOut();
            },
            child: Text('settings.signOut'.tr),
          ),
        ),
      ],
    );
  }

  languageListTile(BuildContext context) {
    return GetBuilder<LanguageController>(
      builder: (controller) => ListTile(
        title: Text('settings.language'.tr),
        trailing: DropDownPicker(
          menuOptions: Globals.languageOptions,
          selectedOption: controller.currentLanguage,
          onChanged: (value) async {
            await controller.updateLanguage(value!);
            Get.forceAppUpdate();
          },
        ),
      ),
    );
  }

  themeListTile(BuildContext context) {
    final List<MenuOptionsModel> themeOptions = [
      MenuOptionsModel(
          key: "system", value: 'settings.system'.tr, icon: Icons.brightness_4),
      MenuOptionsModel(
          key: "light", value: 'settings.light'.tr, icon: Icons.brightness_low),
      MenuOptionsModel(
          key: "dark", value: 'settings.dark'.tr, icon: Icons.brightness_3),
    ];
    return GetBuilder<ThemeController>(
      builder: (controller) => ListTile(
        title: Text('settings.theme'.tr),
        trailing: SegmentedSelector(
          menuOptions: themeOptions,
          selectedOption: controller.currentTheme,
          onValueChanged: (value) {
            controller.setThemeMode(value);
          },
        ),
      ),
    );
  }
}
