import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:teledart/model.dart';
//import 'package:teledart/model.dart';
import 'package:teledart/teledart.dart';
import 'package:teledart/telegram.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo Bot',
      theme: ThemeData(
        
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Bot'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
 
 final telegram = Telegram('6622522645:AAEzQznIXLr-gFT3pVT5LK8Zlsuthbr8Mzk');
 final envVars = Platform.environment;
/// final username = (Telegram(envVars['6622522645:AAEzQznIXLr-gFT3pVT5LK8Zlsuthbr8Mzk']!).getMe()).username;
 late TeleDart teledart;
 String botName = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BOT'),
        actions: [
          IconButton(icon: Icon (Icons.play_arrow), onPressed: () => _startBot())
        ],
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
        ),
      ),
     
      ); // This trailing comma makes auto-formatting nicer for build methods.
    
  }

  _startBot() async {
    var botToken = '6622522645:AAEzQznIXLr-gFT3pVT5LK8Zlsuthbr8Mzk';
    //teledart = TeleDart(telegram, Event(username!));
    final username = (await Telegram(botToken).getMe()).username;
    teledart = TeleDart(botToken, Event(username!));
    teledart.start();

    teledart.onMessage(entityType: 'bot_command', keyword: 'start').listen(
      (message) => teledart.sendMessage(message.chat.id, '#a2fa4880'));
    
    teledart.onMessage().listen((message) => teledart.sendMessage(message.chat.id, 'this is text'));

    teledart.onCommand('glory').listen((message) => message.reply('For Azerot'));

    teledart.onCommand(RegExp('hello', caseSensitive: false)).listen((message) => message.reply('привет!'));

    teledart.onMessage(keyword: 'hello').listen((message) => message.reply('Привет'));
    //teledart.onMessage(keyword: 'menu').listen((message) => InlineKeyboardButton.(event) => (message.text, 'text'));
    teledart.onMessage(keyword: 'dart').where((message) => 
      message.text?.contains('telegram') ?? false).
      listen((message) => message.replyPhoto('https://raw.githubusercontent.com/DinoLeung/TeleDart/master/example/dash_paper_plane.png',
      caption: 'This is how the Dart Bird and Telegram are met'));

      
  }

}
