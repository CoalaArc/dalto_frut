import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';

import 'package:flutter_tts/flutter_tts.dart';

class TakePictureScreen extends StatefulWidget {
  final CameraDescription camera;

  const TakePictureScreen({
    Key key,
    @required this.camera,
  }) : super(key: key);

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  CameraController _controller;
  Future<void> _initializeControllerFuture;

  FlutterTts flutterTts = FlutterTts();

  speak(String text) async {
    await flutterTts.setLanguage('pt-BR');
    await flutterTts.setPitch(1);
    await flutterTts.speak(text);
  }

  @override
  void initState()  {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.ultraHigh,
    );
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tire uma foto')),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(_controller);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(Icons.camera_alt, color: Color(0xFF302C58),),
        onPressed: () async {
          try {
            await _initializeControllerFuture;
            final path = join(
              (await getExternalStorageDirectory()).path,
              '${DateTime.now()}.jpeg',
            );
            await _controller.takePicture(path);

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DisplayPictureScreen(imagePath: path),
              ),
            );

            showDialog( context: context,
                builder: (context){
                  return AlertDialog(
                    title: Text('COR PREDOMINANTE', textAlign: TextAlign.center, style: TextStyle(fontSize: 16),),
                    content: Text('Verde', textAlign: TextAlign.center, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
                    actions: <Widget>[
                      TextButton(child: Text('Fechar'), onPressed: () {
                        Navigator.pop(context);
                      }),
                      TextButton(child: Text('Ouvir'), onPressed: () {
                        speak('Verde');
                      }),
                    ],
                  );
                },
            );
          } catch (e) {
            print(e.toString());
            return showDialog( context: context,
                builder: (context){
                  return AlertDialog(
                    title: Text('DaltoError'),
                    content: Text(e),
                    actions: <Widget>[
                      TextButton(child: Text('Fechar'), onPressed: () {
                        Navigator.pop(context);
                      }),
                    ],
                  );
                });
          }
        },
      ),
    );
  }
}

class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;
  const DisplayPictureScreen({Key key, this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: Text('Display the Picture')),
      body: Image.file(
        File(imagePath),
        height: size.height,
        width: size.width,
        fit: BoxFit.fill,
        filterQuality: FilterQuality.high,
      ),
    );
  }
}