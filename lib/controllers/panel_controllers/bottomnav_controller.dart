import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:echostocks/controllers/DB_controller/check_controller.dart';
import 'package:echostocks/views/screens/others/nointernt.dart';
import 'package:flutter/animation.dart';
import 'package:get/get.dart';

class NavController extends GetxController with GetSingleTickerProviderStateMixin{

  RxInt selectedindex=0.obs;

   RxBool visible =false.obs;

  AnimationController? controller;

  StreamSubscription? connectivitySubscription;

  CheckDBHelper checkDBHelper=CheckDBHelper();

 ConnectivityResult? oldres;

  @override
  void onInit(){
    super.onInit();
    selectedindex.value=checkDBHelper.getdatawithkey('defaultab');
    
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    controller!.forward();

    
   connectivitySubscription=Connectivity().onConnectivityChanged.listen((ConnectivityResult resnow) {
      if(resnow==ConnectivityResult.none){
      
        Get.to(NoInternt());
        
      

      }else if (oldres==ConnectivityResult.none){

         
        

        
      }

     
     
      oldres=resnow;
   });
  }



  

 


 

  void onTap(int index){
   
    selectedindex.value=index;

  }
}