import 'package:cached_network_image/cached_network_image.dart';
import 'package:echostocks/models/snackbar.dart';
import 'package:flutter/material.dart';


// ignore: must_be_immutable
class Expandedimg extends StatefulWidget {
  int index;
  String type;
   Expandedimg({Key? key , required  this.index,required this.type}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<Expandedimg> createState() => _ExpandedimgState(index,type);
}

class _ExpandedimgState extends State<Expandedimg> with SingleTickerProviderStateMixin {
  int index;
  String type;
  _ExpandedimgState(
      this.index,
      this.type
  );

late final TransformationController transformationController;

late AnimationController animationController;

Animation <Matrix4>? animation;


  @override 
  void initState(){
    super.initState();
    transformationController=TransformationController();
    animationController=AnimationController(vsync: this,
    duration: const Duration(milliseconds: 200)
    )..addListener(() {transformationController.value=animation!.value;}
    );
   
    
  
  }

   @override
   void dispose(){
    transformationController.dispose();
    animationController.dispose();
    super.dispose();
   }

   Future getimg()async{
    var _res;
    if(type=='feed'){
     _res=await feedquery.queryspecific(index);
     return _res;
    }

    else{
      _res=await catquery.catqueryspecific2(index);
     return _res;


    }

    
  }

 

  void resetAnimation(){
    animation=Matrix4Tween(
      begin: transformationController.value,
      end: Matrix4.identity()
    ).animate(CurvedAnimation(parent: animationController, curve:Curves.decelerate)); 

    animationController.forward(from: 0);
      
    }


  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(''),
        backgroundColor: const Color(0xFF080D13),
      ),
      body: Center(
       
            child: FutureBuilder(future: getimg(),
            builder: (BuildContext context,AsyncSnapshot snapshot){
              if(snapshot.hasData){
              return 
              (Uri.parse(snapshot.data[0]['title_image']).isAbsolute || snapshot.data[0]['title_image']==null)?
               InteractiveViewer(minScale: 1,maxScale: 4,
                clipBehavior: Clip.none,
                panEnabled: false,
                transformationController: transformationController,

                onInteractionEnd: ((details) {
                  resetAnimation();
                }),

               
                 
                   child: AspectRatio(aspectRatio: 1,
                     child: ClipRRect(borderRadius: BorderRadius.circular(8),
                       child: CachedNetworkImage(imageUrl: 
                            snapshot.data[0]['title_image'],
                            //height: 20.h,
                            filterQuality: FilterQuality.low,
                             fit: BoxFit.fill,
                             errorWidget: ((context, url, error) {
                                                  return Image.asset('assets/img/banner.png');
                                        
                                                }),
                            placeholder: (context,url){
                              return Image.asset('assets/img/banner.png');
                                    
                            },
                            
                                        
                          
                        
                                      ),
                     ),
                   ),
               ):Image.asset('assets/img/banner.png',
                                  filterQuality: FilterQuality.low,
                                  fit: BoxFit.fill,
                                  );
              }
          
              else{
                return const SizedBox();
              }
            }),
          
          
          
        ),
      
    );


    
  }
}