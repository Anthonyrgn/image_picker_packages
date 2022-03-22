import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  File? imageFile;
  ImagePicker picker = ImagePicker();


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            (imageFile == null)
              ? Text("Aucune image")
              : Image.file(imageFile!, height: MediaQuery.of(context).size.height / 2,),

            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton(onPressed: (){
                  pickImage(ImageSource.gallery);
                }, child: Icon(Icons.photo_album),),
                FloatingActionButton(onPressed: (){
                  pickImage(ImageSource.camera);
                }, child: Icon(Icons.camera_enhance),),
              ],
            )
          ],
        ),
      ),
    );
  }

  Future pickImage(ImageSource) async {
    PickedFile? chosenImage = await picker.getImage(source: ImageSource);
    setState(() {
      if (chosenImage == null){
        print("Nous n'avons pas pu récupéré d'image");
      } else {
        imageFile = File(chosenImage.path);
      }
    });
  }
}
