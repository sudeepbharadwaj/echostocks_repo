import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';






class DBHelper{
 
  late Box box;
  late Box box1;
  late Box box2;



  DBHelper()
  
  {
    
    openBox();

  }

   openBox()async{
  // var dir =await getApplicationDocumentsDirectory();
    //Hive.init(dir.path);
    box= Hive.box("stocks");
    box1=Hive.box("outlook");
    box2=Hive.box("technical");
    
  }

 bool emptybox() {
    if (box.values.isEmpty){
      return true;

    }return false;
      
      
  }

 


   putdatawithkey(var key,var data){
    return box.put(key, data);
  }

   getall(){
    return box.toMap();
  }

   

  void updatedata(var i ,var data){
    box.put(i,data);

  }

  void  deletedata(var key){
    box.delete(key);

  }

  getdatawithkey(var key){
    return box.get(key);
  }

   clean (){
    box.clear();

  }



  bool emptybox1() {
    if (box1.values.isEmpty){
      return true;

    }return false;
      
      
  }

 

   getall1(){
    return box1.toMap();
  }

   

  void updatedata1(var i ,var data){
    box1.put(i,data);

  }

  void  deletedata1(var i){
    box1.delete(i);

  }

void putdatawithkey1(var key , var value){
   box1.put(key, value);
}

getdatabykey1(var key){
  return box1.get(key);
}


   clean1 (){
    box1.clear();

  }


  bool emptybox2() {
    if (box2.values.isEmpty){
      return true;

    }return false;
      
      
  }

  

   getall2(){
    return box2.toMap();
  }

   

  void updatedata2(var i ,var data){
    box2.put(i,data);

  }

  void  deletedata2(var i){
    box2.delete(i);

  }

  
void putdatawithkey2(var key , var value){
   box2.put(key, value);
}

getdatawbykey2(var key){
  return box2.get(key);
}



   clean2 (){
    box2.clear();

  }

  
    
  }