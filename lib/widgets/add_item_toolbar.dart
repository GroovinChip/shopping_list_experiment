import 'package:flutter/material.dart';
import 'package:shopping_list/firebase/firebase.dart';

class AddItemToolbar extends StatefulWidget {
  const AddItemToolbar({
    Key? key,
    required this.store,
  }) : super(key: key);

  final Store store;

  @override
  _AddItemToolbarState createState() => _AddItemToolbarState();
}

class _AddItemToolbarState extends State<AddItemToolbar> {
  Store get store => widget.store;
  final newItemController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
      child: StreamBuilder<QuerySnapshot>(
          stream: store.items.snapshots(),
          builder: (context, snapshot) {
            return TextField(
              textCapitalization: TextCapitalization.sentences,
              textInputAction: TextInputAction.done,
              controller: newItemController,
              onSubmitted: (item) {
                if (item.isNotEmpty) {
                  store.addItem(item, snapshot.data!.size + 1);
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
