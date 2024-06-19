import 'package:flutter/material.dart';

class EditNameDialog extends StatelessWidget {
  final String initialName;
  final Function(String) onSave;

  EditNameDialog({required this.initialName, required this.onSave});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController(text: initialName);

    return AlertDialog(
      title: Text('Edit Name'),
      content: TextField(
        controller: nameController,
        decoration: InputDecoration(hintText: 'Enter your name'),
      ),
      actions: [
        TextButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text('Save'),
          onPressed: () {
            onSave(nameController.text);
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
