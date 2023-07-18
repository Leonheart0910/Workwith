import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Data/data_format.dart';

void showPopup(BuildContext context) {
  final titleController = TextEditingController();
  final summaryController = TextEditingController();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('New Project'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(hintText: 'Title'),
            ),
            TextField(
              controller: summaryController,
              decoration: const InputDecoration(hintText: 'Summary'),
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Add'),
            onPressed: () {
              String title = titleController.text;
              String summary = summaryController.text;

              // Create new Data object
              Data newData = Data(title, summary);

              // Add new data to dataList
              Provider.of<DataList>(context, listen: false).addData(newData);

              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}