class BannerModel {
  final String id;
  final String title;
  final String? subtitle;
  final String? tag;
  final String? ctaText;
  final String imageUrl;
  final int backgroundColorHex;
  final String? linkRoute;

  const BannerModel({
    required this.id,
    required this.title,
    this.subtitle,
    this.tag,
    this.ctaText,
    required this.imageUrl,
    this.backgroundColorHex = 0xFFFDF2F8,
    this.linkRoute,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      id: json['id'] as String,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String?,
      tag: json['tag'] as String?,
      ctaText: json['ctaText'] as String?,
      imageUrl: json['imageUrl'] as String,
      backgroundColorHex: json['backgroundColorHex'] as int? ?? 0xFFFDF2F8,
      linkRoute: json['linkRoute'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'subtitle': subtitle,
      'tag': tag,
      'ctaText': ctaText,
      'imageUrl': imageUrl,
      'backgroundColorHex': backgroundColorHex,
      'linkRoute': linkRoute,
    };
  }
}
