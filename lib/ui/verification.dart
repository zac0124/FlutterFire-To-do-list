import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_todolist/controllers/controllers.dart';
import 'package:firebase_todolist/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/utils.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({Key? key}) : super(key: key);

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  bool isEmailVerified = false;

  Timer? timer;
  @override
  void initState() {
    super.initState();
    if (isEmailVerified == null) {
      sendEmail();

      timer = Timer.periodic(
        Duration(seconds: 3),
        (_) => checkEmail(),
      );
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future checkEmail() async {
    await FirebaseAuth.instance.currentUser!.reload();

    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
  }

  Future sendEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      await user?.sendEmailVerification();
    } catch (e) {
      print('error verification');
    }
  }

  @override
  Widget build(BuildContext context) => isEmailVerified
      ? HomeUI()
      : Scaffold(
          appBar: AppBar(title: Text('Verify')),
        );
}
