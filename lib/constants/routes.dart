import 'package:get/get.dart';
import 'package:firebase_todolist/ui/ui.dart';
import 'package:firebase_todolist/ui/auth/auth.dart';

class AppRoutes {
  AppRoutes._();
  static final routes = [
    GetPage(name: '/', page: () => SplashUI()),
    GetPage(name: '/signin', page: () => SignInUI()),
    GetPage(name: '/signup', page: () => SignUpUI()),
    GetPage(name: '/home', page: () => HomeUI()),
    GetPage(name: '/settings', page: () => SettingsUI()),
    GetPage(name: '/reset-password', page: () => resetPasswordUI()),
    GetPage(name: '/updateprofile', page: () => UpdateProfileUI()),
    GetPage(name: '/todolist', page: () => TaskPage()),
    //GetPage(name: '/verify', page: () => VerifyEmail()),
  ];
}
