import 'package:echostocks/controllers/DB_controller/check_controller.dart';
import 'package:echostocks/models/snackbar.dart';
import 'package:echostocks/views/screens/panels/bottomnav.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class UsrDetail extends StatelessWidget {
   UsrDetail({Key? key}) : super(key: key);

   TextEditingController name=TextEditingController();

   CheckDBHelper checkDBHelper=CheckDBHelper();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(minimum: EdgeInsets.only(top:3.h,left: 4.w),
 
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
    Padding(
      padding:EdgeInsets.only(left: 26.6.w),
      child: Text("echostocks",style: GoogleFonts.roboto(fontSize:22.sp,fontWeight: FontWeight.w700,color: Colors.white,letterSpacing: 1),),
    ),
              SizedBox(height: 5.h,),
              Text("Welcome on echostocks",
    
              style: GoogleFonts.roboto(fontSize:16.sp,fontWeight: FontWeight.w600,color: Colors.white,letterSpacing: 1),),

              SizedBox(height: 0.4.h,),



              Text("what can we call you?",
    
              style: GoogleFonts.roboto(fontSize:13.sp,fontWeight: FontWeight.w300,color: Colors.grey,letterSpacing: 1),),

              Container(margin: EdgeInsets.only(top:6.h,left: 2.w),
              
                   height: 8.h,width: 85.w,
                   padding: EdgeInsets.only(top:0.9.h),
                   decoration: BoxDecoration(
                     color:const Color.fromARGB(31, 255, 255, 255),
                     borderRadius: BorderRadius.circular(15.0),
                     border: Border.all(color: const Color.fromARGB(221, 37, 36, 36),style: BorderStyle.solid),
        
                   ),
                   child: TextField(
                    controller: name,
                  
                    cursorColor: Colors.white,textInputAction: TextInputAction.done,maxLength: 10,
                     decoration: InputDecoration(
                       hintText: "Your name",
                       hintStyle: GoogleFonts.roboto(fontSize:13.7.sp,color:const Color.fromARGB(255, 247, 238, 238),fontWeight: FontWeight.w600,letterSpacing: 0.7),
                       border: InputBorder.none,
                      counterText: "",
                       disabledBorder: InputBorder.none,
                       errorBorder: InputBorder.none,
                       focusedBorder: InputBorder.none,
                       focusedErrorBorder: InputBorder.none,
                       prefixIcon: Icon(Icons.person,size:25.sp,color:const Color.fromARGB(255, 247, 238, 238)),
                     ),
                     style: GoogleFonts.roboto(fontSize:13.7.sp,color:const Color.fromARGB(255, 247, 238, 238),fontWeight: FontWeight.w600,letterSpacing: 0.7),
        
                   ),
                 ),

                 SizedBox(height: 10.h,),
                  Padding(
                    padding: EdgeInsets.only(left: 9.5.w),
                    child: Material(color: Colors.transparent,
                                                  child: GestureDetector(onTap: ()async{
                                                    
                                                    if(name.text.isEmpty){
                                                      snackbar('name error', 
                                                      'please enter your name',Icons.error
                                                      );
                                                    }
                                                    else{
                                                      await checkDBHelper.updatedatawithkey('detail', name.text);
                                                      Get.to(BottomNav());
                                                    }
                                                    
                                                    
                                                  },
                                                     
                                                      child: Container(
                                                        height: 8.h,width:70.w,
                                                        decoration: BoxDecoration(
                                                         gradient: const LinearGradient(colors: [
                                                            Color.fromARGB(255, 99, 247, 217),
                                   Color.fromARGB(255, 155, 251, 230)
                                    
                                                         ]),
                                                          shape:BoxShape.rectangle,
                                                          borderRadius: BorderRadius.circular(20.0)
                                                                                        
                                                        ),
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                          Padding(
                                                            padding:EdgeInsets.only(left:5.w),
                                                            child: Text("next step",style: GoogleFonts.poppins(fontSize:15.sp,fontWeight: FontWeight.w500,color:Colors.black),),
                                                          ),
                                                          Container(height: 5.h,width: 20.w,
                                                          decoration: const BoxDecoration(
                                                            shape:BoxShape.circle,
                                                            gradient: LinearGradient(colors: [
                                                              Color.fromARGB(255, 255, 171, 114),
                                                               Color.fromARGB(255, 246, 241, 238),
                                                            ])
                                                          ),
                                                          child: const Icon(Icons.arrow_forward),
                                                          
                                                          )
                                                          
                                                        ],)
                                                        ,),
                                                    
                                                  ),
                                                ),
                  ),
                 
                  
            ],
          
        )
      ),
    );
  }
}