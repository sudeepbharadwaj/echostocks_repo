import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:ecostocks/models/data_helper.dart';
import 'package:ecostocks/views/nav_drawer.dart';
import 'package:ecostocks/views/outlook_detail.dart';
import 'package:ecostocks/views/stocks_details.dart';
import 'package:ecostocks/views/technical_detail.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'dart:core';
import 'package:timeago/timeago.dart' as timeago;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:animated_text_kit/animated_text_kit.dart';





void main ()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  await Hive.openBox('stocks');
  await Hive.openBox('outlook');
  await Hive.openBox("technical");
  runApp(const ecoStocks());
}


class customexp implements Exception{
  String errormessage(){
    return "Something went wrong...";
  }
}


final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
void _showsnackbar(){

   _scaffoldKey.currentState!.showSnackBar  ( SnackBar  (
     duration: Duration(seconds: 4),
     backgroundColor: Colors.black,
     content: Text(customexp().errormessage().toString(),style: TextStyle(color:Colors.white),)));
}


// ignore: camel_case_types
class ecoStocks extends StatelessWidget {
  const ecoStocks({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
   // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.top]);
    return Sizer(builder: (context,orientation,deviceType){
      return  MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'echoStocks',
          theme:ThemeData(
           
            scaffoldBackgroundColor:  const Color(0xff17202a),
            
          
               
          appBarTheme:  const AppBarTheme(color: Color(0xff1c2833 ),
          elevation: 0,
          shadowColor: Colors.blue,
        
          )
          
          ),
          home: const splash()
          
          
        );
      
     } );
  }
}

// ignore: camel_case_types
class splash extends StatefulWidget {
  const splash({Key? key}) : super(key: key);

  

  @override
  _splashState createState() => _splashState();
}

// ignore: camel_case_types
class _splashState extends State<splash> {

  

  final DBHelper _helper= DBHelper();
    
  final CollectionReference _stocks =  FirebaseFirestore.instance.collection('Stocks');
  bool _circularbar=false;

  

Future<void> _checkdeletedocs() async {
  List _id=_helper.getdatawithkey("ID");
  var _delid=[];
  
try{
  for (var i=0;i<_id.length;i++){
    try{
    
    await _stocks.doc(_helper.getdatawithkey("ID")[i]).get().then((doc){
      if(doc.exists){

      }else{
        _delid.add(_helper.getdatawithkey("ID")[i]);
      }

    });}catch (e){}

  }
}catch (e){}
try{
  for(var i=0;i<_delid.length;i++){
    _helper.deletedata(_delid[i]);
    _id.remove(_delid[i]);
  }
  _helper.updatedata("ID", _id);
  
}catch (e){}

}

Future <void> _checkupdatedocs()async{

  
  var _date=_helper.getdatawithkey(_helper.getdatawithkey("ID")[0])['last_updated'];
  List _oldid=_helper.getdatawithkey("ID");
  
  
  List _id=[];
  List _finalid=[];
try{
await _stocks.where("last_updated",isGreaterThan: Timestamp.fromDate(_date)).orderBy('last_updated',descending: true).get().then((QuerySnapshot querySnapshot){
  querySnapshot.docs.forEach((data) {
    if(data.exists){
      _id.add(data.id);
      
    
    
      try{
      _helper.updatedata(data.id,
      
      {
        "analysis":data.get("analysis"),
        "call":data.get("call"),

        "call_type":data.get("call_type"),
        "cmp":data.get("cmp"),
        "company_logo":data.get("company_logo"),
        'company_name':data.get('company_name'),
        'current_status':data.get("current_status"),
        'last_updated':data.get('last_updated').toDate(),
        'reco_date':data.get("reco_date").toDate(),
        'reco_price':data.get("reco_price"),
        'stop_loss':data.get("stop_loss"),
        'target':data.get("target")
      }
      
      );}catch(e){
        

      }

    }else{
      
    }
    
    
  });
  
  _finalid.add(_id+_oldid); 
  _helper.updatedata("ID",_finalid[0]);
 
  

});}catch (e){
  
}
  
  }

 

Future <void> _getstocksdata() async{
List _id= [];



 try{
  await _stocks.orderBy('last_updated',descending: true).get().then((QuerySnapshot  querysnapshot) {
    // ignore: avoid_function_literals_in_foreach_calls
    querysnapshot.docs.forEach((data) {
    
      
      _id.add(data.id);
    

      try{
      _helper.putdatawithkey(
        
        data.id,{
        "analysis":data.get("analysis"),
        "call":data.get("call"),
        "call_type":data.get("call_type"),
        "cmp":data.get("cmp"),
        "company_logo":data.get("company_logo"),
        'company_name':data.get('company_name'),
        'current_status':data.get("current_status"),
        'last_updated':data.get('last_updated').toDate(),
        'reco_date':data.get("reco_date").toDate(),
        'reco_price':data.get("reco_price"),
        'stop_loss':data.get("stop_loss"),
        'target':data.get("target")


        }
      );}catch (e){}
 
    });
    _helper.putdatawithkey("ID",_id);
   
  });}
  catch (e){
    
  }

}


