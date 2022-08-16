import 'package:echostocks/controllers/panel_controllers/bottomnav_controller.dart';
import 'package:echostocks/views/screens/panels/profile_panel.dart';
import 'package:echostocks/views/screens/panels/home.dart';
import 'package:echostocks/views/screens/panels/recos_panel.dart';
import 'package:echostocks/views/screens/panels/strategy_panel.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';


// ignore: must_be_immutable
class BottomNav extends StatelessWidget {
   BottomNav({Key? key}) : super(key: key);

   NavController navController=Get.put(NavController(),tag: 'nav');



  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        throw SystemNavigator.pop();
      },
      child: Scaffold(
        extendBody: true,
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
         bottomNavigationBar:buildnavbaritems(),
        
        body:GetX<NavController>(
          init: navController,
          builder: (controller) {
          return buildpages(controller.selectedindex.value);
        },)
       
      ),
    );

  }

  Widget buildnavbaritems(){
    return GetX<NavController>(init: navController,

    builder: ((controller) {
      return SlideTransition( position: Tween<Offset>(begin: Offset.zero, end: const Offset(0, 1)).animate(
        CurvedAnimation(parent: controller.controller!, curve: Curves.fastOutSlowIn),
      ),
        child: FloatingNavbar(currentIndex: controller.selectedindex.value,
        backgroundColor: const Color.fromARGB(255, 8, 13, 19),
        iconSize: 25,
        fontSize: 11.5.sp,
        

        items: [
          FloatingNavbarItem(icon: Icons.article, title: 'Feed'),
          FloatingNavbarItem(icon: Icons.bolt, title: 'Recos'),
          FloatingNavbarItem(icon: Icons.emoji_objects, title: 'Strategies'),
        ],
        onTap:((val) {
          controller.selectedindex.value=val;
          
        }
        



         
         )
         )
      );
    }),
    );
  }


  
  Widget buildpages(var controller){
  switch (controller){
    case 2:
    return  Strategy();
    case 1:
    return Recos();
    
    case 0:
    return Home();
    default:
    return Home() ;
  
    }
  }


}