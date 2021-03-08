import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// https://gist.github.com/slightfoot/7a4cf14931baf28aa5beb4bb2f8a29b7

typedef ReorderableFirestoreWidgetBuilder = Widget Function(
    BuildContext context, int index, DocumentSnapshot doc);

class ReorderableFirebaseList extends StatefulWidget {
  const ReorderableFirebaseList({
    Key? key,
    required this.collection,
    required this.indexKey,
    required this.itemBuilder,
    this.descending = false,
    this.emptyWidget,
  }) : super(key: key);

  final CollectionReference collection;
  final String indexKey;
  final bool descending;
  final ReorderableFirestoreWidgetBuilder itemBuilder;
  final Widget? emptyWidget;

  @override
  _ReorderableFirebaseListState createState() =>
      _ReorderableFirebaseListState();
}

class _ReorderableFirebaseListState extends State<ReorderableFirebaseList> {
  late List<DocumentSnapshot> _docs;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: widget.collection
          .orderBy(widget.indexKey, descending: widget.descending)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          _docs = snapshot.data!.docs;
          if (_docs.isNotEmpty) {
            return ReorderableListView(
              onReorder: _onReorder,
              children: List.generate(_docs.length, (int index) {
                return widget.itemBuilder(context, index, _docs[index]);
              }),
            );
          } else {
            return widget.emptyWidget ?? Container();
          }
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  void _onReorder(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) newIndex -= 1;
    _docs.insert(newIndex, _docs.removeAt(oldIndex));
    final batch = FirebaseFirestore.instance.batch();
    for (int pos = 0; pos < _docs.length; pos++) {
      batch.update(_docs[pos].reference, {widget.indexKey: pos});
    }
    batch.commit();
  }
}
