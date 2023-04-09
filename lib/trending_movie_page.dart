import 'package:cached_network_image/cached_network_image.dart';
import 'package:digital_trons_practical/screens/movie_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'animation.dart';
import 'constants.dart';
import 'controller/trending_controller.dart';
import 'model/trending_movie_list_model.dart';
import 'screens/movies_page.dart';
import 'screens/search_page.dart';

class TrendingScreen extends StatefulWidget {
  const TrendingScreen({Key? key}) : super(key: key);
  @override
  _TrendingScreenState createState() => _TrendingScreenState();
}

class _TrendingScreenState extends State<TrendingScreen> {
  final TrendingController _trendingController = Get.put(TrendingController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => _trendingController.isLoading.value
          ? const Center(child: CircularProgressIndicator())
          : HomeScreenWidget(
              tranding: _trendingController.trendingMovies,
            ),
    );
  }
}

class HomeScreenWidget extends StatelessWidget {
  final List<TrendingMovieList> tranding;

  const HomeScreenWidget({
    Key? key,
    required this.tranding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          child: const Icon(Icons.search_sharp),
          onPressed: () {
            Navigator.push(
              context,
              createRoute(SearchPage()),
            );
          },
        ),
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MoviesPage(movies: tranding),
              const DelayedDisplay(
                delay: Duration(microseconds: 800),
                child: HeaderText(text: "Trending"),
              ),
              DelayedDisplay(
                delay: const Duration(microseconds: 800),
                child: HorizontalListViewMovies(
                  list: tranding,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HeaderText extends StatelessWidget {
  final String text;
  const HeaderText({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
      child: Text(text, style: heading.copyWith(color: Colors.white)),
    );
  }
}

class HorizontalListViewMovies extends StatelessWidget {
  final List<TrendingMovieList> list;
  final Color? color;
  const HorizontalListViewMovies({
    Key? key,
    required this.list,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 310,
        child: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          children: [
            const SizedBox(width: 7),
            for (var i = 0; i < list.length; i++)
              MovieCard(
                isMovie: true,
                id: list[i].id ?? 0,
                name: list[i].title ?? '',
                backdrop: '$imageBasePath${list[i].backdropPath}',
                poster: '$imageBasePath${list[i].posterPath}',
                color: color == null ? Colors.white : color!,
                // date: list[i].releaseDate.toString(),
                date: (() {
                  final DateFormat formatter = DateFormat('dd-MMM-yyyy');
                  final String formatted =
                      formatter.format(list[i].releaseDate ?? DateTime.now());
                  return formatted;
                }()),
                onTap: () {
                  pushNewScreen(
                    context,
                    MovieDetailScreenWidget(
                      movieId: list[i].id ?? 0,
                    ),
                  );
                },
              )
          ],
        ));
  }
}

class MovieCard extends StatelessWidget {
  final String poster;
  final String name;
  final String backdrop;
  final String date;
  final int id;
  final Color color;
  final VoidCallback onTap;
  final bool isMovie;
  const MovieCard({
    Key? key,
    required this.poster,
    required this.name,
    required this.backdrop,
    required this.date,
    required this.id,
    required this.color,
    required this.onTap,
    required this.isMovie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          onTap();
        },
        child: Container(
          constraints: const BoxConstraints(minHeight: 280),
          child: Column(
            children: [
              Container(
                height: 200,
                width: 130,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey.shade900,
                  boxShadow: kElevationToShadow[8],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    imageUrl: poster,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: 130,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: normalText.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                    Text(
                      date,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: normalText.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                        color: color.withOpacity(.8),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
