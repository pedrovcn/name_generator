import 'package:app1/widget/random_words.dart';
import 'package:flutter/material.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Random Words',
      debugShowCheckedModeBanner: false,
      home: RandomWords(),
      theme: ThemeData(primaryColor: Colors.purple),
    );
  }
}
