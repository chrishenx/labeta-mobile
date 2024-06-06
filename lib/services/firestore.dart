import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:labeta/utils/logger.dart';

class FirestoreService {
  FirestoreService._constructor();
  static final instance = FirestoreService._constructor();

  Future<void> set({
    required String path,
    required Map<String, dynamic> data,
    bool merge = false,
  }) async {
    final collectionReference = FirebaseFirestore.instance.collection(path);
    if (data['id'] == null) {
      final doc = await collectionReference.add(data);
      Logger.log('Firestore - Set - Added ${doc.id} to "$path" to data: $data');
    } else {
      await collectionReference.doc(data['id']).set(data);
      Logger.log('Firestore - Set - Updated ${data['id']} in "$path" to data: $data');
    }
  }

  Future<void> deleteData({required String path}) async {
    final reference = FirebaseFirestore.instance.doc(path);
    await reference.delete();
    Logger.log('Firestore - Deleted "$path"');
  }

  Future<List<T>> getCollectionData<T>({
    required String path,
    required T Function(Map<String, dynamic> data, String documentID) builder
    }) async {
    final reference = FirebaseFirestore.instance.collection(path);
    final snapshot = await reference.get();
    final result = snapshot.docs
        .map((snapshot) =>
            builder(snapshot.data(), snapshot.id))
        .toList();
    return result;
  }

  Stream<List<T>> collectionStream<T>({
    required String path,
    required T Function(Map<String, dynamic> data, String documentID) builder,
    Query Function(Query query)? queryBuilder,
    int Function(T lhs, T rhs)? sort,
  }) {
    Query query = FirebaseFirestore.instance.collection(path);
    if (queryBuilder != null) {
      query = queryBuilder(query);
    }
    final Stream<QuerySnapshot> snapshots = query.snapshots();
    return snapshots.map((snapshot) {
      final result = snapshot.docs
          .map((snapshot) =>
              builder(snapshot.data() as Map<String, dynamic>, snapshot.id))
          .where((value) => value != null)
          .toList();
      if (sort != null) {
        result.sort(sort);
      }
      return result;
    });
  }

  Stream<T> documentStream<T>({
    required String path,
    required T Function(Map<String, dynamic> data, String documentID) builder,
  }) {
    final DocumentReference reference = FirebaseFirestore.instance.doc(path);
    final Stream<DocumentSnapshot> snapshots = reference.snapshots();
    return snapshots.map((snapshot) =>
        builder(snapshot.data() as Map<String, dynamic>, snapshot.id));
  }
}