  @override
  void initState(){
    super.initState();
  
    if(_helper.emptybox()==true){
      Timer(const Duration(milliseconds: 4400), (){
        setState(() {
          _circularbar=true;
        });
        _getstocksdata().whenComplete(() {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const HomePage()));
      });

      });
     }
    else if (_helper.emptybox()==false){
      Timer(const Duration(milliseconds: 4400), (){
        setState(() {
          _circularbar=true;
        });
          _checkupdatedocs().whenComplete(() {
          _checkdeletedocs().whenComplete(() {
            
             
         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const HomePage()));

        });
        
        });
     

      });
     
      
    }

  }


  @override
  Widget build(BuildContext context) {
     
     SystemChrome.setSystemUIOverlayStyle(
       const SystemUiOverlayStyle(
         statusBarColor: Colors.transparent));
    return Scaffold(
      body:Center(child:
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          TextLiquidFill(text: "EchoStocks",textStyle: GoogleFonts.poppins(fontSize: 20.sp,fontWeight: FontWeight.w700,letterSpacing: 4.0),
          boxBackgroundColor: const Color(0xff17202a),
          waveColor: const Color(0xff85929e),
          loadDuration: const Duration(seconds: 4),
          boxHeight: 16.h,
          ),
          
          Visibility(visible:_circularbar,child: const CircularProgressIndicator(color:Color(0xff85929e)))
            
          
        ],)
      )

     
     
    );
  }
}




class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin{

  // ignore: prefer_typing_uninitialized_variables
  late var _controller;

 StreamSubscription? connectivitySubscription;

 ConnectivityResult? oldres;




  void internetsnackbar(){
     ScaffoldMessenger.of(context).showSnackBar(const SnackBar (
          duration: Duration(days:365),backgroundColor: Colors.black,
          content:Text("No Internet connection Available",style: TextStyle(color:Colors.white))));

          


  }
  
 
 
  @override
  void initState(){
    super.initState();
    
    _controller=TabController(length:3,vsync: this);

   connectivitySubscription=Connectivity().onConnectivityChanged.listen((ConnectivityResult resnow) {
      if(resnow==ConnectivityResult.none){
      

       
        internetsnackbar();

      }else if (oldres==ConnectivityResult.none){
        
      
        ScaffoldMessenger.of(context).hideCurrentSnackBar();

        
      }
     
      oldres=resnow;
   });


   
    
  }

  @override
  void dispose(){
    super.dispose();
    _controller.dispose();
  }


  @override


  
  Widget build(BuildContext context) {
    
    return 
       Scaffold(
         key:_scaffoldKey,
        
        appBar: AppBar(title:Text('EchoStocks',style: GoogleFonts.poppins(fontSize: 16.sp,letterSpacing: 1),),
        
         systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: Color(0xff1c2833),),
         bottom: TabBar(
           
           indicatorColor: Colors.white30,
           indicatorWeight:2.5,
           
           labelStyle: GoogleFonts.poppins(fontSize:13.sp,fontWeight:FontWeight.w500,letterSpacing: 1),
           unselectedLabelStyle:GoogleFonts.poppins(fontSize:11.sp,fontWeight:FontWeight.w400,letterSpacing: 1) ,
           controller: _controller,
           
          // isScrollable: true,
           // ignore: prefer_const_literals_to_create_immutables
           tabs: [
           const Tab(text: "Stocks",),
           const Tab(text: "Outlook",),
           const Tab(text:"Technical")
         ],),
        
        ),
        drawer: Nav(),
        body:TabBarView(
          controller: _controller
          ,children:<Widget> [
          RecosTab(),
          outlookTab(),
          techo()
        ])
        
      );
    
  }
}


