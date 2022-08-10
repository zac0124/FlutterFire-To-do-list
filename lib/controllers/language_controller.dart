import 'package:flutter/material.dart';
import 'package:firebase_todolist/constants/globals.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'dart:ui' as ui;
import 'dart:core';

class LanguageController extends GetxController {
  static LanguageController get to => Get.find();
  final language = "".obs;
  final store = GetStorage();

  String get currentLanguage => language.value;

  @override
  void onReady() async {
    super.onInit();
  }

  setInitialLocalLanguage() {
    if (currentLanguageStore.value == '') {
      String _deviceLanguage = ui.window.locale.toString();
      _deviceLanguage = _deviceLanguage.substring(0, 2);
      updateLanguage(_deviceLanguage);
    }
  }

  RxString get currentLanguageStore {
    language.value = store.read('language') ?? '';
    return language;
  }

  Locale? get getLocale {
    if (currentLanguageStore.value == '') {
      language.value = Globals.defaultLanguage;
      updateLanguage(Globals.defaultLanguage);
    } else if (currentLanguageStore.value != '') {
      return Locale(currentLanguageStore.value);
    }
    return Get.deviceLocale;
  }

  Future<void> updateLanguage(String value) async {
    language.value = value;
    await store.write('language', value);
    if (getLocale != null) {
      Get.updateLocale(getLocale!);
    }
    update();
  }
}
