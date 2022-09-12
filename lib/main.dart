import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_todolist/constants/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';
import 'ui/todo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_todolist/helpers/helpers.dart';
import 'package:get_storage/get_storage.dart';
import 'package:firebase_todolist/ui/components/components.dart';
import 'package:firebase_todolist/constants/constants.dart';
import 'package:firebase_todolist/controllers/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   runApp(App());
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await GetStorage.init();
  Get.put<AuthController>(AuthController());
  Get.put<ThemeController>(ThemeController());
  Get.put<LanguageController>(LanguageController());
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ThemeController.to.getThemeModeFromStore();
    return GetBuilder<LanguageController>(
        builder: (languageController) => Loading(
              child: GetMaterialApp(
                translations: Localization(),
                locale: languageController.getLocale,
                navigatorObservers: [],
                debugShowCheckedModeBanner: false,
                theme: AppThemes.lightTheme,
                darkTheme: AppThemes.darkTheme,
                themeMode: ThemeMode.system,
                initialRoute: "/signin",
                getPages: AppRoutes.routes,
              ),
            ));
  }
}
