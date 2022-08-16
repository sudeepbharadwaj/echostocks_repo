

import 'package:echostocks/models/snackbar.dart';
import 'package:echostocks/views/screens/others/T&C.dart';
import 'package:echostocks/views/screens/others/privacy_policy.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share/share.dart';
import 'package:sizer/sizer.dart';

import 'package:url_launcher/url_launcher_string.dart';

import '../../../controllers/DB_controller/check_controller.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  CheckDBHelper checkDBHelper=CheckDBHelper();
  

   String greeting = ""; 

   int? cheeck;

   final rateus='https://stackoverflow.com/questions/43149055/how-do-i-open-a-web-browser-url-from-my-flutter-code';


  @override
  void initState(){
    super.initState();
    
    cheeck=checkDBHelper.getdatawithkey('defaultab');
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

  Color changclr(){
    if(cheeck==0){
      return Colors.white;
    }
    return Colors.blue;

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      backgroundColor: Colors.black,
      appBar: AppBar(elevation: 0,leading: 
      InkWell
      (onTap: (){
         SystemNavigator.pop();
      },
        child: const Icon(Icons.arrow_back,color: Colors.white,)),
        title: Text('Profile',style: GoogleFonts.poppins(fontSize:14.sp,fontWeight: FontWeight.w500,color: Colors.white),),
      ),

      body: SafeArea(minimum: EdgeInsets.only(top:1.h,bottom: 1.5.h,right: 4.w,left: 4.w),
        
        child:SingleChildScrollView(scrollDirection: Axis.vertical,
          child: Column(crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              
                               Container(padding: EdgeInsets.only(top:2.h),
                             
                                height: 25.h,
                                width: 99.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  gradient:const  LinearGradient(
                                    colors:[
                                      Color.fromARGB(255, 15, 18, 22),
                                                  Color.fromARGB(255, 11, 16, 22),
                                      
                                    ]
                                     ),
                    
                                  
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
                  color: Color.fromARGB(255, 4, 8, 14),
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
                                      child: Text('Hello! '+checkDBHelper.getdatawithkey('detail').toString(),textAlign: TextAlign.center,
                                      maxLines: 2,overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.poppins(fontSize: 15.sp,fontWeight: FontWeight.w400,color: const Color.fromARGB(255, 223, 231, 241),letterSpacing: 0.3),),
                    
                                    ),
        
                                    Text(greeting,textAlign: TextAlign.center,
                                      maxLines: 2,overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.poppins(fontSize: 10.sp,fontWeight: FontWeight.w400,color: const Color.fromARGB(255, 223, 231, 241)),),
            
            
            
                                
                                    
                    
                                        
                                       ],),
                                ),
                                  
                              ),
        
                              Container(
                                margin: EdgeInsets.only(top: 3.h),
                                height: 24.h,width: 95.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                  gradient:const  LinearGradient(
                                    colors:[
                                      Color.fromARGB(255, 15, 18, 22),
                                                  Color.fromARGB(255, 11, 16, 22),
                                      
                                    ]
                                     ),
                    
                                
                              ),
                                child: Column(crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Select Default Tab',
                                    style: GoogleFonts.poppins(fontSize:11.sp,fontWeight: FontWeight.w400,color: Colors.white),
                                    ),
                                    Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        InkWell(onTap: ()async{
                                          if(mounted){
                                            setState(() {
                                               checkDBHelper.updatedatawithkey('defaultab', 0);
                                            });
                                          }

                                        },
                                          child: Container(
                                            
                                            margin: EdgeInsets.only(top:1.h,left: 0.w,bottom: 1.h),
                                            height: 18.h,
                                            width: 30.w,
                                            decoration: BoxDecoration(
                                              color: Colors.transparent,
                                              borderRadius: BorderRadius.circular(12),
                                              border: Border.all(color:checkDBHelper.getdatawithkey('defaultab')==0?Colors.orange:Colors.white)
                                            ),
                                            child:Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                               const Icon(Icons.article,color: Colors.white,size: 45,),
                                                Text('Feed Tab',style: GoogleFonts.poppins(fontSize:13.sp,fontWeight: FontWeight.w500,color: Colors.white),)
                                              ],
                                            ),
                                          ),
                                        ),
                              
          InkWell(onTap: ()async{
            if(mounted){
              setState(() {
                 checkDBHelper.updatedatawithkey('defaultab', 1);
              });
            }
          },
            child: Container(margin: EdgeInsets.only(top:1.h,left: 5.w,bottom: 1.h),
                                            height: 18.h,
                                            width: 30.w,
                                            decoration: BoxDecoration(
                                              color: Colors.transparent,
                                              borderRadius: BorderRadius.circular(12),
                                              border: Border.all(color:checkDBHelper.getdatawithkey('defaultab')==1?Colors.green:Colors.white)
                                            ),
                                            child:Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                               const Icon(Icons.bolt,color: Colors.white,size: 45,),
                                                Text('Recos Tab',style: GoogleFonts.poppins(fontSize:13.sp,fontWeight: FontWeight.w500,color: Colors.white),)
                                              ],
                                            ),
                                          ),
          )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
        
                              InkWell(onTap:(){
                                Share.share('echostocks',
                                
                                );

                              },

                                child: Container(margin: EdgeInsets.only(top:2.h),padding: EdgeInsets.only(left:4.w),
                                  height: 8.h,width: 95.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: const Color.fromARGB(255, 8, 9, 11)
                                      
                                      
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.share,color: Colors.white,),
                                      Padding(
                                        padding:  EdgeInsets.only(left: 2.w),
                                        child: Text('Share',
                                        style: GoogleFonts.poppins(fontSize:13.sp,fontWeight: FontWeight.w500,color: Colors.white),),
                                      )
                                    ],
                                  ),
                                ),
                              ),
        
        
                              InkWell(onTap:()async{
                                if(await canLaunchUrlString(rateus)){
                                  await launchUrlString(rateus,mode:LaunchMode.externalApplication);
                                }else{
                                  snackbar('launch error', 'could not launch url',Icons.error);
                                }

                              },
                                child: Container(margin: EdgeInsets.only(top:2.h),padding: EdgeInsets.only(left:4.w),
                                  height: 8.h,width: 95.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color:const Color.fromARGB(255, 8, 9, 11)
                                      
                                      
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.star_rate,color: Colors.white,),
                                      Padding(
                                        padding:  EdgeInsets.only(left: 2.w),
                                        child: Text('Rate us',
                                        style: GoogleFonts.poppins(fontSize:13.sp,fontWeight: FontWeight.w500,color: Colors.white),),
                                      )
                                    ],
                                  ),
                                ),
                              ),
        
                              InkWell(onTap: (){
                                Get.to(const Policy());
                              },
                                child: Container(margin: EdgeInsets.only(top:2.h),padding: EdgeInsets.only(left:4.w),
                                  height: 8.h,width: 95.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: const Color.fromARGB(255, 8, 9, 11)
                                      
                                      
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.policy,color: Colors.white,),
                                      Padding(
                                        padding:  EdgeInsets.only(left: 2.w),
                                        child: Text('Privacy policy',
                                        style: GoogleFonts.poppins(fontSize:13.sp,fontWeight: FontWeight.w500,color: Colors.white),),
                                      )
                                    ],
                                  ),
                                ),
                              ),


                              InkWell(onTap: (){
                                Get.to(const TC());
                              },
                                child: Container(margin: EdgeInsets.only(top:2.h),padding: EdgeInsets.only(left:4.w),
                                  height: 8.h,width: 95.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: const Color.fromARGB(255, 8, 9, 11)
                                      
                                      
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.gavel,color: Colors.white,),
                                      Padding(
                                        padding:  EdgeInsets.only(left: 2.w),
                                        child: Text('Terms & Conditons',
                                        style: GoogleFonts.poppins(fontSize:13.sp,fontWeight: FontWeight.w500,color: Colors.white),),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            
              
        
            ],
          ),
        ) 
        
        ),
    );
  }
}
