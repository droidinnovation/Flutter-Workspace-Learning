import 'package:flutter/material.dart';

void main() {
  runApp(
    MyApp(
      lists: List<ListItem>.generate(
        100,
        (index) => index % 5 == 0
            ? HeadingItem(heading: 'Heading $index')
            : MessageItem('Sender $index', 'Body $index'),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  final List<ListItem> lists;

  const MyApp({super.key, required this.lists});

  @override
  Widget build(BuildContext context) {
    const String appTitle = 'Mixed List demo';

    return MaterialApp(
      title: appTitle,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
      ),
      home: Scaffold(
        appBar: AppBar(title: Text(appTitle)),
        body: ListView.builder(
          itemCount: lists.length,
          itemBuilder: (context, index) {
            final item = lists[index];
            return ListTile(
              title: item.buildTitle(context),
              subtitle: item.buildSubtitle(context),
            );
          },
        ),
      ),
    );
  }
}

// Base class for the difference types of items
abstract class ListItem {
  Widget buildTitle(BuildContext context);
  Widget buildSubtitle(BuildContext context);
}

class HeadingItem implements ListItem {
  final String heading;

  HeadingItem({required this.heading});

  @override
  Widget buildSubtitle(BuildContext context) {
    return Text(heading, style: Theme.of(context).textTheme.headlineSmall);
  }

  @override
  Widget buildTitle(BuildContext context) => const SizedBox.shrink();
}

class MessageItem implements ListItem {
  final String sender;
  final String body;

  MessageItem(this.sender, this.body);

  @override
  Widget buildSubtitle(BuildContext context) => Text(sender);

  @override
  Widget buildTitle(BuildContext context) => Text(body);
}
