import 'package:cloud_firestore/cloud_firestore.dart';

class VFireStore {
  static Future<List<DocumentSnapshot>> fetchDocs(String collection) async {
    // ignore: deprecated_member_use
    CollectionReference collectionReference = Firestore.instance.collection(collection);
    QuerySnapshot collectionSnapshot = await collectionReference.get();
    List<DocumentSnapshot> newDatas = [];
    collectionSnapshot.docs.forEach((element) {
      newDatas.add(element);
    });
    return newDatas;
  }
}
