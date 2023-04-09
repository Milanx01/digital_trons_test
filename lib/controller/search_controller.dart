import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../model/trending_movie_list_model.dart';
import '../repository/app_repository.dart';

class SearchController extends GetxController {
  final AppRepository _appRepository = AppRepository();
  var searchResults = <TrendingMovieList>[].obs;
  var isLoading = false.obs;
  var isFirstTime = false.obs;

  Future<void> searchMovies(String query) async {
    try {
      isFirstTime.value = true;
      isLoading.value = true;
      final results = await _appRepository.searchMovies(query);
      searchResults.value = results
          .map<TrendingMovieList>((json) => TrendingMovieList.fromJson(json))
          .toList();
    } on DioError catch (_) {
      // handle error
    } finally {
      isLoading.value = false;
    }
  }
}
