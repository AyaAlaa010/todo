import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LayoutView extends StatelessWidget {

  static String routeName="LayoutView";
  const LayoutView({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.red,
      ),
    );
  }
}
