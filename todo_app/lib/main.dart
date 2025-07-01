import 'package:flutter/material.dart';
import 'package:todo_app/data.dart';

void main() {
  runApp(const DocumentApp());
}

class DocumentApp extends StatelessWidget {
  const DocumentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(),
      home: DocumentScreen(document: Document()),
    );
  }
}

class DocumentScreen extends StatelessWidget {
  final Document document;

  const DocumentScreen({super.key, required this.document});

  @override
  Widget build(BuildContext context) {
    // final metadataRecord = document.metadata;
    final (title, :modified) = document.metadata;
    final formattedModifiedDate = formatDate(modified);
    final blocks = document.getBlocks();

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Column(
        children: [
          Text('Last modified $formattedModifiedDate'),
          Expanded(
            child: ListView.builder(
              itemCount: blocks.length,
              itemBuilder: (context, index) {
                return BlockWidget(block: blocks[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class BlockWidget extends StatelessWidget {
  final Block block;

  const BlockWidget({super.key, required this.block});

  @override
  Widget build(BuildContext context) {
    // TextStyle? textStyle;
    // textStyle = switch (block.type) {
    //   'h1' => Theme.of(context).textTheme.displayMedium,
    //   'p' || 'checkbox' => Theme.of(context).textTheme.bodyMedium,
    //   _ => Theme.of(context).textTheme.bodySmall,
    // };

    // return Container(
    //   padding: EdgeInsets.all(8.0),
    //   child: Text(block.text, style: textStyle),
    // );

    return Container(
      padding: EdgeInsets.all(8),
      child: switch (block) {
        HeaderBlock(:final text) => Text(
          text,
          style: Theme.of(context).textTheme.displayMedium,
        ),
        ParagraphBlock(:final text) => Text(text),
        CheckboxBlock(:final text, :final isChecked) => Row(
          children: [
            Checkbox(
              value: isChecked,
              onChanged: (_) {
                //print(valueChanged);
              },
            ),
            Text(text),
          ],
        ),
      },
    );
  }
}

String formatDate(DateTime dateTime) {
  final today = DateTime.now();
  final difference = dateTime.difference(today);

  return switch (difference) {
    Duration(inDays: 0) => 'today',
    Duration(inDays: 1) => 'tomorrow',
    Duration(inDays: -1) => 'yesterday',
    //This code introduces guard clauses:
    Duration(inDays: final days) when days > 7 =>
      '${days ~/ 7} weeks from now', // Add from here
    Duration(inDays: final days) when days < -7 =>
      '${days.abs() ~/ 7} weeks ago',
    Duration(inDays: final days, isNegative: true) => '${days.abs()} days ago',
    Duration(inDays: final days) => '$days days from now',
  };
}
