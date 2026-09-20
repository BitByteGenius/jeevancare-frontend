enum BadgeType {
  orange,
  red,
  green,
  purple,
}

class CategoryModel {
  final String id;
  final String title;
  final String? iconUrl;
  final String? badgeText;
  final BadgeType? badgeType;
  final int? backgroundColorHex;

  const CategoryModel({
    required this.id,
    required this.title,
    this.iconUrl,
    this.badgeText,
    this.badgeType,
    this.backgroundColorHex,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] as String,
      title: json['title'] as String,
      iconUrl: json['iconUrl'] as String?,
      badgeText: json['badgeText'] as String?,
      badgeType: json['badgeType'] != null
          ? BadgeType.values.firstWhere(
              (e) => e.name == json['badgeType'],
              orElse: () => BadgeType.orange,
            )
          : null,
      backgroundColorHex: json['backgroundColorHex'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'iconUrl': iconUrl,
      'badgeText': badgeText,
      'badgeType': badgeType?.name,
      'backgroundColorHex': backgroundColorHex,
    };
  }
}
