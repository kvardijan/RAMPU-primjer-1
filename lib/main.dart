import 'dart:math';

import 'package:flutter/material.dart';
import 'package:workmanager/workmanager.dart';

void pozadinskaFunkcija() {
  Workmanager().executeTask((imeZadatka, inputData) {
    switch (imeZadatka) {
      case "prviZadatak":

        print("Pozadinski zadatak $imeZadatka je započeo u pozadini. Dobiveni podaci su $inputData");
        break;
      case "drugiZadatak":
        print("Pozadinski zadatak $imeZadatka je započeo u pozadini. Dobiveni podaci su $inputData");
        break;
      default:
    }

    return Future.value(true);
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Workmanager().initialize(pozadinskaFunkcija, isInDebugMode: true);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter zadatak",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Pocetna(),
    );
  }
}

class Pocetna extends StatelessWidget {
  const Pocetna({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("Uspostava Work managera"),
      ),
      body: Wrap(
          children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () async {
              print("Započinjem pozadisnki zadatak 1.");
              var id = DateTime.now().second.toString();
              await Workmanager().registerPeriodicTask(
                id,
                "prviZadatak",
                initialDelay: Duration(seconds: 3),
                inputData: <String, dynamic>{
                  'string' : 'Podaci za prvi zadatak',
                },
              );
            },
            child: Text("Započni zadatak 1"),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () async {
              print("Započinjem pozadisnki zadatak 2.");
              var id = DateTime.now().second.toString();
              await Workmanager().registerPeriodicTask(
                id,
                "drugiZadatak",
                initialDelay: Duration(seconds: 3),
                inputData: <String, dynamic>{
                  'string' : 'Podaci za drugi zadatak',
                },
              );
            },
            child: Text("Započni zadatak 2"),
          ),
        ),
      ]),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.stop),
        onPressed: () {
          print("Zaustavljam pozadinske zadatke.");
          Workmanager().cancelAll();
        },
      ),
    );
  }
}
