import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:ui';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:echostocks/models/snackbar.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../models/Db_model/feed_model.dart';
import '../../views/screens/others/nointernt.dart';
import 'bottomnav_controller.dart';



class FeedController extends GetxController with GetTickerProviderStateMixin{


    AnimationController? controller;

    

    PageController? pageController;

    NavController navController = Get.find(tag: 'nav');

   

    var scr=  GlobalKey();


    var demo=0.obs;



   

   


  @override 
  void onInit()async{
    super.onInit();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
      
    controller!.forward();
     

    
  }

  

  void init()async{
   
     await feedquery.loadStream();

  }


 


  Future  getmorepage()async{
    ConnectivityResult connectivityResult = await (Connectivity().checkConnectivity());
     if(connectivityResult!=ConnectivityResult.none){

      var columnDate;

         await feedquery.getCount().then((value)async{
            
     columnDate=await feedquery.queryspecific(value);

          });

  
    


      PostgrestResponse response=await supabase.from('Feed').select().lt('created_at',columnDate[0]['created_at'].toString()).eq('published',true).order('created_at',ascending: false).limit(8).execute();

      if(response.data!=null){
        await response.data.forEach((val)async{
        await feedquery.insert({

          columnID:val['id'],

          columntitle:val['title'],
          columntitleimage:val['title_image'],
            columndescription:val['description'],
          columncategory:val['category'],
          columnauthor:val['author'],
          columnsource:val['source'],
          columnsourceurl:val['source_url'],
          columncreatedat:val['created_at'].toString() 
        });
        });

       
      }

         
    else{
      snackbar('error', 'something went wrong...',Icons.error);


    }
      
    


    }
    else{
      Get.to( NoInternt());
    }
    

    
  }



  void detectpage(var page)async{
  
    if(page!=0){
    
      await Future.delayed(const Duration(milliseconds: 500));
      controller!.forward();
            navController.controller!.forward();

    }

  }


  void visiblehidebars(){
    if (controller!.value == 1.0) {
            controller!.reverse();
            navController.controller!.reverse();
          } else {
            controller!.forward();
            navController.controller!.forward();
          }
  }


 Future refreshfeed()async{
  metainstance.streamController.sink.add(null);
  
  await feedquery.clear();

  ConnectivityResult connectivityResult = await (Connectivity().checkConnectivity());
  if(connectivityResult!=ConnectivityResult.none){
    PostgrestResponse response=await supabase.from('Feed').select().eq('published',true).order('created_at',ascending: false).limit(10).execute();
     if(response.data!=null){
     
      await response.data.forEach((val)async{
        await feedquery.insert({
          columnID:val['id'],
          columntitle:val['title'],
          columntitleimage:val['title_image'],
          columndescription:val['description'],
          columncategory:val['category'],
          columnauthor:val['author'],
          columnsource:val['source'],
          columnsourceurl:val['source_url'],
          columncreatedat:val['created_at'].toString() 
        });


      });

    }
    else{
      snackbar('error', 'something went wrong...',Icons.error);


    }


  }

  else{
      Get.to( NoInternt());
    }

 }



takescrshot() async {
   List<String> imagePaths = [];
    controller!.forward();
   await navController.controller!.forward();
   
  RenderRepaintBoundary boundary = scr.currentContext!.findRenderObject() as RenderRepaintBoundary;
  var image = await boundary.toImage();
  var byteData = await image.toByteData(format: ImageByteFormat.png);
  var pngBytes = byteData?.buffer.asUint8List();
  final directory = (await getApplicationDocumentsDirectory()).path;
  File imgFile =  File('$directory/screenshot.png');
              imagePaths.add(imgFile.path);
              imgFile.writeAsBytes(pngBytes!).then((value) async {
                await Share.shareFiles(imagePaths,
                    subject: 'Share',
                    text: 'Check this Out!',
                  
                  );
              }).catchError((onError) {
                
              });
            
  }




 






}
