import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../controllers/Splash_controller/splash_controller.dart';


// ignore: must_be_immutable
class Splash extends StatelessWidget {
   Splash({Key? key}) : super(key: key);
   

   
SplashController splashController=Get.put(SplashController(),tag: 'splash');



  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Stack(
            children: [

              GetX<SplashController>(init: splashController,
              builder: ((controller) {
                return                 Positioned(left:controller.pleft.value,top:controller.ptop.value,
                  child: Visibility(visible:splashController.txt.value,replacement: const Center(child: CircularProgressIndicator(color: Colors.white),),
                    child: LottieBuilder.asset('assets/lottie/splash.json',
                    controller: splashController.controller,
                    height: 85.h,
                    width: 88.w,
                    animate: true,
                    
                    reverse: false,
                    repeat: false,
                                
                    onLoaded: ((p0) {
                                
                    splashController.controller!.addStatusListener((status) {
                      if(status==AnimationStatus.completed){
                       
                        //splashController.animate.value=true;
                        splashController.txt.value=false;
                        splashController.pleft.value=46.w;
                        splashController.ptop.value=45.h;

                      
                      }
                      
                    });
                    
                    Timer(const Duration(milliseconds: 1000), (){
                      splashController.controller!..duration=p0.duration..forward();
                  
                    });
                    
                     
                               }),
                                
                                
                                
                                
                    ),
                  ),
                );
                
              }),

              ),


              
               

                GetX<SplashController>(init: splashController,
                builder: (controller){
                  return  Positioned(top:88.h,left:31.5.w,
                    child: AnimatedOpacity(opacity:controller.txt.isTrue?1.0:0.0 ,
                     duration: const Duration(milliseconds: 600),
                     child: Text("echostocks",
                     style: GoogleFonts.roboto(fontSize:22.sp,fontWeight: FontWeight.w600,color: Colors.white), 
                     )
                     ),
                  );
  })

            ],

          ),
        ),


    );
  }
}