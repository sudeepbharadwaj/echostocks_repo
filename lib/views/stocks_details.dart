import 'package:ecostocks/models/data_helper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_html/flutter_html.dart';



class Details extends StatefulWidget {

  int i;
  Details({Key? key, required this.i}) : super(key: key);
  

  @override
  // ignore: no_logic_in_create_state
  _DetailsState createState() => _DetailsState(i);
}

class _DetailsState extends State<Details> {

   int i;
  _DetailsState(this.i);


  var _htmldata="""
     <h1>H1 Title</h1>
     <h2>H2 Title</h2>
        <p>A paragraph with <strong>bold</strong> and <u>underline</u> text.</p>
        <ol>
          <li>List 1</li>
          <li>List 2<ul>
              <li>List 2.1 (nested)</li>
              <li>List 2.2</li>
             </ul>
          </li>
          <li>Three</li>
        </ol>
     <a href="https://www.hellohpc.cdom">Link to HelloHPC.com</a>
     <img src='https://www.hellohpc.com/wp-content/uploads/2020/05/flutter.png'/>
    """;


final DBHelper _helper=DBHelper();

bool _isloading=false;

@override
void initState(){
  super.initState();
  WidgetsBinding.instance!.addPostFrameCallback((_) {
    setState(() {
      _isloading=true;
    });
  });
}

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,

      body:SafeArea(
        minimum: EdgeInsets.only(left:3.w,right:2.5.w),
        left:true,
        
        child:Visibility(visible: _isloading,replacement: const Center(child: CircularProgressIndicator(color: Colors.white10,),),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: 
            (_helper.getdatawithkey(_helper.getdatawithkey("ID")[i])["analysis"]!=null)?
            Column(
            crossAxisAlignment: CrossAxisAlignment.start,
        
              children: 
              
              [
                Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    
                  children: [
                    
                    IconButton(onPressed: (){
                      Navigator.pop(context);
                    }, icon: Icon(Icons.keyboard_arrow_left,size:25.sp,color:Colors.white)),
                    
                    Padding(
                      padding:EdgeInsets.only(left:22.w,top:1.2.h,bottom:4.6.h),
                      child: Text("Analysis",style: GoogleFonts.poppins(fontSize:14.sp,fontWeight: FontWeight.w600,color:Colors.white,letterSpacing: 1.6),))
                  ],
                ),
                Center(child: Text(_helper.getdatawithkey(_helper.getdatawithkey("ID")[i])["company_name"],style: GoogleFonts.poppins(fontSize:15.sp,fontWeight: FontWeight.w500,color:Colors.white,letterSpacing: 1.4),)),
              
              Center(
                child: Container(
                  height:3.h,width:15.w,
                  margin: EdgeInsets.only(top:1.4.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),color:(_helper.getdatawithkey(_helper.getdatawithkey("ID")[i])["call"]=="Buy")?Colors.green[900]:Colors.red[600],
                    
                  ),child: Center(child:  Text(_helper.getdatawithkey(_helper.getdatawithkey("ID")[i])["call"],style: GoogleFonts.poppins(fontSize:12.sp,fontWeight: FontWeight.w700,color:Colors.white,letterSpacing: 1),),),),
              ),
              
              SizedBox(height:5.h),
        
              Row(
                
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  
              Expanded(
                child: Column(
                  children: [
                    Text("CMP",style: GoogleFonts.poppins(fontSize:12.sp,fontWeight: FontWeight.w600,color:Colors.white,letterSpacing: 1.6),),
                    SizedBox(height:1.h),
                    Text(_helper.getdatawithkey(_helper.getdatawithkey("ID")[i])["cmp"].toString(),style: GoogleFonts.poppins(fontSize:11.sp,fontWeight: FontWeight.w600,color:Colors.white,letterSpacing: 1.6),)
                    
                  ],
                ),
              ),
               Expanded(
                 child: Column(
                  children: [
                    Text("Duration",style: GoogleFonts.poppins(fontSize:12.sp,fontWeight: FontWeight.w600,color:Colors.white,letterSpacing: 1.6),),
                     SizedBox(height:1.h),
                    Text(_helper.getdatawithkey(_helper.getdatawithkey("ID")[i])["call_type"],style: GoogleFonts.poppins(fontSize:10.8.sp,fontWeight: FontWeight.w600,color:Colors.white,letterSpacing: 1.6),)
                    
                  ],
                           ),
               ),
               Expanded(
                 child: Column(
                  children: [
                    Text("Status",style: GoogleFonts.poppins(fontSize:12.sp,fontWeight: FontWeight.w600,color:Colors.white,letterSpacing: 1.6),),
                     SizedBox(height:1.h),
                    Text(_helper.getdatawithkey(_helper.getdatawithkey("ID")[i])["current_status"],style: GoogleFonts.poppins(fontSize:11.sp,fontWeight: FontWeight.w600,color:Colors.white,letterSpacing: 1.6),)
                    
                  ],
                           ),
               ),
              ],),
              SizedBox(height:5.h),
        
               Row(
                
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  
              Expanded(
                child: Column(
                  children: [
                    Text("Target",style: GoogleFonts.poppins(fontSize:12.sp,fontWeight: FontWeight.w600,color:Colors.white,letterSpacing: 1.6),),
                    SizedBox(height:1.h),
                    Text(_helper.getdatawithkey(_helper.getdatawithkey("ID")[i])["target"].toString(),style: GoogleFonts.poppins(fontSize:11.sp,fontWeight: FontWeight.w600,color:Colors.white,letterSpacing: 1.6),)
                    
                  ],
                ),
              ),
               Expanded(
                 child: Column(
                  children: [
                    Text("Stop Loss",style: GoogleFonts.poppins(fontSize:12.sp,fontWeight: FontWeight.w600,color:Colors.white,letterSpacing: 1.6),),
                     SizedBox(height:1.h),
                    Text(_helper.getdatawithkey(_helper.getdatawithkey("ID")[i])["stop_loss"].toString(),style: GoogleFonts.poppins(fontSize:10.8.sp,fontWeight: FontWeight.w600,color:Colors.white,letterSpacing: 1.6),)
                    
                  ],
                           ),
               ),
               Expanded(
                 child: Column(
                  children: [
                    Text("Price",style: GoogleFonts.poppins(fontSize:12.sp,fontWeight: FontWeight.w600,color:Colors.white,letterSpacing: 1.6),),
                     SizedBox(height:1.h),
                    Text(_helper.getdatawithkey(_helper.getdatawithkey("ID")[i])["reco_price"].toString(),style: GoogleFonts.poppins(fontSize:11.sp,fontWeight: FontWeight.w600,color:Colors.white,letterSpacing: 1.6),)
                    
                  ],
                           ),
               ),
              ],),
              SizedBox(height: 5.h,),
        
              Padding(
                padding: EdgeInsets.only(left:3.w),
                child: Text("Analysis : ",style: GoogleFonts.poppins(fontSize:14.sp,fontWeight: FontWeight.w600,color:Colors.white,letterSpacing: 1.6),)),
                Html(data: _htmldata,
                style:{
                  "body":Style(color: Colors.white)
                } ,
                ),
        
        
              
        
        
              ],
            ):Center(child:Text("No Data Available",style: GoogleFonts.poppins(fontSize:15.sp,fontWeight: FontWeight.w500,color:Colors.white,letterSpacing: 1.6),) ,)
          ),
        ) 
      
      )

      

      
    );
  }
}