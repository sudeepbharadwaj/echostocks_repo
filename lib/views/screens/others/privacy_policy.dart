import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../../models/pp_model.dart';




class Policy extends StatelessWidget {
   const Policy({Key? key}) : super(key: key);




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Privacy Policy',
        style: GoogleFonts.poppins(fontSize:15.sp,fontWeight: FontWeight.w500,color: Colors.white),

        ),
      ),
      body: SafeArea(
        
        child:SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Html(
          style:{
                  "body":Style(color: Colors.white)
                } ,
            data:privacypolicy

          
          ),
        ) 
      
      
      ),
    );
  }
}