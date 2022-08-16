import 'dart:io';
import 'dart:ui';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:echostocks/models/snackbar.dart';
import 'package:echostocks/views/screens/others/nointernt.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../models/Db_model/strategy_model.dart';
import 'bottomnav_controller.dart';

class StrategyController extends GetxController with GetTickerProviderStateMixin{

  NavController navController = Get.find(tag: 'nav');

  var strkey=  GlobalKey();


  RxString swipetxt='Swipe left'.obs;

  Rx<IconData> swipeicn=Icons.keyboard_double_arrow_right.obs;

  @override
  void onInit()async{
    super.onInit();
    await strquery.strclear();
   await getstrdata();
   strinit();
  
  

  }

void checkstartswipe()async{
  await strquery.strqueryspecific3(1).then((value) =>
   checkswipe(value[0]['flashcards'].toString().split(',').length)
    
    );
}

    void strinit()async{
     await strquery.strloadStream();

  }


  void checkswipe(var value){
    if(value!=1){
      swipetxt.value='swipe left';
      swipeicn.value=Icons.keyboard_double_arrow_right;

    }

    else{
      swipetxt.value='swipe up';
      swipeicn.value=Icons.keyboard_double_arrow_up;
    }
  }


  void getdata()async{
   // print('workinf');
    //var res=await strquery.strqueryall();
   

  }


  Future <void> getstrdata()async{
     ConnectivityResult connectivityResult = await (Connectivity().checkConnectivity());
     if(connectivityResult!=ConnectivityResult.none){
    PostgrestResponse response=await supabase.from('Strategies').select().eq('published', true).order('created_at',ascending: false).limit(10).execute();
  
    if(response.data!=null){
   
      await response.data.forEach((val)async{
        await strquery.strinsert({
          strid:val['id'],
          strflashcards:val['flashcards'],
          
          strcreatedat:val['created_at'],
          

        });



      });

      getdata();
      
      
    }
    else{
      snackbar('error', 'something went wrong...',Icons.error);
    }
  }
  else{
    Get.to(NoInternt());
  }
  }




  Future getmorestr()async{
    ConnectivityResult connectivityResult = await (Connectivity().checkConnectivity());
    if(connectivityResult!=ConnectivityResult.none){
      var columnDate;
      await strquery.strgetCount().then((value)async{
         
            
     columnDate=await strquery.strqueryspecific3(value);

          });

    PostgrestResponse response=await supabase.from('Strategies').select().lt('created_at',columnDate[0]['created_at'].toString()).eq('published',true).order('created_at',ascending: false).limit(8).execute();
    
    if(response.data!=null){
      await response.data.forEach((val)async{
        await strquery.strinsert({
          strid:val['id'],
          strflashcards:val['flashcards'],
          
          strcreatedat:val['created_at'],
          

        });



      });

      
      
      


    }

    else{
      snackbar('error', 'something went wrong...',Icons.error);
    }


    }
    else{
      Get.to(NoInternt());
    }
  }



  void checkoutswipe(int index)async{
     await strquery.strqueryspecific3(index).then((value){

      if(value[0]['flashcards'].toString().split(',').length==1){
        swipetxt.value='swipe up';
      swipeicn.value=Icons.keyboard_double_arrow_up;

      }
      else{
         swipetxt.value='swipe left';
      swipeicn.value=Icons.keyboard_double_arrow_right;

      }
     }
  
  
    
    );
   

  }


 strtakescrshot() async {
   List<String> imagePaths = [];
    feedController.controller!.forward();
   await navController.controller!.forward();
   
  RenderRepaintBoundary boundary = strkey.currentContext!.findRenderObject() as RenderRepaintBoundary;
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