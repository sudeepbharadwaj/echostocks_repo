import 'package:echostocks/models/Db_model/recos_model.dart';
import 'package:sqflite/sqflite.dart';

import '../../models/snackbar.dart';

class RecosQuery{

  

  //function to insert data
  Future <int> recosinsert(Map<String,dynamic> row)async{
    Database db=await metainstance.databse;
    return await db.insert(recostable, row);
  }







//function to get database length 

Future<int> recosgetCount() async {
    //database connection
    Database db = await metainstance.databse;
    var x = await db.rawQuery('SELECT COUNT (*) from $recostable');
    int? count = Sqflite.firstIntValue(x);
    return count!;
}

  //function to query all rows

  Future  recosloadStream()async{
    Database db=await metainstance.databse;
    metainstance.streamController.sink.add(await db.query(recostable));
    
  }

   Future  recosqueryall()async{
    Database db=await metainstance.databse;
    return await db.query(recostable);
    
  }


//function to query specific data
Future <List<Map<String,dynamic>>> recosqueryspecific(var data)async{
  Database db=await metainstance.databse;
  var res=await db.query(recostable,where:"key=?",whereArgs: [data]);
  return res;

} 


//function to delete specific data 
Future <int> recosdeletedata(String number)async{
  Database db=await metainstance.databse;
  var res=await db.delete(recostable,where:"number=?",whereArgs: [number]);
  return res;
}


//function to update specific data
Future <int> recosupdate (String gmail,Map<String,dynamic> row)async{
  Database db=await metainstance.databse;
  var res =await db.update(recostable,row,where:"gmail=?",whereArgs: [gmail]);
  return res;
}


//function to clear all the data and also reset primary key 
Future recosclear()async{
  Database db=await metainstance.databse;
  await db.delete(recostable);
  
  //await db.rawDelete('DELETE FROM sqlite_sequence WHERE name=?',[table]);
}
}