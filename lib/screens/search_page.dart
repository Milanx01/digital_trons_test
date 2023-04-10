import 'package:digital_trons_practical/controller/search_controller.dart';
import 'package:digital_trons_practical/model/trending_movie_list_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants.dart';
import '../horizontal_card.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final SearchController _searchController = Get.put(SearchController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: _searchController.isLoading.isTrue
            ? Container(
                color: Colors.black.withOpacity(0.5),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: const Align(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(),
                ),
              )
            : ListView(
                shrinkWrap: true,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      "Search",
                      style: heading.copyWith(
                          color: Colors.cyanAccent, fontSize: 36),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: TextField(
                      style: normalText.copyWith(color: Colors.white),
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        suffixIcon: Icon(
                          Icons.search,
                          color: Theme.of(context).primaryColor,
                        ),
                        hintText: "Search movies...",
                        filled: true,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 0,
                          horizontal: 20,
                        ),
                        hintStyle: TextStyle(
                          letterSpacing: .0,
                          color: Colors.white.withOpacity(.7),
                        ),
                        fillColor: Colors.white.withOpacity(.1),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey.shade600,
                            width: .2,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey.shade600,
                            width: .2,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey.shade600,
                            width: .2,
                          ),
                        ),
                      ),
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          Future.delayed(const Duration(milliseconds: 500), () {
                            _searchController.searchMovies(value);
                          });
                        }
                      },
                      // onSubmitted: (query) {
                      //   if (query.isNotEmpty) {
                      //     Future.delayed(const Duration(milliseconds: 500), () {
                      //       _searchController.searchMovies(query);
                      //     });
                      //   }
                      // },
                    ),
                  ),
                  Obx(() {
                    if (_searchController.isLoading.isTrue) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (_searchController.searchResults.isEmpty &&
                        _searchController.isFirst.isTrue) {
                      return const Center(
                        child: Text(
                          'No Data Found',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      );
                    } else {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _searchController.searchResults.length,
                        itemBuilder: (context, i) {
                          TrendingMovieList data =
                              _searchController.searchResults[i];
                          return HorizontalMovieCard(
                            poster: '$imageBasePath${data.posterPath ?? ''}',
                            name: data.title ?? '',
                            backdrop:
                                '$imageBasePath${data.backdropPath ?? ''}',
                            date: data.releaseDate.toString().isNotEmpty
                                ? "${monthgenrater(data.releaseDate.toString().split("-")[1])} ${data.releaseDate.toString().split("-")[2]}, ${data.releaseDate.toString().split("-")[0]}"
                                : "Not Available",
                            id: data.id.toString(),
                            color: Colors.white,
                            rate: data.voteAverage ?? 0,
                          );
                        },
                      );
                    }
                  }),
                ],
              ),
      ),
    );
  }
}
