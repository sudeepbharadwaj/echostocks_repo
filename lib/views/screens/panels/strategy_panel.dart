import 'package:cached_network_image/cached_network_image.dart';
import 'package:echostocks/controllers/panel_controllers/strategy_controller.dart';
import 'package:echostocks/models/snackbar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:google_fonts/google_fonts.dart';


class Strategy extends StatelessWidget {
 Strategy({Key? key}) : super(key: key);


 StrategyController strategyController=Get.put(StrategyController());

bool checksnk=false;

  @override
  Widget build(BuildContext context) {
    strategyController.strinit();
    strategyController.checkstartswipe();
    
    
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      body:StreamBuilder(stream: metainstance.strstreamcontroller.stream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if(snapshot.hasData){
          return  RepaintBoundary(key:strategyController.strkey,
            child: PageView.builder(allowImplicitScrolling: false,
                controller: feedController.pageController,
                onPageChanged: ((page) async{
                  strategyController.checkoutswipe(snapshot.data.length-1);
                  if(checksnk==false){

                  if(page==snapshot.data.length-1){
                    snackbar('Congratulations','You read all strategies',Icons.mood);
                    checksnk=true;

                  }
                  }


                  if(page==snapshot.data.length-6){
                  
                  await strategyController.getmorestr();
                   strategyController.strinit();
                  
            
            
                }
                feedController.detectpage(page);
                  
                }),
                itemCount: snapshot.data.length,scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
              return PageView.builder(
                onPageChanged: ((page) {
                  
                feedController.detectpage(page);

                if(page!=snapshot.data[index]['flashcards'].toString().split(',').length-1){
                  strategyController.swipetxt.value='swipe left';
                  strategyController.swipeicn.value=Icons.keyboard_double_arrow_right;
                }
                else{
                  strategyController.swipetxt.value='swipe up';
                  strategyController.swipeicn.value=Icons.keyboard_double_arrow_up;
                }

          
                  
                }),
                scrollDirection: Axis.horizontal,itemCount: snapshot.data[index]['flashcards'].toString().split(',').length,
              dragStartBehavior: DragStartBehavior.down,
                itemBuilder:(context,i){ 
                  return  Stack(
                  children: [
                      
                    Positioned(top:0.h,
                      child: InkWell(onTap: (){
                        feedController.visiblehidebars();

                        
                        
                      },
                        child: SizedBox(
                          height: 100.h,width: 100.w,
                          child:CachedNetworkImage(imageUrl:snapshot.data[index]['flashcards'].toString().split(',')[i].trim(),
                          filterQuality: FilterQuality.low,
                          fit: BoxFit.fill,
                          )
                          
                          
                              
                        ),
                      ),
                    ),
          
                    SlideTransition(
                          position: Tween<Offset>(
                                  begin: Offset.zero, end: const Offset(0, -1))
                              .animate(
                            CurvedAnimation(
                                parent: feedController.controller!,
                                curve: Curves.fastOutSlowIn),
                          ),
                          child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.only(top: 3.h, left: 3.w),
                            height: 10.h,
                            width: 100.w,
                            decoration: const BoxDecoration(
                               // borderRadius: BorderRadius.only(
                                 //   bottomLeft: Radius.circular(14.0),
                                   // bottomRight: Radius.circular(14.0)),
                                color: Color.fromARGB(255, 8, 13, 19),),
                            child: Row(
                              children: [
            
                                SizedBox(
                                  width: 81.w,
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 1.5.w),
                                    child: Text("Strategies",
                                        style: GoogleFonts.roboto(
                                            fontSize: 13.sp,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.white,
                                            letterSpacing: 0.1)),
                                  ),
                                ),
                                
                                    IconButton(onPressed: (){
                                      strategyController.strtakescrshot();
                                      
                                    }, icon:const  Icon(Icons.share,color: Colors.white,size: 22,))
            
                              ],
                            ),
                          ),
                        ),

                        Positioned(top: 95.h,left: 68.w,
                          child:GetX<StrategyController>(init: strategyController,
                          builder: (controller) {
                            return Text(controller.swipetxt.value,
                            style: GoogleFonts.poppins(
                              fontSize:9.sp,fontWeight: FontWeight.w300,color: Colors.white,letterSpacing: 1
                            ),
                            );
                            
                          },
                            
                          ) 
                        
                        ),

                        Positioned(
                          top:94.3.h,left:85.w,
                          child:  GetX<StrategyController>(
                            init: strategyController,
                            builder: (controller) {
                              return Icon(controller.swipeicn.value,color: Colors.white,size: 27,);
                              
                            },
                             ))

                    
                    
                  ],
                );
                }
              );
              
                    },
              
            ),
          );
        }

        else if (snapshot.data==null){
          return const Center(
            child: CircularProgressIndicator(
              color:Color.fromARGB(255, 25, 29, 36),
              
            ),
          );

        }

        else{
          return const Center(
            child: CircularProgressIndicator(
              color: Color.fromARGB(255, 20, 26, 33),
              
            ),
          );
        }
        
      },

     
        
      ),
      );
  
  }
}