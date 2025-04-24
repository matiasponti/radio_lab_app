class RadioStationModel {
  final String name;
  final String url;
  final String favicon;
  final String country;
  final String tags;

  RadioStationModel({
    required this.name,
    required this.url,
    required this.favicon,
    required this.country,
    required this.tags,
  });

  factory RadioStationModel.fromJson(Map<String, dynamic> json) {
    return RadioStationModel(
      name: json['name'] ?? '',
      url: json['url_resolved'] ?? '',
      favicon: json['favicon'] ?? '',
      country: json['country'] ?? '',
      tags: json['tags'] ?? '',
    );
  }
  RadioStationModel toEntity() {
    return RadioStationModel(
      name: name,
      url: url,
      favicon: favicon,
      country: country,
      tags: tags,
    );
  }
}
