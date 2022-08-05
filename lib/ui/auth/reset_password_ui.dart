import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:firebase_todolist/ui/auth/auth.dart';
import 'package:firebase_todolist/ui/components/form_input_field_with_icon.dart';

class resetPasswordUI extends StatelessWidget {
  final AuthControl
  const resetPasswordUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(context),
      body: Form(key: _formKey,
      child: Padding(padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Center(child: SingleChildScrollView(child: Column(mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        LogoGraphicHeader();
        SizedBox(height: 48.0),
        FormInputFieldWithIcon(
          controller: 
        )
      ],
      ),)),),
    );
  }
}
