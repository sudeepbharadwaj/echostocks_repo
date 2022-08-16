
import 'package:echostocks/controllers/DB_controller/check_controller.dart';
import 'package:echostocks/controllers/panel_controllers/Feed_controller.dart';
import 'package:echostocks/controllers/panel_controllers/bottomnav_controller.dart';
import 'package:echostocks/views/screens/others/category_details.dart';
import 'package:echostocks/views/screens/panels/strategy_panel.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:google_fonts/google_fonts.dart';



class Categories extends StatefulWidget {
  const  Categories({Key? key}) : super(key: key);




  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {

  NavController navController=Get.find(tag: 'nav');
  FeedController feedController=Get.find(tag: 'feed');

  CheckDBHelper checkDBHelper=CheckDBHelper();
  

  
   String greeting = ""; 

  @override
  void initState(){
    super.initState();
    navController.controller!.forward();
    feedController.controller!.forward();
    checktime();
   


  }

  void checktime(){
    DateTime now = DateTime.now();
     
    int hours= now.hour;


    if(hours>=1 && hours<12){ 
    greeting = "Good Morning"; 
    } else if(hours>=12 && hours<16){
     greeting = "Good Afternoon"; 
    } else if(hours>=16 && hours<21){ 
    greeting = "Good Evening";
     } else if(hours>=21 && hours<=24){ 
       greeting = "Good Night"; 
    }



  }

 


  @override
  Widget build(BuildContext context) {

    return Scaffold(extendBody: true,
    backgroundColor: Colors.black,

      resizeToAvoidBottomInset: false,
      body: 
        SingleChildScrollView(scrollDirection: Axis.vertical,
          child: Padding(
            padding: EdgeInsets.only(top:5.h,right: 4.5.w,left: 4.5.w),
            child: Column(
              children: <Widget>[
              
                             Container(padding: EdgeInsets.only(top:2.h),
                           
                              height: 25.h,
                              width: 95.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: const Color.fromARGB(255, 12, 22, 32),

                                
                                
                              ),
                  
                              child: Padding(
                                padding:EdgeInsets.only(top:0.h),
                                child: Column(crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                              
                                              Container(
                                                height: 14.h,
                                                width: 40.w,
                                                decoration: const BoxDecoration(
                                                  color: Colors.black26,
                                                  boxShadow: [
            BoxShadow(
                color: Color.fromARGB(255, 17, 23, 34),
                blurRadius: 11.0,
                spreadRadius: 0.0,
                offset: Offset(2.0, 2.0), // shadow direction: bottom right
            )
        ],

                                                
                                                  shape: BoxShape.circle
                                                ),
                                                child: Image.asset('assets/img/profile.png',

                                    ),
                                              ),

                              
                                  Padding(
                                    padding:  EdgeInsets.only(top:1.h),
                                    child: Text('Hello! ${checkDBHelper.getdatawithkey('detail')}',textAlign: TextAlign.center,
                                    maxLines: 2,overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.poppins(fontSize: 15.sp,fontWeight: FontWeight.w400,color: const Color.fromARGB(255, 223, 231, 241),letterSpacing: 0.3),),
                  
                                  ),

                                  Text(greeting,textAlign: TextAlign.center,
                                    maxLines: 2,overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.poppins(fontSize: 10.sp,fontWeight: FontWeight.w400,color: const Color.fromARGB(255, 223, 231, 241)),),
          
          
          
                              
                                  
                  
                                      
                                     ],),
                              ),
                                
                            ),
                          
          
                          SizedBox(height: 3.h,),
          
                          
          
          
                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget> [
                              InkWell(onTap:(){

                                Get.to(const CategoryDetail(),arguments: 'Technical Analysis');
                   
                                
                                

                              },
                                child: Container(padding: EdgeInsets.only(left: 2.w,right: 2.w),
                                  height: 17.h,
                                  width: 42.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                     color: const Color.fromARGB(255, 12, 22, 32),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                       Image.asset('assets/img/analysis.png',
                                      height: 9.h,width: 22.w,
                                      ),
                                     // SizedBox(height: 3.h,),
                                      Text('Technical Analysis',textAlign: TextAlign.center,
                                      style: GoogleFonts.poppins(fontSize:13.sp,fontWeight: FontWeight.w400,color:Colors.white,),
                                      )
                              
                                  ],),
                                ),
                              ),
          
                              InkWell(onTap:(){
                                Get.to(const CategoryDetail(),arguments: 'Top Investors');

                              },
                                child: Container(padding: EdgeInsets.only(left: 2.w,right: 2.w),
                                  height: 17.h,
                                  width: 42.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: const Color.fromARGB(255, 12, 22, 32),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Image.asset('assets/img/investor.png',
                                      height: 7.h,width: 20.w,
                                      ),
                                     // SizedBox(height: 3.h,),
                                      Text('Top Investors',textAlign: TextAlign.center,
                                      style: GoogleFonts.poppins(fontSize:13.sp,fontWeight: FontWeight.w400,color:Colors.white,),
                                      )
                              
                                  ],),
                                ),
                              )
          
                            ],
                          ),
          
