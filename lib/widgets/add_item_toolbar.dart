import 'package:flutter/material.dart';
import 'package:shopping_list/firebase/firebase.dart';

class AddItemToolbar extends StatefulWidget {
  const AddItemToolbar({
    Key? key,
    required this.storeName,
  }) : super(key: key);

  final String storeName;

  @override
  _AddItemToolbarState createState() => _AddItemToolbarState();
}

class _AddItemToolbarState extends State<AddItemToolbar> {
  final newItemController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
      child: StreamBuilder<QuerySnapshot>(
          stream: stores.doc(widget.storeName).collection('items').snapshots(),
          builder: (context, snapshot) {
            return TextField(
              textCapitalization: TextCapitalization.sentences,
              textInputAction: TextInputAction.done,
              controller: newItemController,
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  stores
                      .store(widget.storeName)
                      .addItem(value, snapshot.data!.size + 1);
                  setState(() => newItemController.clear());
                }
              },
              decoration: InputDecoration(
                border: InputBorder.none,
                filled: true,
                fillColor: Theme.of(context).brightness == Brightness.light
                    ? Colors.white
                    : Colors.grey.shade800,
                hintText: 'Add item',
              ),
            );
          }),
    );
  }
}