Widget RecosTab(){

 

         final DBHelper _helper= DBHelper();



       
  return SafeArea(minimum: EdgeInsets.only(left:4.w,right:4.w,top:2.h,bottom:3.h),
   
      child: ListView.separated(
          itemCount:_helper.getdatawithkey("ID").length,
          scrollDirection: Axis.vertical,
          separatorBuilder: (ctx,_)=>SizedBox(height:2.8.h),
          itemBuilder: (ctx,i){
            return GestureDetector(onTap: (){
             
              Navigator.push(ctx, MaterialPageRoute(builder:(ctx)=>Details(i:i) )
              
              );
            },
              child: 
              (_helper.getdatawithkey(_helper.getdatawithkey("ID")[i])["company_name"]!=null && _helper.getdatawithkey(_helper.getdatawithkey("ID")[i])["call"]!=null && _helper.getdatawithkey(_helper.getdatawithkey("ID")[i])["current_status"]!=null)?
              Container(
                height:10.h,
                width:80.w,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.0),color:  Colors.white10,),
                child:Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                    Container(
                      height: 10.h,
                      width:14.w,
                      margin: EdgeInsets.only(left:3.w,right:3.w),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(image: NetworkImage("https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/1200px-Image_created_with_a_mobile_phone.png"))
                      ),
                    ),
            
                    Expanded(
                      child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        Text(_helper.getdatawithkey(_helper.getdatawithkey("ID")[i])["company_name"],style:GoogleFonts.poppins(fontSize:12.sp,fontWeight:FontWeight.w500,color:Colors.white,letterSpacing: 1.2),overflow: TextOverflow.ellipsis,),
                        Text(_helper.getdatawithkey(_helper.getdatawithkey("ID")[i])["call"],style:GoogleFonts.poppins(fontSize:9.sp,fontWeight:FontWeight.w700,color:(_helper.getdatawithkey(_helper.getdatawithkey("ID")[i])["call"]=="Buy")?Colors.green[300]:Colors.red[400],letterSpacing: 1.6)),
                        Text(_helper.getdatawithkey(_helper.getdatawithkey("ID")[i])["current_status"],style:GoogleFonts.poppins(fontSize:9.sp,fontWeight:FontWeight.w500,color:Colors.white,letterSpacing: 1.6)),
                        
                      ],),
                    ),Padding(
                      padding:EdgeInsets.only(right:2.w),
                      child: Text(timeago.format(DateTime.parse(_helper.getdatawithkey(_helper.getdatawithkey("ID")[i])["reco_date"].toString())),style:GoogleFonts.poppins(fontSize:9.sp,fontWeight:FontWeight.w500,color:Colors.white,letterSpacing: 1))),
                   
                  ],)
                  
                  
                  
            
                ],) ,
                
                
              ):null
            );
          },
          
          ),
    
  );
  
}


enum showwidgets{
  SHOW_OUTLOOK,
  SHOW_LODING
}


// ignore: camel_case_types
class outlookTab extends StatefulWidget {
  const outlookTab({Key? key}) : super(key: key);

    @override
  _outlookTabState createState() => _outlookTabState();
  
}

// ignore: camel_case_types
class _outlookTabState extends State<outlookTab> {
  

  final DBHelper _helper=DBHelper();
  final CollectionReference _stocks = FirebaseFirestore.instance.collection('Pointers');
 bool _isloading=true;

  

