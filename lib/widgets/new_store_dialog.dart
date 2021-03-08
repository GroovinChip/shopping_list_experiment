import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_list/firebase/firebase.dart';

class NewStoreDialog extends StatefulWidget {
  @override
  _NewStoreDialogState createState() => _NewStoreDialogState();
}

class _NewStoreDialogState extends State<NewStoreDialog> {
  final storeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text('New Store'),
      contentPadding: const EdgeInsets.only(top: 12.0),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: TextField(
            controller: storeController,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey.shade300,
              hintText: 'Store name',
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: stores.snapshots(),
              builder: (context, snapshot) {
                return TextButton(
                  child: Text('ADD'),
                  onPressed: () {
                    if (storeController.text.isNotEmpty && snapshot.hasData) {
                      stores.doc(storeController.text).set({
                        'pos': snapshot.data.size + 1,
                      });

                      Navigator.of(context).pop();
                    }
                  },
                );
              }
            ),
          ],
        ),
      ],
    );
  }
}
