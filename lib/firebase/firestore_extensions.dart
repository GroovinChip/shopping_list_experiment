import 'package:cloud_firestore/cloud_firestore.dart';

import 'firestore_refs.dart';

extension FirestoreX on FirebaseFirestore {
  Stream<QuerySnapshot> get storeStream => stores.snapshots();
}

extension CollectionReferenceX on CollectionReference {
  CollectionReference store(String storeName) =>
      stores.doc(storeName).collection('items');

  Future<void> addItem(String item, int listSize) async {
    this.doc(item).set({
      'itemName': item,
      'pos': listSize,
    });
  }
}
