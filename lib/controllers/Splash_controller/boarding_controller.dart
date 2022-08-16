import 'dart:async';
import 'package:echostocks/controllers/DB_controller/check_controller.dart';
import 'package:echostocks/views/screens/splash/detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Boardingcontroller extends GetxController{

  RxInt initialpage=0.obs;
  RxBool opacityvisible=false.obs;

  PageController? pageController;

  RxBool checkbox=false.obs;

  Rx<Color> chrckboxclr=Colors.white.obs;

  Rx<Color> txtbtncolor=const Color(0xff48C9B0).obs;

  RxString txtbtn="Let's Get Started".obs;

  RxBool btnvisibile=false.obs;

CheckDBHelper checkDBHelper=CheckDBHelper();

  @override
  void onInit(){
    super.onInit();
    pageController=PageController(initialPage: 0);
    startboarding();

  }


  void chngscr()async{
    if(checkbox.isFalse){
      chrckboxclr.value=Colors.red;
      txtbtncolor.value=const Color.fromARGB(255, 198, 101, 94);
      txtbtn.value='Tick the checkbox to continue';

      await Future.delayed(const Duration(milliseconds:1800));
      txtbtncolor.value=const Color(0xff48C9B0);
      txtbtn.value="Let's Get Started";



    }
    else{
      await checkDBHelper.updatedatawithkey('boarding', 1);
      Get.off(UsrDetail());


    }
  }


  void startboarding()async{
    
    await Future.delayed(const Duration(milliseconds: 500));
    opacityvisible.value=true;
    Timer.periodic(const Duration(milliseconds: 4000),(timer){
      if(initialpage<3){
      initialpage++;
    }
    else{
      initialpage.value=0;
    }

    if(initialpage.value==2){
      btnvisibile.value=true;
    }
      WidgetsBinding.instance.addPostFrameCallback((_) {
      if(pageController!.hasClients){
        pageController!.animateToPage(initialpage.value, duration: const Duration(milliseconds: 1500), curve: Curves.decelerate);
              
      }
     
});
       
   

    });
    
   
  }
}