
import 'dart:async';
import 'dart:io';

import 'package:echostocks/models/Db_model/category_model.dart';
import 'package:echostocks/models/Db_model/strategy_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../../models/Db_model/feed_model.dart';
import '../../models/Db_model/recos_model.dart';

class MetaDB{
  final  _databasename="metadata.db";
 final _databaseversion=1;

  


  static  Database? _database;

  MetaDB._privateConstructor();
  static final MetaDB instance=MetaDB._privateConstructor();

  Future <Database> get databse async{
    if(_database!=null) return _database as Database;

    _database=await _initDatabase();
    return _database as Database;


  }


  _initDatabase () async{
    Directory docdir=await getApplicationDocumentsDirectory();
    String path=join(docdir.path,_databasename);
    return await openDatabase(path,version: _databaseversion,onCreate: _oncreate);

  }


  Future _oncreate(Database db,int version)async{

    await db.execute(
      '''
        CREATE TABLE $feedtable (
          $columnKey INTEGER PRIMARY KEY,
          $columnID INTEGER,
          $columntitle TEXT,
          $columndescription TEXT,
          $columntitleimage INTEGER,
          $columncategory TEXT,
          $columnauthor TEXT,
          $columnsourceurl TEXT,
          $columnsource TEXT,
          $columncreatedat TEXT
         
          )

      '''

);

await db.execute(
      '''
      CREATE TABLE $recostable(
        $key INTEGER PRIMARY KEY,
        $id INTEGER,
        $symbolname TEXT,
        $symbollogo TEXT,
        $recommandedby TEXT,
        $horizon TEXT,
        $call TEXT,
        $recoprice TEXT,
        $target TEXT,
        $potential TEXT,
        $stoploss TEXT,
        $createdat TEXT,
        $analysis TEXT,
        $recodate TEXT


        )
      '''
    );

    await db.execute(
      '''
        CREATE TABLE $categorytable(
          $catKey INTEGER PRIMARY KEY,
          $catID INTEGER,
          $cattitle TEXT,
          $catdescription TEXT,
          $cattitleimage INTEGER,
          $catcategory TEXT,
          $catauthor TEXT,
          $catsourceurl TEXT,
          $catsource TEXT,
          $catcreatedat TEXT

        )
      '''
    );

    await db.execute(
      '''
        CREATE TABLE $strategytable(
          $strkey INTEGER PRIMARY KEY,
          $strid INTEGER,
          $strflashcards TEXT,
          $strcreatedat TEXT
          
          

        )

      '''

    );
    


  } 


  
  StreamController streamController=StreamController.broadcast();


  StreamController strstreamcontroller=StreamController.broadcast();


  




}




  
