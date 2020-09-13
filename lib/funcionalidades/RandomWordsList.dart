
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class RandomWords extends StatefulWidget {
  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _saved = Set<WordPair>(); // diferente de list pq n aceita registro duplicado
  final _biggerFont = TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    print('*************Initializing RandonWords******************');
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator'),
        actions: [
          IconButton(icon: Icon(Icons.list), onPressed: _pushSaved),
        ],
      ),
      body: _buildSuggestions(context),
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        // NEW lines from here...
        builder: (BuildContext context) {
          final tiles = _saved.map(
                (WordPair pair) {
              return ListTile(
                title: Text(
                  pair.asPascalCase,
                  style: _biggerFont,
                ),
              );
            },
          );
          final divided = ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList();

          return Scaffold(
            appBar: AppBar(
              title: Text('Saved Suggestions'),
            ),
            body: ListView(children: divided),

            floatingActionButton: FloatingActionButton(
              onPressed: () {
                  print('pressed');
              },
              tooltip: 'Toogle Opacity',
              child: Icon(Icons.save),
            ),

          );
        }, // ...to here.
      ),
    );
  }


  Widget _buildSuggestions(BuildContext context) {
    print('_buildSuggestions');
    return ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemBuilder: /*1*/ (context, i) {
          print('index: $i ');
          if (i.isOdd) {
            print('divider');
            return Divider(); /*2*/
          }

            final index = i ~/ 2; /*3*/
            print('_suggestions.length: $_suggestions');
            if (index >= _suggestions.length) {
              _suggestions.addAll(generateWordPairs().take(10)); /*4*/
              print('10 added');
            }
            return _buildRow(_suggestions[index]);
        });
  }

  Widget _buildRow(WordPair pair) {
    print('_buildRow');
    final alreadySaved = _saved.contains(pair);
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if(alreadySaved) {
            _saved.remove(pair);
          }else{
            _saved.add(pair);

          }
        });
      },
    );
  }


}