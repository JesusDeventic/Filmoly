class LibraryEntry {
  const LibraryEntry({
    required this.id,
    required this.title,
    required this.thumbnailUrl,
    required this.year,
    this.rfAverage,
    required this.director,
    required this.pais,
  });

  final int id;
  final String title;
  final String thumbnailUrl;
  final String year;
  final double? rfAverage;
  final String director;
  final String pais;

  factory LibraryEntry.fromJson(Map<String, dynamic> json) {
    return LibraryEntry(
      id: (json['id'] as num?)?.toInt() ?? 0,
      title: (json['title'] as String?) ?? '',
      thumbnailUrl: (json['thumbnail_url'] as String?) ?? '',
      year: (json['year'] as String?) ?? '',
      rfAverage: (json['rf_average'] as num?)?.toDouble(),
      director: (json['director'] as String?) ?? '',
      pais: (json['pais'] as String?) ?? '',
    );
  }
}
