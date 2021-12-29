import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class Nav extends StatelessWidget {
 

  @override
  Widget build(BuildContext context) {
    

    return Theme(data:Theme.of(context).copyWith(canvasColor: const Color(0xff1c2833)),
      child: Drawer(
        
          child: ListView(children: [
            DrawerHeader(
              padding: EdgeInsets.only(top:15.h,left: 2.8.w),
              child:Text("EchoStocks",style:GoogleFonts.poppins(fontSize: 13.sp,fontWeight: FontWeight.w600,color:Colors.white,letterSpacing:1.5)),
            decoration: const BoxDecoration(
              
              image:DecorationImage(image: NetworkImage("https://i.picsum.photos/id/615/200/300.jpg?hmac=ehJCfeXO1-ZbwBXgbYKroA97kTtoPKNoyEbCxnzsYfU"),fit: BoxFit.fill)
            ),
            
            ),
            ListTile(
              leading: Icon(Icons.home,color: Colors.white,size:18.sp),
              selected :true,
              selectedTileColor: const Color(0xff17202a),
              onTap:(){},
              title:Text("Home",style: GoogleFonts.poppins(fontSize:11.sp,color: Colors.white,fontWeight: FontWeight.w700,letterSpacing: 2),)
    
            ),
    
              ListTile(
              leading: Icon(Icons.share,color: Colors.white,size:18.sp),
              title:Text("Share",style: GoogleFonts.poppins(fontSize:11.sp,color: Colors.white,fontWeight: FontWeight.w700,letterSpacing: 2),),
               

              onTap: (){
                Share.share("Check out our App",subject: "EcoStocks",
                
                

                );
              },
               selectedTileColor: const Color(0xff17202a),
              //tileColor: Colors.purple,
    
    
            ),
    
              ListTile(
              leading: Icon(Icons.feedback,color: Colors.white,size:18.sp),
               selectedTileColor: const Color(0xff17202a),
              title:Text("Feedback",style: GoogleFonts.poppins(fontSize:11.sp,color: Colors.white,fontWeight: FontWeight.w700,letterSpacing: 1.9),),
              onTap: ()async{
                const String _url="https://www.google.com/";
                if(await canLaunch(_url)){
                  await launch(_url);
                }

              },
    
            ),
           
    
              ListTile(
              leading: Icon(Icons.bug_report_sharp,color: Colors.white,size:18.sp),
               selectedTileColor: const Color(0xff17202a),
              title:Text("Report a Bug",style: GoogleFonts.poppins(fontSize:11.sp,color: Colors.white,fontWeight: FontWeight.w700,letterSpacing: 1.8),)
    
            ),
             
            
            
        
          ],),
      
      ),
    );
  }
}