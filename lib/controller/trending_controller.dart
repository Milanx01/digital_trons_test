import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../model/trending_movie_list_model.dart';
import '../repository/app_repository.dart';

class TrendingController extends GetxController {
  final AppRepository _appRepository = AppRepository();
  var trendingMovies = <TrendingMovieList>[].obs;
  var isLoading = false.obs;

  final int _perPage = 20;
  int _currentPage = 1;

  @override
  void onInit() {
    super.onInit();
    getTrendingMovies();
  }

  Future<void> getTrendingMovies() async {
    try {
      isLoading.value = true;
      final movies = await _appRepository.fetchTrendingMovies(_currentPage);
      trendingMovies.value = movies
          .map<TrendingMovieList>((json) => TrendingMovieList.fromJson(json))
          .toList();
      trendingMovies.addAll(movies);
      _currentPage++;
    } on DioError catch (_) {
      // handle error
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }
}
