import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:echostocks/controllers/panel_controllers/recos_controller.dart';
import 'package:echostocks/models/snackbar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:flutter_html/flutter_html.dart';

// ignore: must_be_immutable
class Recos extends StatelessWidget {
   Recos({Key? key}) : super(key: key);


  


  

  RecosController recosController=Get.put(RecosController());

  @override
  Widget build(BuildContext context) {
    recosController.recosinit();
    // ignore: deprecated_member_use
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      body: GestureDetector(

        onTap: (){


         
          feedController.visiblehidebars();
         


        },
        child: StreamBuilder(stream: metainstance.streamController.stream,
        builder: (BuildContext context,AsyncSnapshot snapshot){
          if(snapshot.hasData){
          return RepaintBoundary(key:recosController.recokey,
            child: PageView.builder(controller: feedController.pageController,
            onPageChanged: (page)async {
          
              feedController.detectpage(page);
              if(page==snapshot.data.length-5){
                await recosController.getmorerecos();
                recosquery.recosloadStream();
          
          
              }
              
              
            },
                dragStartBehavior: DragStartBehavior.down,
                itemCount: snapshot.data.length,
                scrollDirection: Axis.vertical,
                itemBuilder: ((context, index) {
                  return Stack(
                    children: [
                
                
                      Padding(padding: EdgeInsets.only(top:6.h,left: 4.5.w,right: 4.5.w),
                        child: Material(elevation: 40, borderRadius: BorderRadius.circular(12),
                            child: Container(padding: EdgeInsets.only(top:2.h),
                              height: 30.h,
                              width: 95.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                gradient:  LinearGradient(
                                  colors:recosController.chnconclr(snapshot.data[index]['call'].toString())
                                   ),
                  
                                
                              ),
                  
                              child: Padding(
                                padding:EdgeInsets.only(top:0.h),
                                child: Column(crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                              
                                              ClipOval(
                                                child: CircleAvatar(radius: 14.2.w,
                                                backgroundColor: Colors.white,
                                                                              child: Padding(
                                                                                padding:  EdgeInsets.only(left: 2.w,right: 2.w),
                                                                                child:(Uri.parse('${snapshot.data[index]['symbol_logo']}').isAbsolute)?
                                                                                
                                                                                CachedNetworkImage(imageUrl: '${snapshot.data[index]['symbol_logo']}',
                                                                                filterQuality: FilterQuality.low,
                                                                                placeholder: (context, url) {
                                                                                  return Container(color: Colors.white,);
                                                                                },

                                                                                errorWidget: (context, url, error) {
                                                                                  return Container(color: Colors.white,);
                                                                                },
                                                                                
                                                                                fit: BoxFit.fill,
                                                                                
                                                                                ):Center(child:
                                                                                    Text(snapshot.data[index]['symbol_name'].toString()[0],
                                                                                    style: GoogleFonts.poppins(fontSize:26.sp,fontWeight:FontWeight.w600,color: Colors.black),
                                                                                    
                                                                                    )
                                                                                  ),
                                                                                
                                                        
                                                                              ) ,
                                                            ),
                                              ) ,
                              
                                  Padding(
                                    padding:  EdgeInsets.only(top:2.h),
                                    child: Text('${snapshot.data[index]['symbol_name']}',textAlign: TextAlign.center,
                                    maxLines: 2,overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.poppins(fontSize: 17.sp,fontWeight: FontWeight.w600,color: const Color.fromARGB(255, 29, 38, 50),),),
                                  ),
                              
                                  Text('Recommended By ${snapshot.data[index]['recommended_by']}',textAlign: TextAlign.center,
                                    maxLines: 2,overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.poppins(fontSize: 8.8.sp,fontWeight: FontWeight.w500,color:const Color.fromARGB(255, 29, 38, 50)),),
                                  
                                  Text(recosController.convertdate(snapshot.data[index]['reco_date'].toString()) ,textAlign: TextAlign.center,
                                    maxLines: 2,overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.poppins(fontSize: 8.2.sp,fontWeight: FontWeight.w400,color:const Color.fromARGB(255, 29, 38, 50)),),
                  
                  
                                  
                  
                                      
                                     ],),
                              ),
                                
                            ),
                          ),
                        
                      ),
                  
                  
                
                      //custom app bar slide animation
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
                                width: 70.w,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 1.5.w),
                                  child: Text("Recos",
                                      style: GoogleFonts.roboto(
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white,
                                          letterSpacing: 0.1)),
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    recosController.refreshrecos().whenComplete(() {
                                      Timer(const Duration(milliseconds: 300), (){
                                        recosController.recosinit();
                 });
          
                                    });
                                    
                                    
                                  },
                                  icon: const Icon(
                                    Icons.refresh,
                                    color: Colors.white,
                                    size: 22,
                                  )),
                                  IconButton(onPressed: (){
                                    recosController.recostakescrshot();
                                  }, icon:const  Icon(Icons.share,color: Colors.white,size: 22,))
          
                            ],
                          ),
                        ),
                      ),
                
                   
                  
                       Positioned(top:43.h,left: 4.w,
                       child:
                         
                                        Container(margin: EdgeInsets.only(left:4.w,right:0.w),
                                          
                                          padding: EdgeInsets.only(left:2.w,right: 2.w),
                                            height: 4.h,
                                            //width: 10.w,
                                            decoration: BoxDecoration(
                                            
                                              borderRadius: BorderRadius.circular(7),
                                              color: const Color.fromARGB(255, 18, 23, 29),
                                              
                                              ),
                                              child: Row(
                                                children: [
                                                   Icon(Icons.schedule,color:recosController.chnhorclr(snapshot.data[index]['call'].toString()),size: 19,),
                                                               
                                                  Padding(
                                                    padding:  EdgeInsets.only(left: 1.w),
                                                    child: Text('horizon : ${snapshot.data[index]['horizon']}',style: GoogleFonts.poppins(fontSize:9.sp,fontWeight: FontWeight.w500,color:recosController.chnhorclr(snapshot.data[index]['call'].toString()),),),
                                                  )
                                                ],
                                              ),
                                          ),
                   
                       
                                         ),

                                         Positioned(top:43.h,left:67.w,

                                          child: Container(margin: EdgeInsets.only(left:10.w,right: 4.w),
                                        padding: EdgeInsets.only(left:2.w,right: 2.w),
                                          height: 4.h,
                                          //width: 18.w,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(7),
                                            color: const Color.fromARGB(255, 20, 26, 33),
                                            
                                            ),
                                            child: Row(
                                              children: [
                                                recosController.calliconchng(snapshot.data[index]['call'].toString()),
                       
                                                Padding(
                                                  padding:  EdgeInsets.only(left: 1.w),
                                                  child: Text('${snapshot.data[index]['call']}',style: GoogleFonts.poppins(fontSize:9.sp,fontWeight: FontWeight.w500,color:recosController.callclrchng(snapshot.data[index]['call'].toString())),),
                                                )
                                              ],
                                            ),
                                        ),


                                         ),
                  
                                         Positioned(top:55.h,
                                           
                                               child: Container(margin: EdgeInsets.only(left: 4.w,right: 4.5.w),
                                               alignment: Alignment.center,
                                               padding: EdgeInsets.only(left: 3.w,right: 1.w,top: 3.h),
                                                height: 13.h,
                                                width: 92.w,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(12),
                                                  gradient: const LinearGradient(colors: 
                                                  [
                                                     Color.fromARGB(255, 20, 26, 33),
                                                    Color.fromARGB(255, 40, 49, 60),
                                                    
                                                  ]),
                                                   boxShadow:const [
                BoxShadow(
                    color: Color.fromARGB(255, 20, 26, 33),
                    blurRadius: 2.0,
                    spreadRadius: 0.0,
                    offset: Offset(1.0, -2.0), // shadow direction: bottom right
                )
            ],
                                                  
                                                ),
                  
                                                child:  Row(mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: MediaQuery.of(context).size.width * 0.27,
                                        alignment: Alignment.center,
                                        child: Column(
                                              mainAxisAlignment:MainAxisAlignment.start,
                                            
                                          children: [
                                            Text(
                                              'Reco Price',
                                              style: GoogleFonts.poppins(
                                                fontSize: 13.sp,
                                                fontWeight: FontWeight.w300,
                                                color: const Color.fromARGB(
                                                    255, 127, 186, 234),
                                              ),
                                            ),
                                            Text(
                                              '${snapshot.data[index]['reco_price']}',textAlign: TextAlign.center,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.poppins(
                                                fontSize: 13.sp,
                                                fontWeight: FontWeight.w300,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: MediaQuery.of(context).size.width * 0.27,
                                        margin: EdgeInsets.only(
                                            left: 1.w, right: 1.5.w),
                                        child: Column(
                                           mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Target',
                                              style: GoogleFonts.poppins(
                                                fontSize: 13.sp,
                                                fontWeight: FontWeight.w300,
                                                color: const Color.fromARGB(
                                                    255, 127, 186, 234),
                                              ),
                                            ),
                                            Text(
                                              '${snapshot.data[index]['target']}',textAlign: TextAlign.center,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.poppins(
                                                fontSize: 13.sp,
                                                fontWeight: FontWeight.w300,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width * 0.27,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              
                                          children: [
                                            Text(
                                              'potential',
                                              style: GoogleFonts.poppins(
                                                  fontSize: 13.sp,
                                                  fontWeight: FontWeight.w300,
                                                  color: const Color.fromARGB(
                                                      255, 127, 186, 234)),
                                            ),
                                            Row(mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                recosController.chngapotentialicon(snapshot.data[index]['call'].toString()),
                                                SizedBox(width:1.w),
                  
                                                Text(
                                                  '${snapshot.data[index]['potential']}',textAlign: TextAlign.center,
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 13.sp,
                                                    fontWeight: FontWeight.w300,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ) ,
                                      
                                           ),
                                         ),
                  
                                         Positioned(top:71.h,
                                          
                                          child:snapshot.data[index]['analysis']!=''?Container(margin: EdgeInsets.only(left: 4.w,right: 4.5.w),
                                              // alignment: Alignment.center,
                                               padding: EdgeInsets.only(left: 0.w,right: 0.w,top: 0.h,bottom: 1.h,),
                                                height: 21.h,
                                                width: 92.w,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(12),
                                                  gradient: const LinearGradient(colors: 
                                                  [
                                                     Color.fromARGB(255, 20, 26, 33),
                                                    Color.fromARGB(255, 40, 49, 60),
                                                    
                                                  ]),
                                                   boxShadow:const [
                BoxShadow(
                    color: Color.fromARGB(255, 20, 26, 33),
                    blurRadius: 2.0,
                    spreadRadius: 0.0,
                    offset: Offset(1.0, -2.0), // shadow direction: bottom right
                )
            ],
                                                  
                                                ),
                                                child: Html(
                                                  style:{
                                                    "body":Style(color: Colors.white,textOverflow: TextOverflow.fade,),
                                                    'li':Style(color: Colors.white,
                                                      listStyleType: ListStyleType.fromWidget(Padding(padding: EdgeInsets.only(top:0.7.h),
                                                        child: const CircleAvatar(radius: 2,
                                                        backgroundColor: Colors.white,
                                                        ),
                                                      ))
                                                    )
                                                    
                                                    
                                                    
                } ,
                                                  data:""" ${snapshot.data[index]['analysis']}""",

                                                ),

                  
                                                
                  
                                          ) :Container()
                                          
                                          ),
                                          
                                           Positioned(
                                            top:94.h,left: 38.w,
                                            child: Text('echostocks',style: GoogleFonts.poppins(fontSize:13.sp,fontWeight: FontWeight.w600,color:const Color(0xff17202A)),)),
                  
                                            Positioned(
                                            top:97.h,left:timeago.format(DateTime.parse(snapshot.data[index]['created_at'].toString())).startsWith('about')?36.0.w:41.w,
                                            child: Text(timeago.format(DateTime.parse(snapshot.data[index]['created_at'].toString())),style: GoogleFonts.poppins(fontSize:10.sp,fontWeight: FontWeight.w400,color:const Color(0xff17202A)),)),
                       
                     
                      
                    ],
                  );
                })),
          );
          }

          else if (snapshot.connectionState==ConnectionState.waiting){
            return const Center(
              child: CircularProgressIndicator(color:Color.fromARGB(255, 20, 26, 33),),
            );
          }

          else if (snapshot.data==null){
           return const Center(
              child: CircularProgressIndicator(color:Colors.white,),
            );

          }

     

          
          else {
            return const Center(
              child: CircularProgressIndicator(color: Color.fromARGB(255, 26, 35, 44),),
              
            );
          }
  }),
      ),
    );
  }
}







