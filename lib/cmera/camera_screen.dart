import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
//careate a list 
List<CameraDescription> cameras = [];
int index = 0;

class CmeraScreen extends StatefulWidget {
  const CmeraScreen({super.key});

  @override
  State<CmeraScreen> createState() => _CmeraScreenState();
}



class _CmeraScreenState extends State<CmeraScreen> {
//cmera  page code
  late CameraController _cmeraController;
  Future<void>? cmeraValue;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _cmeraController = CameraController(cameras[0], ResolutionPreset.high);
  cmeraValue  = _cmeraController.initialize();
  }

  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
          child: FutureBuilder(
            future: cmeraValue,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if(snapshot.connectionState == ConnectionState.done){  //resulit of future store in sanpshot
              return CameraPreview(_cmeraController);
            }else{
              return  const CircularProgressIndicator();
            }
            },
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              CircleAvatar(),
            ],
          ),
        ),
        const Icon(Icons.panorama_fish_eye_outlined,size: 100,),
        IconButton(onPressed: 
        () {
          print(index);
          setState(() {
            index =index  ==0 ? 1:0;
           _cmeraController  =  CameraController(cameras[index],ResolutionPreset.max);
           cmeraValue = _cmeraController.initialize();
          });
        }, icon: Icon(Icons.camera_alt_rounded,size: 40,))
      ],
    );
  }
}
