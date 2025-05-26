class MosqueImage {
  final int? imageId;
  final String? imageUrl;
  final int? mosqueId;

  MosqueImage({this.imageId, this.imageUrl, this.mosqueId});

  factory MosqueImage.fromJson(Map<String, dynamic> json) {
    return MosqueImage(
      imageId: json['image_id'],
      imageUrl: json['image_url'],
      mosqueId: json['mosque_id'],
    );
  }
}
