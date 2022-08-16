import 'package:echostocks/controllers/DB_controller/category_query.dart';
import 'package:echostocks/controllers/DB_controller/feedquery_controller.dart';
import 'package:echostocks/controllers/DB_controller/recosquery_controller.dart';
import 'package:echostocks/controllers/DB_controller/strategyquery_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../controllers/DB_controller/datadb_controller.dart';
import '../controllers/panel_controllers/Feed_controller.dart';

final supabase = Supabase.instance.client;

final metainstance=MetaDB.instance;

final feedquery=FeedQuery();

final catquery=CatQuery();

final recosquery=RecosQuery();

final strquery=StrategyQuery();

FeedController feedController = Get.put(FeedController(), tag: 'feed');



void snackbar(String title,String message,IconData icon){
     Get.snackbar(
              title,
               message,
               icon:  Icon(icon, color: Colors.black),
               snackPosition: SnackPosition.BOTTOM,
               backgroundColor: Colors.white,
               borderRadius: 20,
               margin: const EdgeInsets.all(15),
               colorText: Colors.black,
               duration:const Duration(seconds: 3),
               isDismissible: true,
               dismissDirection:DismissDirection.horizontal,
               forwardAnimationCurve: Curves.easeOutBack,

               );
  }