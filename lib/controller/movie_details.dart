import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../model/movie_details.dart';
import '../repository/app_repository.dart';

class MovieDetailsController extends GetxController {
  final AppRepository _appRepository = AppRepository();
  var movies_details = MovieDetails().obs;
  var isLoading = false.obs;

  Future<void> getMovieDetails(int movieId) async {
    try {
      isLoading.value = true;
      final movies = await _appRepository.movieDetails(movieId);

      movies_details.value = movies;
    } on DioError catch (_) {
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }
}
