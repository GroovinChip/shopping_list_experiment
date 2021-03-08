import 'package:shopping_list/firebase/firebase.dart';

class Store {
  Store({
    required this.name,
    required this.pos,
  });

  final String name;
  final int pos;

  DocumentReference get ref =>
      FirebaseFirestore.instance.collection('stores').doc(name);
  CollectionReference get items => ref.collection('items');

  Future<void> addItem(String item, int listPos) async {
    items.doc(item).set({
      'itemName': item,
      'pos': listPos,
    });
  }
}
