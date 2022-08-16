import 'dart:io';
import 'dart:ui';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:echostocks/controllers/panel_controllers/bottomnav_controller.dart';
import 'package:echostocks/models/Db_model/category_model.dart';
import 'package:echostocks/models/snackbar.dart';
import 'package:echostocks/views/screens/others/nointernt.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
// ignore: implementation_imports
import 'package:postgrest/src/postgrest_response.dart';
import 'package:share/share.dart';


class CatDetailController{


   var catkey=  GlobalKey();

   NavController navController = Get.find(tag: 'nav');


     cattakescrshot() async {
   List<String> imagePaths = [];
    feedController.controller!.forward();
   await navController.controller!.forward();
   
  RenderRepaintBoundary boundary = catkey.currentContext!.findRenderObject() as RenderRepaintBoundary;
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







  Future getcatdata(String val)async{
    ConnectivityResult connectivityResult = await (Connectivity().checkConnectivity());
    if(connectivityResult!=ConnectivityResult.none){
      var count=await catquery.catgetCount(val);

      if(count==0){

      
      PostgrestResponse response=await supabase.from('Feed').select().filter('category', 'eq',val).order('created_at',ascending: false).execute();
      if(response.data!=null){
        await response.data.forEach((val)async{
          await catquery.catinsert({
            catID:val['id'],

          cattitle:val['title'],
          cattitleimage:val['title_image'],
            catdescription:val['description'],
          catcategory:val['category'],
          catauthor:val['author'],
          catsource:val['source'],
          catsourceurl:val['source_url'],
          catcreatedat:val['created_at'].toString() 
            

          });

        });



        

        return await catquery.catqueryspecific(val);

      }
      

            
    else{
      snackbar('error', 'something went wrong...',Icons.error);


    }
      }
      else{
       
        return await catquery.catqueryspecific(val);

      }

    
    
    }

    else{
      Get.to(NoInternt());
    }


  }


  


}