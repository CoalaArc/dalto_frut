import 'package:flutter/material.dart';

void main()  {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Nunito',
        primaryColor: Color(0xFF4EFFBB),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'DaltoFrut'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;
  MyHomePage({this.title});

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
                      onPressed: (){
                        print('Fui clicado');
                        return showDialog( context: context,
                            builder: (context){
                              return AlertDialog(
                                title: Text('DaltoFrut'),
                                content: Text('Fui clicado !!'),
                                actions: <Widget>[
                                  TextButton(child: Text('Fechar'), onPressed: () {
                                    Navigator.pop(context);
                                  }),
                                  TextButton(child: Text('Fechar 2'), onPressed: () {
                                    Navigator.pop(context);
                                  }),
                                ],
                              );
                            });
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

