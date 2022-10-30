import 'package:flutter/material.dart';
import 'package:whatsapp_clone/Status/models/status_model.dart';

import 'status_tile.dart';

class StatusScreen extends StatelessWidget {
   StatusScreen({super.key});
  List<UserStatus> Status = [
    UserStatus(image: 'https://images.pexels.com/photos/1595387/pexels-photo-1595387.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    name: "arjun",
    updateAt: "10.0am",
    ),
     UserStatus(image: "https://images.pexels.com/photos/7218223/pexels-photo-7218223.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load",
    name: "arun",
    updateAt: "12.0am",
    ),
     UserStatus(image: "https://images.pexels.com/photos/4099321/pexels-photo-4099321.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load",
    name: "akhil",
    updateAt: "10.0am",
    ),
     UserStatus(image: "https://images.pexels.com/photos/3760787/pexels-photo-3760787.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
    name: "hannan",
    updateAt: "04.0pm",
    ),
     UserStatus(image: "https://images.pexels.com/photos/1187086/pexels-photo-1187086.jpeg?auto=compress&cs=tinysrgb&w=600",
    name: "anvith",
    updateAt: "03.0pm",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: Status.length,
        itemBuilder: (BuildContext context, int index) {
          return StatusTile(userData: Status[index] ,);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.camera_alt),
      ),
    );
  }
}
