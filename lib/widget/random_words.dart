import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:english_words/english_words.dart';

class RandomWords extends StatefulWidget {
  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final List<WordPair> _suggestions = <WordPair>[];
  final TextStyle _fontSize = const TextStyle(fontSize: 20);
  final Set<WordPair> _savedNames = Set<WordPair>();

  Widget _buildSuggestions() {
    return ListView.builder(itemBuilder: (BuildContext _context, int i) {
      if (i.isOdd) {
        return Divider();
      }

      final index = i ~/ 2;

      if (index >= _suggestions.length) {
        _suggestions.addAll(generateWordPairs().take(10));
      }

      return _buildRow(_suggestions[index]);
    });
  }

  Widget _buildRow(WordPair pair) {
    final bool alreadySaved = _savedNames.contains(pair);

    return ListTile(
      title: Text(pair.asPascalCase, style: _fontSize),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          alreadySaved ? _savedNames.remove(pair) : _savedNames.add(pair);
        });
      },
    );
  }

  _pushSavedRoute() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      final Iterable<ListTile> tiles = _savedNames.map((WordPair pair) {
        return ListTile(
          title: Text(
            pair.asPascalCase,
            style: _fontSize,
          ),
        );
      });

      final List<Widget> divided =
          ListTile.divideTiles(context: context, tiles: tiles).toList();

      return Scaffold(
          appBar: AppBar(
            title: Text("Saved suggestions"),
          ),
          body: ListView(children: divided));
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Startup Name Generator"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.list),
            onPressed: _pushSavedRoute,
          )
        ],
      ),
      body: _buildSuggestions(),
    );
  }
}
