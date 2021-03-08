import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopping_list/firebase/firebase.dart';
import 'package:shopping_list/screens/store_settings.dart';
import 'package:shopping_list/extensions.dart';
import 'package:shopping_list/widgets/add_item_toolbar.dart';
import 'package:shopping_list/widgets/reorderable_firestore_list.dart';

class StoreScreen extends StatefulWidget {
  const StoreScreen({
    Key key,
    @required this.storeName,
  }) : super(key: key);

  final String storeName;

  @override
  _StoreScreenState createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  var items = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.storeName),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: AddItemToolbar(
            storeName: widget.storeName,
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
        collection: stores.doc(widget.storeName).collection('items'),
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
      /*body: StreamBuilder<QuerySnapshot>(
        stream: stores.doc(widget.storeName).collection('items').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('${snapshot.error}'),
            );
          }

          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                final doc = snapshot.data.docs[index];
                var checked = false;
                return CheckboxListTile(
                  title: Text(doc.id),
                  value: checked,
                  onChanged: (value) => doc.reference.delete(),
                );
                */ /*return ListTile(
                  title: Text(doc.id),
                  trailing: IconButton(
                    icon: Icon(Icons.check),
                    onPressed: () => doc.reference.delete(),
                  ),
                );*/ /*
              },
            );
          }
        },
      ),*/
    );
  }
}
