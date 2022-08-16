import 'package:echostocks/views/screens/others/T&C.dart';
import 'package:echostocks/views/screens/others/privacy_policy.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../controllers/Splash_controller/boarding_controller.dart';

// ignore: must_be_immutable
class BoardingScr extends StatelessWidget {
  BoardingScr({Key? key}) : super(key: key);

  Boardingcontroller boardingcontroller = Boardingcontroller();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        minimum: EdgeInsets.only(left: 0.w, right: 3.w, top: 3.h, bottom: 3.h),
        child: Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: GetX<Boardingcontroller>(
                  init: boardingcontroller,
                  builder: (controller) {
                    return AnimatedOpacity(
                      duration: const Duration(milliseconds: 2000),
                      opacity: controller.opacityvisible.isTrue ? 1.0 : 0.0,
                      child: Padding(
                        padding: EdgeInsets.only(left: 4.w),
                        child: PageView(physics: const NeverScrollableScrollPhysics(),
                         controller: boardingcontroller.pageController,
                          children: [
                            boarding1(context),
                            
                            boarding2(context),
                            boarding3(context)
                          ],
                        ),
                      ),
                    );
                  }),
            ),
           GetX<Boardingcontroller>(
                  init: boardingcontroller,
                  builder: (controller) {
                    return AnimatedOpacity(
                      opacity: controller.opacityvisible.isTrue ? 1.0 : 0.0,
                      duration: const Duration(seconds: 2),
                      child: Row(mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AnimatedContainer(
                            duration: const Duration(seconds: 1),
                            height: 1.4.h,
                            width: (controller.initialpage.value == 0)
                                ? 6.w
                                : 2.8.w,
                            decoration: BoxDecoration(
                                color: (controller.initialpage.value == 0)
                                    ? Colors.white
                                    : Colors.white54,
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(8)),
                          ),
                          AnimatedContainer(
                            duration: const Duration(seconds: 1),
                            height: 1.4.h,
                            width: (controller.initialpage.value == 1)
                                ? 6.w
                                : 2.8.w,
                            margin: EdgeInsets.only(left: 3.w, right: 3.w),
                            decoration: BoxDecoration(
                                color: (controller.initialpage.value == 1)
                                    ? Colors.white
                                    : Colors.white54,
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(8)),
                          ),
                          AnimatedContainer(
                            duration: const Duration(seconds: 1),
                            height: 1.4.h,
                            width: (controller.initialpage.value == 2)
                                ? 6.w
                                : 2.8.w,
                            decoration: BoxDecoration(
                                color: (controller.initialpage.value == 2)
                                    ? Colors.white
                                    : Colors.white54,
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(8)),
                          )
                        ],
                      ),
                    );
                  }),
            

            
              Padding(
                padding:  EdgeInsets.only(top:3.h,bottom: 1.h),
                child: GetX<Boardingcontroller>(init: boardingcontroller,
                builder: (controller) {
                  return AnimatedOpacity(opacity:controller.btnvisibile.isTrue?1.0:0.0,duration:const Duration(seconds: 2),
                    child: Visibility(visible: controller.btnvisibile.value,
                    
                      child: Column(mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                               //crossAxisAlignment: CrossAxisAlignment.center,
                           
                            children: [
                            Theme(data: Theme.of(context).copyWith(
                                  unselectedWidgetColor:controller.chrckboxclr.value,
                                ),
                                  child: Checkbox(value: controller.checkbox.value, onChanged: (value){
                                    controller.checkbox.value=value!;
                                    
                                  },
                                  activeColor: const Color.fromARGB(255, 99, 247, 217),
                                  checkColor: Colors.white,
                                  
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4)
                                  ),
                                
                                  
                                  ),
                                 
                                ),
                      
                              Column(
                                //mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  
                                  
                                children: [
                                  Row(
                                    //mainAxisAlignment: MainAxisAlignment.start,
                                  //crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                             Padding(
                               padding:EdgeInsets.only(right: 1.5.w),
                               child: Text('I have read and agreed to the'
                                 ,style: GoogleFonts.roboto(fontSize:10.4.sp,color: Colors.white),
                                 ),
                             ),
                              InkWell(onTap:(){
                                Get.to(const Policy());
                              },
                                child: Text('Privacy Policy,'
                                 ,style: GoogleFonts.roboto(fontSize:10.5.sp,color:const Color.fromARGB(255, 99, 247, 217),fontWeight: FontWeight.w600),
                                 ),
                              ),
                                  
                                    ],
                                  ),
                                  
                                  InkWell(onTap: (){
                                    Get.to(const TC());
                                  },
                                    child: Text('Terms & Conditions'
                                    ,style: GoogleFonts.roboto(fontSize:10.5.sp,color:const Color.fromARGB(255, 99, 247, 217),fontWeight: FontWeight.w600),
                                                         ),
                                  ),
                                  
                                 
                                  
                                  
                                  
                                ]
                                  
                              ),
                                  
                                  
                          ],),
                          SizedBox(height: 1.6.h,),
                           Material(color: Colors.transparent,
                                                    child: GestureDetector(onTap: (){
                                                 
                                                      boardingcontroller.chngscr();
                                                      
                                                      
                                                    },
                                                       
                                                        child: Container(
                                                          height: 8.h,width:80.w,
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
                                                              child: Text("Let's Get Started",style: GoogleFonts.poppins(fontSize:15.sp,fontWeight: FontWeight.w500,color:Colors.black),),
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
                      
                        ]
                      ),
                    ),
                  );
                }),
              )
            
          ],
        ),
      ),
    );
  }


  Widget boarding1(BuildContext context){
    return Column(crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
                            "Learn Technical Analysis",
                            style: GoogleFonts.poppins(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                letterSpacing: 1.2),
                            textAlign: TextAlign.center,
                          ),

                          Padding(padding: EdgeInsets.only(top:2.h),
                            child: Text("Get skilled in Technical Analysis through our daily ideas and quick bytes. Learn from our experts decoding stock activities.",
                            style: GoogleFonts.poppins(fontWeight: FontWeight.w400,fontSize:11.sp,color: Colors.white),
                            textAlign: TextAlign.center,
                            
                            ),
                          ),
                          SizedBox(height: 5.h,),

                          Image.asset('assets/img/boarding1.png',
                          height: 45.h,

                          width: 90.w,
                          )
      ],
    );

  }


  Widget boarding2(BuildContext context){
    return Column(crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
                            "STOCK Recommendations at your Fingertips",
                            style: GoogleFonts.poppins(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                letterSpacing: 1.2),
                            textAlign: TextAlign.start,
                          ),

                          Padding(padding: EdgeInsets.only(top:2.h),
                            child: Text("Get what D-Street experts are suggesting to Buy, Sell or Hold. Presented with Summary of their Analysis, Horizon, Target and Potential Gain.",
                            style: GoogleFonts.poppins(fontWeight: FontWeight.w400,fontSize:11.sp,color: Colors.white),
                            textAlign: TextAlign.center,
                            
                            ),
                          ),
                          SizedBox(height: 5.h,),

                          Image.asset('assets/img/boarding2.png',
                          height: 45.h,

                          width: 90.w,
                          )
      ],
    );

  }

  Widget boarding3 (BuildContext context){
    return Column(crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
                            "Track Results",
                            style: GoogleFonts.poppins(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                letterSpacing: 1.2),
                            textAlign: TextAlign.start,
                          ),

                          Padding(padding: EdgeInsets.only(top:2.h),
                            child: Text('"Results drive the momentum" \n Get the summary of key result metrics simplified for you to make data driven decisions.',
                            style: GoogleFonts.poppins(fontWeight: FontWeight.w400,fontSize:11.sp,color: Colors.white),
                            textAlign: TextAlign.center,
                            
                            ),
                          ),
                          SizedBox(height: 5.h,),

                          Image.asset('assets/img/boarding3.png',
                          height: 45.h,

                          width: 90.w,
                          )
      ],
    );

  }
}


