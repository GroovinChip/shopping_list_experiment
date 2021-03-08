import 'package:flutter/material.dart';
import 'package:shopping_list/firebase/firebase.dart';
import 'package:shopping_list/screens/store_settings.dart';
import 'package:shopping_list/extensions.dart';
import 'package:shopping_list/widgets/add_item_toolbar.dart';
import 'package:shopping_list/widgets/reorderable_firestore_list.dart';

class StoreScreen extends StatefulWidget {
  const StoreScreen({
    Key? key,
    required this.store,
  }) : super(key: key);

  final Store store;

  @override
  _StoreScreenState createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  Store get store => widget.store;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        //centerTitle: true,
        title: Text(store.name),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: AddItemToolbar(
            store: store,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              context.showSnackBar();
              /*Navigator.of(context).push(
                MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (_) => StoreSettings(
                    storeName: storeName,
                  ),
                ),
              );*/
            },
          ),
        ],
      ),
      body: ReorderableFirebaseList(
        collection: store.items,
        indexKey: 'pos',
        itemBuilder: (context, index, doc) {
          var checked = false;
          return CheckboxListTile(
            key: Key(doc.id),
            title: Text(doc.id),
            value: checked,
            onChanged: (value) => doc.reference.delete(),
          );
        },
        emptyWidget: Center(
          child: Text(
            'All clear!',
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
      ),
    );
  }
}
