import 'package:labeta/models/sector.dart';
import 'package:labeta/services/firestore.dart';
import 'package:labeta/services/storage.dart';
import 'dart:io';

class SectorsService {
  final _firestoreService = FirestoreService.instance;
  final _storageService = StorageService.instance;
  final String sectorsPath = 'sectors';

  Future<void> createSector(SectorModel sector, File imageFile) async {
    // Upload image to Firebase Storage
    final objectRef = await _storageService.uploadFile(
        path: 'sectors', fileName: '${sector.name}.jpg', file: imageFile);
    final downloadUrl = await objectRef.getDownloadURL();
    final finalSector = sector.copyWith(imageURLs: [downloadUrl]);
    await _firestoreService.set(
      path: sectorsPath,
      data: finalSector.toMap(),
    );
  }

  Future<List<SectorModel>> getSectors() async {
    final List<SectorModel> sectors = await _firestoreService.getCollectionData(
      path: sectorsPath,
      builder: (data, documentID) => SectorModel.fromMap(data, documentID),
    );
    return sectors;
  }
}