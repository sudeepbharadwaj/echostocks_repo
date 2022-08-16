import 'package:hive/hive.dart';

class CheckDBHelper{
  late Box box;

CheckDBHelper(){
    openbox();

}

openbox()async{
  box=Hive.box("checks");
}


//function to check the box is empty or not 
bool emptybox(){
  if(box.isEmpty){
    return true;
  }
  return false;

}

//function to put data in hive as key-value
 putdatawithkey(String key,var value){
  return box.put(key, value);

} 


//function to get all data from Hive

getall(){
  return box.toMap();
}

//function to update the key-value in Hive
updatedatawithkey(String key,var value){
  return box.put(key, value);

} 


//function to delete data using key in Hive
void delete(String key){
  box.delete(key);
}

//Function to get data using key in Hive
getdatawithkey(String key){
  return box.get(key);

}

//Function to clean full hive box
void clean(){
  box.clear();
}


//Function to clear data using key in Hive
void cleanwithkey(var key){
  box.delete(key);
}
}