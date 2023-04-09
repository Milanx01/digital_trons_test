// To parse this JSON data, do
//
//     final trendingMovie = trendingMovieFromJson(jsonString);

import 'dart:convert';

TrendingMovie trendingMovieFromJson(String str) =>
    TrendingMovie.fromJson(json.decode(str));

String trendingMovieToJson(TrendingMovie data) => json.encode(data.toJson());

class TrendingMovie {
  TrendingMovie({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  int page;
  List<TrendingMovieList> results;
  int totalPages;
  int totalResults;

  factory TrendingMovie.fromJson(Map<String, dynamic> json) => TrendingMovie(
        page: json["page"],
        results: List<TrendingMovieList>.from(
            json["results"].map((x) => TrendingMovieList.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
        "total_pages": totalPages,
        "total_results": totalResults,
      };
}

class TrendingMovieList {
  TrendingMovieList({
    required this.adult,
    required this.backdropPath,
    required this.id,
    required this.title,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.posterPath,
    required this.mediaType,
    required this.genreIds,
    required this.popularity,
    required this.releaseDate,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  bool? adult;
  String? backdropPath;
  int? id;
  String? title;
  OriginalLanguage? originalLanguage;
  String? originalTitle;
  String? overview;
  String? posterPath;
  MediaType? mediaType;
  List<int>? genreIds;
  double? popularity;
  DateTime? releaseDate;
  bool? video;
  double? voteAverage;
  int? voteCount;

  factory TrendingMovieList.fromJson(Map<String, dynamic>? json) =>
      TrendingMovieList(
        adult: json?["adult"],
        backdropPath: json?["backdrop_path"],
        id: json?["id"],
        title: json?["title"],
        originalLanguage:
            originalLanguageValues.map[json?["original_language"]],
        originalTitle: json?["original_title"],
        overview: json?["overview"],
        posterPath: json?["poster_path"],
        mediaType: mediaTypeValues.map[json?["media_type"]],
        genreIds: List<int>.from(json?["genre_ids"].map((x) => x)),
        popularity: json?["popularity"]?.toDouble(),
        releaseDate: json?["release_date"].isNotEmpty
            ? DateTime.parse(json?["release_date"])
            : DateTime.now(),
        video: json?["video"],
        voteAverage: json?["vote_average"]?.toDouble(),
        voteCount: json?["vote_count"],
      );

  Map<String, dynamic> toJson() => {
        "adult": adult,
        "backdrop_path": backdropPath,
        "id": id,
        "title": title,
        "original_language": originalLanguageValues.reverse[originalLanguage],
        "original_title": originalTitle,
        "overview": overview,
        "poster_path": posterPath,
        "media_type": mediaTypeValues.reverse[mediaType],
        "genre_ids": List<dynamic>.from(genreIds?.map((x) => x) ?? []),
        "popularity": popularity,
        "release_date":
            "${releaseDate?.year.toString().padLeft(4, '0')}-${releaseDate?.month.toString().padLeft(2, '0')}-${releaseDate?.day.toString().padLeft(2, '0')}",
        "video": video,
        "vote_average": voteAverage,
        "vote_count": voteCount,
      };
}

enum MediaType { MOVIE }

final mediaTypeValues = EnumValues({"movie": MediaType.MOVIE});

enum OriginalLanguage { EN, KO, JA, ES }

final originalLanguageValues = EnumValues({
  "en": OriginalLanguage.EN,
  "es": OriginalLanguage.ES,
  "ja": OriginalLanguage.JA,
  "ko": OriginalLanguage.KO
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
