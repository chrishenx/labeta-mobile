import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  StorageService._constructor();
  static final instance = StorageService._constructor();

  Future<Reference> uploadFile({
    required String path,
    required String fileName,
    required File file,
  }) async {
    final storageReference = FirebaseStorage.instance.ref().child(path).child(fileName);
    final uploadTask = storageReference.putFile(file);
    final snapshot = await uploadTask.whenComplete(() => null);
    return snapshot.ref;
  }
}