  Future<void> _checkdeletedocs() async {
  List _id=_helper.getdatabykey1("ID");
  var _delid=[];
  
try{
  for (var i=0;i<_id.length;i++){
    try{
    
    await _stocks.doc(_helper.getdatabykey1("ID")[i]).get().then((doc){
      if(doc.exists){

      }else{
        _delid.add(_helper.getdatabykey1("ID")[i]);
       
      }

    });}catch (e){}

  }
}catch (e){}
try{
  for(var i=0;i<_delid.length;i++){
    _helper.deletedata1(_delid[i]);
    _id.remove(_delid[i]);
  }
  _helper.updatedata1("ID", _id);
  
}catch (e){}

}




Future <void> _checkupdatedocs()async{

  
  var _date=_helper.getdatabykey1(_helper.getdatabykey1("ID")[0])['last_updated'];
  List _oldid=_helper.getdatabykey1("ID");
  
  
  List _id=[];
  List _finalid=[];
try{
await _stocks.where("last_updated",isGreaterThan: Timestamp.fromDate(_date)).orderBy('last_updated',descending: true).get().then((QuerySnapshot querySnapshot){
  // ignore: avoid_function_literals_in_foreach_calls
  querySnapshot.docs.forEach((data) {
    if(data.exists){
      _id.add(data.id);
      
    
    
      try{
      _helper.updatedata1(data.id,
      
      {
        "Description":data.get("Description"),
       "Title":data.get("Title"),
       "Title_Image":data.get("Title_Image"),
       "last_updated":data.get("last_updated").toDate(),
       
      }
      
      );}catch(e){
        

      }

    }else{
      
    }
    
    
  });
  
  _finalid.add(_id+_oldid); 
  _helper.updatedata1("ID",_finalid[0]);
 
  

});}catch (e){
  
}
  
  }

  Future <void> _getstocksdata() async{
List _id= [];



 try{
  await _stocks.orderBy('last_updated',descending: true).get().then((QuerySnapshot  querysnapshot) {
    // ignore: avoid_function_literals_in_foreach_calls
    querysnapshot.docs.forEach((data) {
      if(data.exists)
      {
    
    
      
      _id.add(data.id);
    

      try{
      _helper.putdatawithkey1(
        
        data.id,{
        "Description":data.get("Description"),
       "Title":data.get("Title"),
       "Title_Image":data.get("Title_Image"),
       "last_updated":data.get("last_updated").toDate(),


        }
      );
      
      }
      
      catch (e){}
      }else {
        setState(() {
          if(mounted) {
            _isloading=false;
          }
        });
      }
 
    });
    _helper.putdatawithkey1("ID",_id);
    
   
  });}
  catch (e){
    
  }

}

  @override 
  void initState(){
    super.initState();
    
      if(_helper.emptybox1()==true){
      _getstocksdata().whenComplete(() {
    
        if(mounted) {
          setState(() {
        
          currentstate=showwidgets.SHOW_OUTLOOK;
        });
        }

      });
     
      

    }
    else if (_helper.emptybox1()==false){
       _checkupdatedocs().whenComplete(() {
          _checkdeletedocs().whenComplete(() {
            if (mounted){
              if(_helper.emptybox1()==true){
                setState(() {
                  _isloading=false;
                });
              }
              setState(() {
                 currentstate=showwidgets.SHOW_OUTLOOK;
              });
             
              
            }else {}
           
            
             
       

        });
        
        });
     
      
    }
    

  }

     


Widget outlook(context)
{
  return Scaffold(
      body:
         SafeArea(minimum: EdgeInsets.only(left:4.w,right:4.w,top:2.h,bottom:3.h),
      
          child:Visibility(visible:_isloading,replacement: Center(child:Text("No Data Available",style:GoogleFonts.poppins(fontSize:12.sp ,fontWeight: FontWeight.w600,color: Colors.white,letterSpacing: 1.5)),),
        child: ListView.separated(itemCount:_helper.getdatabykey1("ID").length,
        scrollDirection: Axis.vertical,
        separatorBuilder: (ctx,_)=>SizedBox(height:2.8.h),
        itemBuilder: (ctx,index){
          return  GestureDetector(onTap: (){
               Navigator.push(ctx, MaterialPageRoute(builder:(ctx)=>outlookDetail(index:index) )
                    
                    );
            },
              child:
          (_helper.getdatabykey1(_helper.getdatabykey1("ID")[index])["Title"]!=" " && _helper.getdatabykey1(_helper.getdatabykey1("ID")[index])["Title"]!=null)?
               Container(
                height:24.h,
                width:80.w,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft:Radius.circular(18.0),topRight: Radius.circular(18.0) ),color:Colors.white12,
                  
                 ),
                 child:Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                   InkWell(onTap: (){},
                   child:ClipRRect(
                     borderRadius: const BorderRadius.only(topLeft:Radius.circular(16.0),topRight: Radius.circular(16.0)),
                     
                     child: Image.network(_helper.getdatabykey1(_helper.getdatabykey1("ID")[index])["Title_Image"],fit: BoxFit.fitWidth,height: 14.h,width:100.w)),
            
                   ),
                    Row(
            
                     mainAxisAlignment: MainAxisAlignment.start,
                     children:[ 
                       Padding(padding:EdgeInsets.only(left:3.w,top:1.h),
                       child: Text(_helper.getdatabykey1(_helper.getdatabykey1("ID")[index])["last_updated"].toString().substring(0,10),style:GoogleFonts.poppins(fontSize: 10.sp,fontWeight: FontWeight.w500,color:Colors.white)))
                     ]),
                   Padding(padding:EdgeInsets.only(left:2.w),
                   
                   
                   child: Text(_helper.getdatabykey1(_helper.getdatabykey1("ID")[index])["Title"],style:GoogleFonts.poppins(fontSize: 11.sp,fontWeight: FontWeight.w500,color:Colors.white),overflow:TextOverflow.ellipsis,maxLines: 2,)),
                  
                 ],)
            
                
            
            
              ):null
            );
          
        },
        ),
          ),
           
        ),
      
    );
}


