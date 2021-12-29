import 'package:ecostocks/models/data_helper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_html/flutter_html.dart';


// ignore: camel_case_types
class outlookDetail extends StatefulWidget {
  
  int index;
  outlookDetail({Key? key, required this.index}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  _outlookDetailState createState() => _outlookDetailState(index);
}

// ignore: camel_case_types
class _outlookDetailState extends State<outlookDetail> {

  int index;
  _outlookDetailState(this.index);

  final DBHelper _helper=DBHelper();

  bool _isloading=false;

  @override
  void initState(){
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      if(mounted){
      setState(() {
        _isloading=true;
      });}
      
    });
  }



  var _outlookdata="""
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
  @override
  Widget build(BuildContext context) {
    return Scaffold( resizeToAvoidBottomInset: false,
    body:SafeArea(
       minimum: EdgeInsets.only(left:3.w,right:2.5.w),
        left:true,
        
        child:Visibility(visible: _isloading,replacement: const Center(child: CircularProgressIndicator(color:Colors.white10),),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child:
            (_helper.getdatabykey1(_helper.getdatabykey1("ID")[index])["Description"]!=null)?
            Column(
               crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    
                  children: [
                    
                    IconButton(onPressed: (){
                       Navigator.pop(context);
                    }, icon: Icon(Icons.keyboard_arrow_left,size:25.sp,color:Colors.white)),
                    
                    Padding(
                      padding:EdgeInsets.only(left:22.w,top:1.2.h,bottom:4.6.h),
                      child: Text("Pointers",style: GoogleFonts.poppins(fontSize:14.sp,fontWeight: FontWeight.w600,color:Colors.white,letterSpacing: 1.6),))
                  ],
                ),
                Html(data: _outlookdata,
                style:{
                  "body":Style(color: Colors.white)
                } ,
                )
        
            ],):Center(child:Text("No Data Available",style: GoogleFonts.poppins(fontSize:14.5.sp,fontWeight: FontWeight.w500,color:Colors.white,letterSpacing: 1.6),) ,)
          ),
        )
    )
      
    );
  }
}
