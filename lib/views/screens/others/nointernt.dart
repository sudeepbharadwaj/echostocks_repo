import 'package:echostocks/controllers/other_controller/nointerner_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';


// ignore: must_be_immutable
class NoInternt extends StatelessWidget {
   NoInternt({Key? key}) : super(key: key);

  NoInterntController noInterntController=NoInterntController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
         throw SystemNavigator.pop();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(elevation: 0,
          title: Text('No Internet',
          
          style: GoogleFonts.poppins(fontSize:14.sp,fontWeight: FontWeight.w500,color: Colors.white),),
          backgroundColor: const Color(0xFF080D13),
        ),
    
        body: SafeArea(
          minimum: EdgeInsets.only(left:2.w,right: 2.w),
          child:
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:<Widget>
          [
              LottieBuilder.asset('assets/lottie/nointernet.json',
              fit: BoxFit.fitWidth,
              height: 50.h,
              width: 100.w,
              ),
    
            
    
              SizedBox(height: 19.h,),
              
              TextButton(onPressed: (){
                noInterntController.checkinternt();

              }, child:Text('Try Again',style: GoogleFonts.poppins(fontSize:14.sp,fontWeight:FontWeight.w400,color: Colors.white),))
          ]
        )
        ),
    
      ),
    );
  }
}