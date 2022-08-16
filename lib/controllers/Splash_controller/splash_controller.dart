import 'dart:async';
import 'package:echostocks/controllers/DB_controller/check_controller.dart';
import 'package:echostocks/controllers/DB_controller/feedquery_controller.dart';
import 'package:echostocks/models/snackbar.dart';
import 'package:echostocks/views/screens/others/nointernt.dart';
import 'package:echostocks/views/screens/panels/bottomnav.dart';
import 'package:echostocks/views/screens/splash/boarding.dart';
import 'package:echostocks/views/screens/splash/detail.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:sizer/sizer.dart';


import 'package:supabase_flutter/supabase_flutter.dart';

import '../../models/Db_model/feed_model.dart';

class SplashController extends GetxController  with GetSingleTickerProviderStateMixin{


  
  RxBool txt=true.obs;

 

  final CheckDBHelper checkDBHelper=CheckDBHelper();

 final  metaDB=FeedQuery();




int checkfuture=0;

int checkscr=0;

var pleft=7.w.obs;
var ptop=0.h.obs;


AnimationController? controller;


   @override
   void onInit()async{
    super.onInit();
   
    controller=AnimationController(vsync: this);

    Timer.periodic(const Duration(milliseconds: 700), (timer) async{ 
      if(txt.value==false){ 
     await metaDB.clear();
await  catquery.catclear();
  await recosquery.recosclear();
  
  getdata().whenComplete(() {
     checkdata();
    });
    timer.cancel();
  }

      


    });


    
    
   
   

   
 
  
    
   
    getdata().whenComplete(() {
      checkfuture=1;
    });

   }


   @override
   void onClose(){
    controller!.dispose();
    super.onClose();
   }

 


   Future <void> getdata()async{
    ConnectivityResult connectivityResult = await (Connectivity().checkConnectivity());
    if(connectivityResult!=ConnectivityResult.none){
      

    PostgrestResponse response=await supabase.from('Feed').select().eq('published',true).order('created_at',ascending: false).limit(10).execute();


    if(response.data!=null){
     
      await response.data.forEach((val)async{
        await metaDB.insert({
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

       checkscr=1;
      



     
      
      

    }
    
    
    
    else{
      snackbar('error', 'something went wrong...',Icons.error);


    }

    }

    else{

     Get.to(NoInternt());
    }
    
  

   


   
    
    
        
    
    


   }



   

  


  void checkdata()async{
    if(checkDBHelper.emptybox()==true ){
      if(checkscr==1){
    
      
      await checkDBHelper.putdatawithkey('boarding', 0);
       checkDBHelper.putdatawithkey('defaultab', 0);
      await checkDBHelper.putdatawithkey('detail',0);
      
      Get.off(BoardingScr());
      }
    }
    
    else{
      if(checkscr==1){
      if(checkDBHelper.getdatawithkey('boarding')==1){
        
        if(checkDBHelper.getdatawithkey('detail')!=0){
         
           Get.off(BottomNav());

        

        }
        
        else if(checkDBHelper.getdatawithkey('detail')==0){
         
          Get.off(UsrDetail());



        }

        

        
      }

      else if (checkDBHelper.getdatawithkey('boarding')==0){
        Get.off(BoardingScr());
      }
     
    }
    }
  }
  




}