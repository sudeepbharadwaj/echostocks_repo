import 'dart:async';

import 'package:echostocks/models/Db_model/category_model.dart';
import 'package:echostocks/models/snackbar.dart';
import 'package:sqflite/sqflite.dart';


class CatQuery{
  

  


  //function to insert data
  Future <int> catinsert(Map<String,dynamic> row)async{
    Database db=await metainstance.databse;
    return await db.insert(categorytable, row);
  }





//function to get database length 

Future<int> catgetCount(var data) async {
    //database connection
    Database db = await metainstance.databse;
     var res=await db.query(categorytable,where: 'category=?',whereArgs: [data]);
    
    return res.length;

}

 

   Future  catqueryall()async{
    Database db=await metainstance.databse;
    return await db.query(categorytable);
    
  }


//function to query specific data
Future <List<Map<String,dynamic>>> catqueryspecific(var data)async{
  Database db=await metainstance.databse;
  var res=await db.query(categorytable,where:"category=?",whereArgs: [data]);
  
    
  return res;
  
 
 

} 


Future <List<Map<String,dynamic>>> catqueryspecific2(var data)async{
  Database db=await metainstance.databse;
  var res=await db.query(categorytable,where:"id=?",whereArgs: [data]);
  
    
  return res;
  
 
 

} 








//function to update specific data
Future <int> catupdate (String gmail,Map<String,dynamic> row)async{
  Database db=await metainstance.databse;
  var res =await db.update(categorytable,row,where:"gmail=?",whereArgs: [gmail]);
  return res;
}


//function to clear all the data and also reset primary key 
Future catclear()async{
  Database db=await metainstance.databse;
  await db.delete(categorytable);
  
  //await db.rawDelete('DELETE FROM sqlite_sequence WHERE name=?',[table]);
}

}