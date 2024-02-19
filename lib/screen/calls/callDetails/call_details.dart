import 'package:flutter/material.dart';

import '../callmodels/call_model.dart';
class CallDetails extends StatelessWidget {
   CallDetails({super.key,required this.details});
   UserCall details;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 200,
        leading: Row(
          
          children: [
           IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.arrow_back),),
            
          ],
        ),
        title: const Text("Call info"),
        actions: [
          
          const Icon(Icons.message),
          PopupMenuButton(itemBuilder: (context){
            return [
              const PopupMenuItem(child: Text("Remove from call log")),
              const PopupMenuItem(child: Text("Block"))
            ];
          } ,)
        ],
      ),
      body:ListView.builder(
        itemCount: 1,
        itemBuilder: (BuildContext context, int index) {
          return   Column(
            children: [
              ListTile(    
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(details.image!),
                  ),
                  title: Text(details.name.toString()),
                  subtitle: const Text("data"),
                   trailing: Row(
                    mainAxisSize: MainAxisSize.min, //it used avoid white screen popup
                     children:const [
                       Icon(Icons.call),
                       Icon(Icons.video_call)
                     ],
                   ),
                   
                  
                  

              ),
              //Text(details.updateAt.toString())
              
            ],
          );
        },
      ),
      // body:  ListTile(
      //   leading: CircleAvatar(
      //     radius: 30,
      //     backgroundImage: NetworkImage(""),
      //   ),
      //   title: Text("arjun"),
      //   subtitle: Text("never giveup..."),
      //   trailing: Row(
      //     children: [
      //       Icon(Icons.call),
      //       Icon(Icons.video_call)
      //     ],
      //   ),
      // ),
      // body: Row(
      //   children: const [
      //     CircleAvatar(
      //       radius: 30,
      //       backgroundImage: NetworkImage(""),
      //     ),
      //     Text("Arjun"),
          
          
      //   ],
        
      // ),
    );
  }
}