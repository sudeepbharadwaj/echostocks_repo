import 'package:echostocks/models/supase_credential.dart';
import 'package:echostocks/views/screens/splash/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sizer/sizer.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:core';

import 'controllers/other_controller/scrollglow_controller.dart';



void main ()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: url,
    anonKey: anonkey
  );
  await Hive.initFlutter();
   var dir=await getApplicationDocumentsDirectory();
  Hive.init(dir.path);
   await Hive.openBox("checks");
   await Hive.openBox('data');
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown,DeviceOrientation.portraitUp]);

  
  runApp(const echoStocks());
}




// ignore: camel_case_types
class echoStocks extends StatelessWidget {
  const echoStocks({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return Sizer(builder: (context,orientation,deviceType){
    
      return  GetMaterialApp(
        builder: ((context, child) {
          return ScrollConfiguration(behavior:  MyBehavior(), child:child!
          );
        }),
        
          debugShowCheckedModeBanner: false,
          title: 'echoStocks',
          theme:ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
          scaffoldBackgroundColor: const Color(0xFF080D13),
         appBarTheme:const AppBarTheme(
           color: Colors.black
         ), colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.black)
        ),

          home:Splash()
          
          
        );
      
     } );
  }
}
