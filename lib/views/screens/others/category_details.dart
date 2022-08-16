import 'package:cached_network_image/cached_network_image.dart';

import 'package:echostocks/controllers/panel_controllers/catdetail_controller.dart';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:sizer/sizer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../models/snackbar.dart';
import '../panels/expanded_img.dart';

// ignore: must_be_immutable
class CategoryDetail extends StatefulWidget {
  const CategoryDetail({Key? key}) : super(key: key);

  @override
  State<CategoryDetail> createState() => _CategoryDetailState();
}

class _CategoryDetailState extends State<CategoryDetail> with SingleTickerProviderStateMixin{

  final catdetailcontroller=CatDetailController();


  AnimationController? controller;

  @override
  void initState(){
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    controller!.forward();
  }


  @override
  void dispose(){
    controller!.dispose();
    super.dispose();
  }


   void visiblehidebars(){
    if (controller!.value == 1.0) {
            controller!.reverse();
            
          } else {
            controller!.forward();
            
          }
  }



 

  @override
  Widget build(BuildContext context) {

   
    
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: FutureBuilder(future:catdetailcontroller.getcatdata(Get.arguments),

      builder: ((BuildContext context, AsyncSnapshot snapshot) {
        if(snapshot.hasData){
        return RepaintBoundary(key:catdetailcontroller.catkey,
          child: PageView.builder(controller: feedController.pageController,
              dragStartBehavior: DragStartBehavior.down,
              onPageChanged: ((page) async{
               
                 feedController.detectpage(page);
                
              }),
              
                itemCount: snapshot.data.length,
                scrollDirection: Axis.vertical,
                itemBuilder: ((context, index) {
                  return Padding(padding: EdgeInsets.only(top:5.h),
                    child: Stack(
                      children: [
                                
                                
                        //image positoned
                        Positioned(
                          top: 0.1.h,
                          child: GestureDetector(onTap: (){
                            
                          
                          
                                
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> Expandedimg(index:snapshot.data[index]['id'],type: 'cat',)));
                                
                                
                          },
                                
                            child: Container(
                              height: 40.h,
                              width: 100.w,
                              decoration: const BoxDecoration(
                                  
                                  color: Colors.transparent),
                                
                                  child: Hero(tag: 'cat',
                                    child:
                                     (Uri.parse(snapshot.data[index]['title_image']).isAbsolute)?
                                     CachedNetworkImage(imageUrl: snapshot.data[index]['title_image'],
                                    filterQuality: FilterQuality.low,
                                    fit: BoxFit.fill,
                                    errorWidget: ((context, url, error) {
                                      return Image.asset('assets/img/banner.png',
                                      filterQuality: FilterQuality.low,
                                    fit: BoxFit.fill,
                                      );
                  
                                    }),
                                    placeholder: (context, url) {
                                      return Image.asset('assets/img/banner.png',
                                      filterQuality: FilterQuality.low,
                                    fit: BoxFit.fill,
                                      );
                                    },
                                    
                                    
                                    ):Image.asset('assets/img/banner.png',
                                    filterQuality: FilterQuality.low,
                                    fit: BoxFit.fill,
                                    )
                                  ),
                            ),
                          ),
                        ),
                                
                        //bookmark and share button postioned
                                
                        Positioned(
                          top:32.6.h,left: 84.w,
                          child:Row(
                          children: [
                                
                                                  InkWell(onTap: ()async{
                                                    feedController.takescrshot();
                                      
                                                      
                  
                                                   
                                                    
                                                  },
                                                    child: Container(margin: EdgeInsets.only(right: 2.w),
                                                                              height: 4.5.h,width: 13.w,
                                                                              decoration: BoxDecoration(
                                                                                borderRadius: BorderRadius.circular(7),
                                                                                color: Colors.black54
                                                                              ),
                                                                              child: const Icon(Icons.share,color: Colors.white,size: 20,),
                                                                            ),
                                                  ),
                                
                           
                                
                                
                          ],
                        ) 
                        ),
                                
                        //custom app bar slide animation
                        SlideTransition(
                          position: Tween<Offset>(
                                  begin: Offset.zero, end: const Offset(0, -1))
                              .animate(
                            CurvedAnimation(
                                parent:controller!,
                                curve: Curves.fastOutSlowIn),
                          ),
                          child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.only(top: 0.h, left: 1.w),
                            height: 6.h,
                            width: 100.w,
                            decoration: const BoxDecoration(
                              
                                color:Color.fromARGB(255, 8, 13, 19),),
                            child: Row(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    icon: const Icon(
                                      Icons.arrow_back,
                                      color: Colors.white,
                                      size: 20,
                                    )),
                                SizedBox(
                                  width: 72.w,
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 1.5.w),
                                    child: Text("${Get.arguments}",
                                        style: GoogleFonts.roboto(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.white,
                                            letterSpacing: 0.1)),
                                  ),
                                ),
                                
                              ],
                            ),
                          ),
                        ),
                                
                        // detail container positioned
                        Positioned(
                          top: 38.h,
                          child: GestureDetector(
                            
                             onTap: () {
                             
                              visiblehidebars();
                                
                              },
                            child: Container(
                                height: 100.h,
                                width: 100.w,
                                decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 8, 13, 19),
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20))),
                                child: Padding(
                                  padding: EdgeInsets.only(left: 5.w, right: 5.w,top: 3.h),
                                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 9.h,
                                        child: Text('${snapshot.data[index]['title']}',
                                        maxLines: 3,overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.montserrat(fontSize: 12.4.sp,fontWeight: FontWeight.w500,color: Colors.white),),
                                      ),
                                      //SizedBox(height: 2.h,),
                                      
                                        SizedBox(height: 34.h,
                                          child: Text('${snapshot.data[index]['description']}',textAlign: TextAlign.start,
                                          overflow: TextOverflow.visible,
                                          style: GoogleFonts.montserrat(fontSize: 11.sp,fontWeight: FontWeight.w200,
                                          color:const Color.fromARGB(255, 201, 222, 242),
                                          height: 1.5,letterSpacing: 00.2),),
                                        ),
                          

                                    ],
                                  ),
                                )),
                          ),
                        ),

                         Positioned(
                          top: 86.h,left:5.3.w,
                          child: Text(timeago.format(DateTime.parse(snapshot.data[index]['created_at'].toString())),style: GoogleFonts.poppins(fontSize:10.sp,fontWeight: FontWeight.w300,color:const Color(0xff2C3E50)),)),
                          
                                            snapshot.data[index]['source']!=''?
                                            Positioned(
                                              top:86.h,left:69.w,
                                              child: Text('Money Control',style: GoogleFonts.poppins(fontSize:10.sp,fontWeight: FontWeight.w300,color:const Color(0xff2C3E50)),))
                                            :const Text(''),
                          
                                          
                          
                                       
                                      
                                     Positioned( top: 90.h,left:36.w,
                                      child: Text('echostocks',style: GoogleFonts.poppins(fontSize:13.sp,fontWeight: FontWeight.w600,color:const Color(0xff17202A)),)),
                                
                      ],
                    ),
                  );
                })),
        );
        }

        

       
        
      

        else{
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.white
              
            ),
          );
        }
  }),
      ),
      
    );
  }
}
