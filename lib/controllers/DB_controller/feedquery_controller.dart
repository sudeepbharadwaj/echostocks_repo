import 'dart:async';

import 'package:echostocks/models/snackbar.dart';
import 'package:sqflite/sqflite.dart';

import '../../models/Db_model/feed_model.dart';

class FeedQuery{
  

  


  //function to insert data
  Future <int> insert(Map<String,dynamic> row)async{
    Database db=await metainstance.databse;
    return await db.insert(feedtable, row);
  }



 


//function to get database length 

Future<int> getCount() async {
    //database connection
    Database db = await metainstance.databse;
    var x = await db.rawQuery('SELECT COUNT (*) from $feedtable');
    int? count = Sqflite.firstIntValue(x);
    return count!;
}

  //function to query all rows

  Future  loadStream()async{
    Database db=await metainstance.databse;
    metainstance.streamController.sink.add(await db.query(feedtable));
    
  }

   Future  queryall()async{
    Database db=await metainstance.databse;
    return await db.query(feedtable);
    
  }


//function to query specific data
Future <List<Map<String,dynamic>>> queryspecific(var data)async{
  Database db=await metainstance.databse;
  var res=await db.query(feedtable,where:"key=?",whereArgs: [data]);
  return res;

} 



//function to query specific data
Future <List<Map<String,dynamic>>?> queryspecific2(String data)async{
  Database db=await metainstance.databse;
  List<Map<String, Object?>> res=await db.query(feedtable,where:"category=?",whereArgs: [data]);
  if(res.isNotEmpty){
  return res;
  }
  return null;

} 




//function to delete specific data 
Future <int> deletedata(String number)async{
  Database db=await metainstance.databse;
  var res=await db.delete(feedtable,where:"number=?",whereArgs: [number]);
  return res;
}


//function to update specific data
Future <int> update (String gmail,Map<String,dynamic> row)async{
  Database db=await metainstance.databse;
  var res =await db.update(feedtable,row,where:"gmail=?",whereArgs: [gmail]);
  return res;
}


//function to clear all the data and also reset primary key 
Future clear()async{
  Database db=await metainstance.databse;
  await db.delete(feedtable);
  
  //await db.rawDelete('DELETE FROM sqlite_sequence WHERE name=?',[table]);
}

}