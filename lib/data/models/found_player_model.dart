class FoundPlayerModel {
  final String uid;
  final String name;

  FoundPlayerModel({required this.uid, required this.name});

  factory FoundPlayerModel.fromJson(Map<String, dynamic> json) {
    return FoundPlayerModel(
      uid: json['uid'] ?? '',
      name: json['name'] ?? 'N/A',
    );
  }
}