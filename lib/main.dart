import 'package:dalto_frut/take_picture_screen.dart';
import 'package:flutter/material.dart';

import 'package:camera/camera.dart';

Future<void> main() async {


  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // final CameraDescription camera;
  //
  // const MyApp({
  //   Key key,
  //   @required this.camera,
  // }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DaltoFrut',
      initialRoute: '/',
      routes: {
        "/": (context) => MyHomePage(),
        // "/take_picture_page": (context) => TakePictureScreen(camera: null,),
      },
      theme: ThemeData(
        fontFamily: 'Nunito',
        primaryColor: Color(0xFF4EFFBB),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.2, 0.8],
            colors: [
              Color(0xFF70E1F5),
              Color(0xFFFFD194),
            ],
          ),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Container(
                    //Header (logo)
                    height: constraints.maxHeight * .47,
                    child: Image.asset(
                      'lib/assets/logo.png',
                      height: 170,
                      width: 140,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Container(
                    //Body(textos)
                    height: constraints.maxHeight * .33,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'SEJA BEM-VINDO',
                          style: TextStyle(
                            color: Color(0xFF302C58),
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 40.0),
                          child: Text(
                            'PARA COMEÇAR\nCLIQUE NO BOTÃO ABAIXO E\nAPONTE A CÂMERA PARA O OBJETO',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF302C58),
                              height: 1.5,
                              letterSpacing: 1.25,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    //Footer(botao)
                    height: 53,
                    child: RaisedButton(
                      color: Color(0xFF4EFFBB),
                      onPressed: () async {
                        WidgetsFlutterBinding.ensureInitialized();
                        final cameras = await availableCameras();
                        final firstCamera = cameras.first;

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TakePictureScreen(camera: firstCamera),
                          ),
                        );
                      },
                      child: ListTile(
                        title: Center(
                          child: Text(
                            'ABRIR CÂMERA',
                            style: TextStyle(
                              color: Color(0xFF302C58),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        trailing: Icon(Icons.camera_alt,
                          color: Color(0xFF302C58),),
                      )
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}



