import 'package:echostocks/views/screens/panels/categories_panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


import 'Feedpanel.dart';


// ignore: must_be_immutable
class Home extends StatelessWidget {
   Home({Key? key}) : super(key: key);

   PageController pagecontroller=PageController(initialPage: 1);

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.black));
    return Scaffold(
      resizeToAvoidBottomInset: false,
  
      body: PageView(controller: pagecontroller,
      
      children: const [
        Categories(),
        Feed(),
      
      ],

      )
    );
  }
}