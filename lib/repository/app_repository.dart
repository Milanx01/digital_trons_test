import 'package:digital_trons_practical/model/trending_movie_list_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../model/movie_details.dart';

class AppRepository {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'https://api.themoviedb.org/3'));

  Future<dynamic> fetchTrendingMovies(int _currentPage) async {
    final response = await _dio.get(
      '/trending/movie/week',
      queryParameters: {
        'api_key': dotenv.env['TMDB_API_KEY'],
        'page': _currentPage,
      },
    );
    return response.data['results'];
  }

  Future<dynamic> searchMovies(String query) async {
    final response = await _dio.get('/search/movie', queryParameters: {
      'api_key': dotenv.env['TMDB_API_KEY'],
      'query': query
    });
    return response.data['results'];
  }

  Future<dynamic> movieDetails(int movieId) async {
    final response = await _dio.get('/movie/$movieId', queryParameters: {
      'api_key': dotenv.env['TMDB_API_KEY'],
    });
    return MovieDetails.fromJson(response.data);
  }
}
