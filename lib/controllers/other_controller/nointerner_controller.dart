import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:echostocks/views/screens/panels/bottomnav.dart';
import 'package:echostocks/views/screens/splash/splash.dart';
import 'package:get/get.dart';





class NoInterntController 
{
  

  

  Future <void> checkinternt()async{

     ConnectivityResult connectivityResult = await (Connectivity().checkConnectivity());
     if(connectivityResult!=ConnectivityResult.none){
      Get.off(Splash());


    
     
      

    }


     }


  
  
}