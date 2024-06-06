import 'package:cloud_firestore/cloud_firestore.dart';

class SectorModel {
  final String? id;
  final String name;
  final String description;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final List<String> imageURLs;
  // final Geolocation parkingCoordinates; // TODO: Implement Geolocation
  final String? parkingDescription;
  final List<String> parkingImageURLs;
  final String? approachDescription;

  SectorModel({
    this.id,
    required this.name,
    required this.description,
    required this.createdAt,
    this.updatedAt,
    this.imageURLs = const [],
    // this.parkingCoordinates, // TODO: Implement Geolocation
    this.parkingDescription,
    this.parkingImageURLs = const [],
    this.approachDescription,
  });

  SectorModel copyWith({
    String? id,
    String? name,
    String? description,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<String>? imageURLs,
    // Geolocation? parkingCoordinates, // TODO: Implement Geolocation
    String? parkingDescription,
    List<String>? parkingImageURLs,
    String? approachDescription,
  }) {
    return SectorModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      imageURLs: imageURLs ?? this.imageURLs,
      // parkingCoordinates: parkingCoordinates ?? this.parkingCoordinates, // TODO: Implement Geolocation
      parkingDescription: parkingDescription ?? this.parkingDescription,
      parkingImageURLs: parkingImageURLs ?? this.parkingImageURLs,
      approachDescription: approachDescription ?? this.approachDescription,
    );
  }

  factory SectorModel.fromMap(Map<String, dynamic> data, String documentID) {
    final String name = data['name'];
    final String description = data['description'];
    final DateTime createdAt = (data['createdAt'] as Timestamp).toDate();
    final DateTime? updatedAt = data['updatedAt'] != null
        ? (data['updatedAt'] as Timestamp).toDate()
        : null;
    final List<String> imageURLs = List<String>.from(data['imageURLs'] ?? []);
    // final Geolocation parkingCoordinates = Geolocation.fromMap(data['parkingCoordinates']); // TODO: Implement Geolocation with https://github.com/DarshanGowda0/GeoFlutterFire
    final String? parkingDescription = data['parkingDescription'];
    final List<String> parkingImageURLs =
        List<String>.from(data['parkingImageURLs'] ?? []);
    final String? approachDescription = data['approachDescription'];

    return SectorModel(
      id: documentID,
      name: name,
      description: description,
      createdAt: createdAt,
      updatedAt: updatedAt,
      imageURLs: imageURLs,
      // parkingCoordinates: parkingCoordinates, // TODO: Implement Geolocation
      parkingDescription: parkingDescription,
      parkingImageURLs: parkingImageURLs,
      approachDescription: approachDescription,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'imageURLs': imageURLs,
      // 'parkingCoordinates': parkingCoordinates, // TODO: Implement Geolocation
      'parkingDescription': parkingDescription,
      'parkingImageURLs': parkingImageURLs,
      'approachDescription': approachDescription,
    };
  }
}