                          SizedBox(height: 2.8.h,),
          
                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget> [
                              InkWell(onTap: (){
                                 Get.to(const CategoryDetail(),arguments: 'Results');
                              },
                                child: Container(padding: EdgeInsets.only(left: 2.w,right: 2.w),
                                  height: 17.h,
                                  width: 42.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: const Color.fromARGB(255, 12, 22, 32),
                                  ),
                                  
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Image.asset('assets/img/result.png',
                                      height: 9.h,width: 30.w,
                                      ),
                                     // SizedBox(height: 3.h,),
                                      Text('Results',textAlign: TextAlign.center,
                                      style: GoogleFonts.poppins(fontSize:13.sp,fontWeight: FontWeight.w400,color:Colors.white,),
                                      )
                              
                                  ],),
                                ),
                              ),
          
                              InkWell(onTap: (){
                                 Get.to(const CategoryDetail(),arguments: 'Tools');
                              },
                                child: Container(padding: EdgeInsets.only(left: 2.w,right: 2.w),
                                  height: 17.h,
                                  width: 42.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                     color: const Color.fromARGB(255, 12, 22, 32),
                                  ),
                                  
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Image.asset('assets/img/tools.png',
                                      height: 9.h,width: 30.w,
                                      ),
                                     // SizedBox(height: 3.h,),
                                      Text('Tools',textAlign: TextAlign.center,
                                      style: GoogleFonts.poppins(fontSize:13.sp,fontWeight: FontWeight.w400,color:Colors.white,),
                                      )
                              
                                  ],),
                                ),
                              )
          
                            ],
                          ),


                            SizedBox(height: 2.8.h,),
          
                          
          
          
                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget> [
                              InkWell(onTap: () {
                                 Get.to(Strategy());
                              },
                                child: Container(padding: EdgeInsets.only(left: 2.w,right: 2.w),
                                  height: 17.h,
                                  width: 42.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                     color: const Color.fromARGB(255, 12, 22, 32),
                                  ),
                                  
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Image.asset('assets/img/strategy.png',
                                    
                                      height: 9.h,width: 30.w,
                                      ),
                                     // SizedBox(height: 3.h,),
                                      Text('Strategies',textAlign: TextAlign.center,
                                      style: GoogleFonts.poppins(fontSize:13.sp,fontWeight: FontWeight.w400,color:Colors.white,),
                                      )
                              
                                  ],),
                                ),
                              ),
          
                              InkWell(onTap: (){
                                 Get.to(const CategoryDetail(),arguments: 'Quick Learn');
                              },
                                child: Container(padding: EdgeInsets.only(left: 2.w,right: 2.w),
                                  height: 17.h,
                                  width: 42.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                     color: const Color.fromARGB(255, 12, 22, 32),
                                  ),child:
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Image.asset('assets/img/learn.png',
                                    
                                      height: 9.h,width: 30.w,
                                      ),
                                     
                                      Text('Quick Learn',textAlign: TextAlign.center,
                                      style: GoogleFonts.poppins(fontSize:13.sp,fontWeight: FontWeight.w400,color:Colors.white,),
                                      )
                              
                                  ],),
                              
                                ),
                              )
          
                            ],
                          ),
                  
                  
              ],
            ),
          ),
        ) 
      
    );
  }
}