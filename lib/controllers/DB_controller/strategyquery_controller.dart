import 'package:sqflite/sqflite.dart';

import '../../models/Db_model/strategy_model.dart';
import '../../models/snackbar.dart';

class StrategyQuery{
  

  


  //function to insert data
  Future <int> strinsert(Map<String,dynamic> row)async{
    Database db=await metainstance.databse;
    return await db.insert(strategytable, row);
  }



 


//function to get database length 

Future<int> strgetCount() async {
    //database connection
    Database db = await metainstance.databse;
    var x = await db.rawQuery('SELECT COUNT (*) from $strategytable');
    int? count = Sqflite.firstIntValue(x);
    return count!;
}

  //function to query all rows

  Future  strloadStream()async{
    Database db=await metainstance.databse;
    metainstance.strstreamcontroller.sink.add(await db.query(strategytable));
    
  }

   Future  strqueryall()async{
    Database db=await metainstance.databse;
    return await db.query(strategytable);
    
  }




//function to query specific data
Future <List<Map<String,dynamic>>> strqueryspecific(var data)async{
  Database db=await metainstance.databse;
  var res=await db.query(strategytable,where:"id=?",whereArgs: [data]);
  return res;

} 


Future <List<Map<String,dynamic>>> strqueryspecific3(var data)async{
  Database db=await metainstance.databse;
  var res=await db.query(strategytable,where:"key=?",whereArgs: [data]);
  return res;

} 


//function to query specific data
Future <List<Map<String,dynamic>>?> strqueryspecific2(String data)async{
  Database db=await metainstance.databse;
  List<Map<String, Object?>> res=await db.query(strategytable,where:"category=?",whereArgs: [data]);
  if(res.isNotEmpty){
  return res;
  }
  return null;

} 




//function to delete specific data 
Future <int> strdeletedata(String number)async{
  Database db=await metainstance.databse;
  var res=await db.delete(strategytable,where:"number=?",whereArgs: [number]);
  return res;
}


//function to update specific data
Future <int> strupdate (String gmail,Map<String,dynamic> row)async{
  Database db=await metainstance.databse;
  var res =await db.update(strategytable,row,where:"gmail=?",whereArgs: [gmail]);
  return res;
}


//function to clear all the data and also reset primary key 
Future strclear()async{
  Database db=await metainstance.databse;
  await db.delete(strategytable);
  
  //await db.rawDelete('DELETE FROM sqlite_sequence WHERE name=?',[table]);
}

}