Widget load(context){
  return const Scaffold(
    body:
    
    Center(child: CircularProgressIndicator(color:Colors.white10,))
  );
}

showwidgets currentstate=showwidgets.SHOW_LODING;
  @override
  Widget build(BuildContext context) {
    return Scaffold( resizeToAvoidBottomInset: false,
      body:currentstate==showwidgets.SHOW_LODING?load(context):outlook(context),
    );
  }
}


// ignore: camel_case_types
class techo extends StatefulWidget {
  const techo({ Key? key }) : super(key: key);

  @override
  _techoState createState() => _techoState();
}

// ignore: camel_case_types
class _techoState extends State<techo> {

  final DBHelper _helper=DBHelper();
  final CollectionReference _stocks = FirebaseFirestore.instance.collection('Technicals');


  Future<void> _checkdeletedocs() async {
  List _id=_helper.getdatawbykey2("ID");
  var _delid=[];
  
try{
  for (var i=0;i<_id.length;i++){
    try{
    
    await _stocks.doc(_helper.getdatawbykey2("ID")[i]).get().then((doc){
      if(doc.exists){

      }else{
        _delid.add(_helper.getdatawbykey2("ID")[i]);
      }

    });}catch (e){}

  }
}catch (e){}
try{
  for(var i=0;i<_delid.length;i++){
    _helper.deletedata2(_delid[i]);
    _id.remove(_delid[i]);
  }
  _helper.updatedata2("ID", _id);
  
}catch (e){}

}



Future <void> _checkupdatedocs()async{

  
  var _date=_helper.getdatawbykey2(_helper.getdatawbykey2("ID")[0])['last_updated'];
  List _oldid=_helper.getdatawbykey2("ID");
  
  
  List _id=[];
  List _finalid=[];
try{
await _stocks.where("last_updated",isGreaterThan: Timestamp.fromDate(_date)).orderBy('last_updated',descending: true).get().then((QuerySnapshot querySnapshot){
  // ignore: avoid_function_literals_in_foreach_calls
  querySnapshot.docs.forEach((data) {
    if(data.exists){
      _id.add(data.id);
      
    
    
      try{
      _helper.updatedata2(data.id,
      
      {
        "Description":data.get("Description"),
      "Pattern":data.get("Pattern"),
       "Title":data.get("Title"),
       "Title_Image":data.get("Title_Image"),
       "last_updated":data.get("last_updated").toDate(),
       
       
      }
      
      );}catch(e){
        

      }

    }else{
      
    }
    
    
  });
  
  _finalid.add(_id+_oldid); 
  _helper.updatedata2("ID",_finalid[0]);
 
  

});}catch (e){
  
}
  
  }

  Future <void> _getstocksdata() async{
List _id= [];



 try{
  await _stocks.orderBy('last_updated',descending: true).get().then((QuerySnapshot  querysnapshot) {
    // ignore: avoid_function_literals_in_foreach_calls
    querysnapshot.docs.forEach((data) {
      if(data.exists){
    
      
      _id.add(data.id);
    

      try{
      _helper.putdatawithkey2(
        
        data.id,{
        "Description":data.get("Description"),
      "Pattern":data.get("Pattern"),
       "Title":data.get("Title"),
       "Title_Image":data.get("Title_Image"),
       "last_updated":data.get("last_updated").toDate(),
       

        }
      );}catch (e){}
 
    }
    else {
      if(mounted){
        setState(() {
          _isloading=false;
        });
      }
    }
    }
    );
    _helper.putdatawithkey2("ID",_id);
   
     
  });}
  catch (e){
    
  }

}



bool _isloading=true;

