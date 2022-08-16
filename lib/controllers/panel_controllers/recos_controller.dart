
import 'dart:io';
import 'dart:ui';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:echostocks/models/Db_model/recos_model.dart';
import 'package:echostocks/models/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
// ignore: implementation_imports
import 'package:postgrest/src/postgrest_response.dart';
import 'package:share/share.dart';

import '../../views/screens/others/nointernt.dart';
import 'bottomnav_controller.dart';



class RecosController extends GetxController with GetSingleTickerProviderStateMixin{

  PageController? recospageController;

  NavController navController = Get.find(tag: 'nav');



  List  recosclrlst=[
    [const Color.fromARGB(255, 237, 164, 116),
    const Color.fromARGB(255, 248, 198, 165),
    ],

    [
      const Color(0xff2ECC71),
      const Color(0xFF7BE9AB)

    ],

    [
      const Color(0xff3498DB),
      const Color(0xff5DADE2)
    ]

  ];

   

    var recokey=  GlobalKey();

  List months=[
    'January','February','March','April','May','June','July','August','September','October','November','December'
  ];

    @override
    void onInit()async{
      super.onInit();
      await getrecosdata();
      recosinit();


    }

    void recosinit()async{
     await recosquery.recosloadStream();

  }



  chnhorclr(String val){
    if(val=='Buy'){
      return const Color(0xFF21CEAB);
    }

    else if(val=='Sell'){
      return const Color(0xFFE04635);
    }

    else{
        return const Color(0xff5DADE2);
    }
  }

 
  chnconclr(String val){
  if(val=='Buy'){
    return const [
       Color(0xff2ECC71),
       Color(0xFF7BE9AB)
       ];
  

  }

  else if(val=="Sell"){
    return const [
      Color.fromARGB(255, 239, 90, 73),
     Color.fromARGB(255, 237, 133, 122),
    ];

  }
  else{
    return 
    [
      const Color(0xff3498DB),
      const Color(0xff5DADE2)
    ];
  }
 }


  String convertdate(String val){
    if(val=='null'){
      return '';
    }
    else{
      
    String finalDate=val.substring(8,10)+' '+months[int.parse(val.substring(5,7))-1]+' '+val.substring(0,4);
    return finalDate;
    } 

    


  }

    Future <void> getrecosdata()async{
      ConnectivityResult connectivityResult = await (Connectivity().checkConnectivity());
      if(connectivityResult!=ConnectivityResult.none){
        PostgrestResponse response=await supabase.from('Recos').select().eq('published', true).order('created_at',ascending: false).limit(10).execute();
        if(response.data!=null){
          await response.data.forEach((val)async{
            await recosquery.recosinsert({
              id:val['id'],
              symbolname:val['symbol_name'],
              symbollogo:val['symbol_logo'],
              recommandedby:val['recommended_by'],
              horizon:val['horizon'],
              call:val['call'],
              recoprice:val['reco_price'],
              target:val['target'],
              potential:val['potential'],
              stoploss:val['stop_loss'],
               analysis:val['analysis'],
              recodate:val['reco_date'].toString(),
              createdat:val['created_at'].toString()
              

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


    



    Future  getmorerecos()async{
    ConnectivityResult connectivityResult = await (Connectivity().checkConnectivity());
     if(connectivityResult!=ConnectivityResult.none){

      var columnDate;

         await recosquery.recosgetCount().then((value)async{
         
            
     columnDate=await recosquery.recosqueryspecific(value);

          });

  
   
    


      PostgrestResponse response=await supabase.from('Recos').select().lt('created_at',columnDate[0]['created_at'].toString()).eq('published',true).order('created_at',ascending: false).limit(8).execute();

      if(response.data!=null){
        

        
        await response.data.forEach((val)async{
         await recosquery.recosinsert({
           id:val['id'],
              symbolname:val['symbol_name'],
              symbollogo:val['symbol_logo'],
              recommandedby:val['recommended_by'],
              horizon:val['horizon'],
              call:val['call'],
              recoprice:val['reco_price'],
              target:val['target'],
              potential:val['potential'],
              stoploss:val['stop_loss'],
              analysis:val['analysis'],
              recodate:val['reco_date'].toString(),

              createdat:val['created_at'].toString()
              

            });
        });
/*
        var allrow=await metaDB.queryall2();
        allrow.forEach((val){
          print(val);

        });*/
      }

         
    else{
      snackbar('error', 'something went wrong...',Icons.error);


    }

    
      
    


    }
    else{
     Get.to( NoInternt());
    }
    

    
  }


  Future <void> refreshrecos()async{
     metainstance.streamController.sink.add(null);
    await recosquery.recosclear();
    ConnectivityResult connectivityResult = await (Connectivity().checkConnectivity());
      if(connectivityResult!=ConnectivityResult.none){
        PostgrestResponse response=await supabase.from('Recos').select().eq('published',true).order('created_at',ascending: false).limit(10).execute();
        if(response.data!=null){
          await response.data.forEach((val)async{
            await recosquery.recosinsert({
              id:val['id'],
              symbolname:val['symbol_name'],
              symbollogo:val['symbol_logo'],
              recommandedby:val['recommended_by'],
              horizon:val['horizon'],
              call:val['call'],
              recoprice:val['reco_price'],
              target:val['target'],
              potential:val['potential'],
              stoploss:val['stop_loss'],
               analysis:val['analysis'],
              recodate:val['reco_date'].toString(),
              createdat:val['created_at'].toString()
              

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


  Color callclrchng(var val){
    if(val=='Buy'){
      return const Color(0xFF21CEAB);
      
    }
    else if (val=='Sell'){
      return const Color(0xFFE04635);
    }

    else{
      return const Color(0xFF3197DC);
    }

  }

  Icon calliconchng(var val){
    if(val=="Buy"){
      return const Icon(Icons.trending_up,size:19,color: Color(0xFF21CEAB),);
    }
    else if(val=='Sell'){
      return const Icon(Icons.trending_down,size: 19,color: Color(0xFFE04635),);
    }
    else{
      return const Icon(Icons.remove,size:19,color:Color(0xFF3197DC));
    }

  }

  Widget chngapotentialicon(var val){

    if(val=='Buy'){
      return const Icon(Icons.arrow_upward,color: Color(0xFF21CEAB),);
    } 
    else if (val=='Sell') {
      return const Icon(Icons.arrow_downward,color: Color(0xFFE04635),);
      
    }

    else {
      return  Container();
    }
  }


  recostakescrshot() async {
   List<String> imagePaths = [];
    feedController.controller!.forward();
   await navController.controller!.forward();
   
  RenderRepaintBoundary boundary = recokey.currentContext!.findRenderObject() as RenderRepaintBoundary;
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