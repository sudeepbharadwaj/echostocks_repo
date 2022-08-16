import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../../models/T&C_model.dart';



class TC extends StatelessWidget {
   const TC({Key? key}) : super(key: key);




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Terms & Conditions',
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
            data:tc

          
          ),
        ) 
      
      
      ),
    );
  }
}