  @override 
  void initState(){
    super.initState();
    

     if(_helper.emptybox2()==true){
      _getstocksdata().whenComplete(() {
        if(mounted){
        setState(() {
          currentstate=showwidgets.SHOW_OUTLOOK;
         });}
      });
      
      
      

    }
    else if (_helper.emptybox2()==false){
       _checkupdatedocs().whenComplete(() {
          _checkdeletedocs().whenComplete(() {
            
            if (mounted){
              if(_helper.emptybox2()==true){
                setState(() {
                  _isloading=false;
                });
              }setState(() {
                currentstate=showwidgets.SHOW_OUTLOOK;
              });
              
              
            }else {}
            
          
        });
        
        });
     
      
    }

    


  }




  Widget technical (context){
    return Scaffold(
      body:SafeArea(minimum: EdgeInsets.only(left:4.w,right:4.w,top:2.h,bottom:3.h),

    child:Visibility(visible:_isloading,replacement: Center(child:Text("No Data Available",style:GoogleFonts.poppins(fontSize:12.sp ,fontWeight: FontWeight.w600,color: Colors.white,letterSpacing: 1.5)),),
      child: ListView.separated(itemCount:(_helper.getdatawbykey2("ID").length!=null)?_helper.getdatawbykey2("ID").length:0,
      scrollDirection: Axis.vertical,
      separatorBuilder: (ctx,_)=>SizedBox(height:2.8.h),
      itemBuilder: (ctx,index){
        return  GestureDetector(onTap: (){
             Navigator.push(ctx, MaterialPageRoute(builder:(ctx)=>techDetail(index:index) )
                  
                  );
          },
            child: 
          (_helper.getdatawbykey2(_helper.getdatawbykey2("ID")[index])["Title"]!=" " && _helper.getdatawbykey2(_helper.getdatawbykey2("ID")[index])["Title"]!=null)?
            Container(
              height:24.h,
              width:80.w,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(topLeft:Radius.circular(18.0),topRight: Radius.circular(18.0) ),color:Colors.white12,
                
               ),
               child:Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                 InkWell(onTap: (){},
                 child:ClipRRect(
                   borderRadius: const BorderRadius.only(topLeft:Radius.circular(16.0),topRight: Radius.circular(16.0)),
                   
                   child: Image.network(_helper.getdatawbykey2(_helper.getdatawbykey2("ID")[index])["Title_Image"],fit: BoxFit.fitWidth,height: 14.h,width:100.w)),
          
                 ),
                  Row(
          
                   mainAxisAlignment: MainAxisAlignment.start,
                   children:[ 
                     Padding(padding:EdgeInsets.only(left:3.w,top:1.h),
                     child: Text(_helper.getdatawbykey2(_helper.getdatawbykey2("ID")[index])["last_updated"].toString().substring(0,10),style:GoogleFonts.poppins(fontSize: 10.sp,fontWeight: FontWeight.w500,color:Colors.white)))
                   ]),
                 Padding(padding:EdgeInsets.only(left:2.w),
                 
                 
                 child: Text(_helper.getdatawbykey2(_helper.getdatawbykey2("ID")[index])["Title"],style:GoogleFonts.poppins(fontSize: 11.sp,fontWeight: FontWeight.w500,color:Colors.white),overflow:TextOverflow.ellipsis,maxLines: 2,)),
                
               ],)
          
              
          
          
            ):null
          );
        
      },
      ),
    ),
     
    )
      
    );
  }
  


  Widget loading(context){
    return const Scaffold(
      body: Center(child: CircularProgressIndicator(color:Colors.white10),)
    );
  }

showwidgets currentstate=showwidgets.SHOW_LODING;
  @override


  Widget build(BuildContext context) {
    return Scaffold(resizeToAvoidBottomInset: false,
      body: currentstate==showwidgets.SHOW_LODING?loading(context):technical(context),
    );
  }
}