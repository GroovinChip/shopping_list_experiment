import 'package:flutter/material.dart';
import 'package:shopping_list/firebase/firebase.dart';
import 'package:shopping_list/screens/store_screen.dart';
import 'package:shopping_list/widgets/new_store_dialog.dart';
import 'package:shopping_list/widgets/reorderable_firestore_list.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        //centerTitle: true,
        title: Text('My Stores'),
        actions: [
          IconButton(
            tooltip: 'Add Store',
            icon: Icon(Icons.add),
            onPressed: () => showDialog(
              context: context,
              builder: (_) => NewStoreDialog(),
            ),
          ),
        ],
      ),
      body: ReorderableFirebaseList(
        collection: stores,
        indexKey: 'pos',
        itemBuilder: (context, index, doc) {
          final store = Store(
            name: doc.id,
            pos: index,
          );
          return ListTile(
            key: Key(doc.id),
            title: Text(doc.id),
            trailing: Icon(Icons.chevron_right),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => StoreScreen(
                  store: store,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
