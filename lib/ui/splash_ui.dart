import 'package:flutter/material.dart';

class SplashUI extends StatelessWidget {
  const SplashUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text('test'),
          //child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
