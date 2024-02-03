import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'emoji_model.dart';
import 'package:html/parser.dart' show parse;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Emoji list and details',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const EmojiListScreen(),
    );
  }
}

class EmojiListScreen extends StatefulWidget {
  const EmojiListScreen({Key? key}) : super(key: key);

  @override
  _EmojiListScreenState createState() => _EmojiListScreenState();
}

// function to convert emoji html code to display
String _decodeHtmlEmoji(String text) {
  return parse(text).body!.text;
}

class _EmojiListScreenState extends State<EmojiListScreen> {
  List<Emoji> _emoji = [];

  @override
  void initState() {
    super.initState();
    _loadAndShowEmoji();
  }

  Future<List<Emoji>> _loadEmoji() async {
    var url = Uri.parse('https://emojihub.yurace.pro/api/all');
    var response = await http.get(url);
    final result = resultFromJson(response.body);
    return result;
  }

  void _loadAndShowEmoji() async {
    var emoji = await _loadEmoji();
    setState(() {
      _emoji = emoji;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_emoji.isEmpty) {
      _loadAndShowEmoji();
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(), // loading icon
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: const Text('Emoji list'),
      ),
      body: ListView.separated(
        itemCount: _emoji.length,
        separatorBuilder: (BuildContext context, int i) => Divider(
          height: 5,
        ),
        itemBuilder: (BuildContext context, int i) {
          return ListTile(
            contentPadding: const EdgeInsets.all(5.0),
            title: Text(
                _emoji[i].name + " " + _decodeHtmlEmoji(_emoji[i].htmlCode[0])),
            minVerticalPadding: 0,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EmojiDetailScreen(emoji: _emoji[i]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class EmojiDetailScreen extends StatelessWidget {
  final Emoji emoji;

  const EmojiDetailScreen({Key? key, required this.emoji}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Icon: ${_decodeHtmlEmoji(emoji.htmlCode[0])}',
              style: Theme.of(context).textTheme.headline5,
            ),
            SizedBox(height: 8),
            Text(
              'Name: ${emoji.name}',
              style: Theme.of(context).textTheme.headline5,
            ),
            SizedBox(height: 8),
            Text(
              'Category: ${emoji.category.name}',
              style: TextStyle(fontSize: 15),
            ),
            SizedBox(height: 8),
            Text(
              'Group: ${emoji.group.name}',
              style: TextStyle(fontSize: 15),
            ),
            SizedBox(height: 8),
            Text(
              'HtmlCode: ${emoji.htmlCode[0]}',
              style: TextStyle(fontSize: 15),
            ),
            SizedBox(height: 8),
            Text(
              'Unicode: ${emoji.unicode[0]}',
              style: TextStyle(fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
}
