import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:digital_trons_practical/model/movie_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../animation.dart';
import '../constants.dart';
import '../controller/movie_details.dart';

import 'package:readmore/readmore.dart';
import '../star_widget.dart';
import '../widget/bottom_info_sheet.dart';
import 'package:url_launcher/url_launcher.dart';

class MovieDetailScreenWidget extends StatefulWidget {
  // final MovieDetails info;
  final int movieId;

  const MovieDetailScreenWidget({
    Key? key,
    required this.movieId,
    // required this.info,
  }) : super(key: key);

  @override
  State<MovieDetailScreenWidget> createState() =>
      _MovieDetailScreenWidgetState();
}

class _MovieDetailScreenWidgetState extends State<MovieDetailScreenWidget> {
  final MovieDetailsController _movieDetailsController =
      Get.put(MovieDetailsController());
  MovieDetails info = MovieDetails();

  @override
  void initState() {
    super.initState();
    _movieDetailsController.getMovieDetails(widget.movieId).then((value) {
      setState(() {
        info = _movieDetailsController.movies_details.value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _movieDetailsController.isLoading.isTrue
          ? Container(
              color: Colors.black,
              child: Center(
                child: const CircularProgressIndicator(),
              ),
            )
          : Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: CachedNetworkImageProvider(
                      imageBasePath + (info.posterPath ?? '')),
                  fit: BoxFit.cover,
                  alignment: Alignment.topLeft,
                ),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 30, sigmaY: 50),
                child: Container(
                  color: Colors.black.withOpacity(.5),
                  child: Stack(
                    // physics: BouncingScrollPhysics(),
                    children: [
                      Stack(
                        children: [
                          InkWell(
                            onTap: () {
                              // pushNewScreen(
                              //   context,
                              //   ViewPhotos(
                              //     imageIndex: 0,
                              //     color: Theme.of(context).primaryColor,
                              //     imageList: backdrops,
                              //   ),
                              // );
                            },
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height *
                                  (1 - 0.63),
                              width: MediaQuery.of(context).size.width,
                              child: CachedNetworkImage(
                                imageUrl:
                                    imageBasePath + (info.backdropPath ?? ''),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SafeArea(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CreateIcons(
                                    onTap: () => Navigator.pop(context),
                                    child: const Icon(
                                      CupertinoIcons.back,
                                      color: Colors.white,
                                    ),
                                  ),
                                  CreateIcons(
                                    onTap: () {
                                      showModalBottomSheet<void>(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        backgroundColor: const Color.fromARGB(
                                            255, 30, 34, 45),
                                        context: context,
                                        builder: (BuildContext ctx) {
                                          return Container(
                                            color: Colors.black26,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                const SizedBox(
                                                  height: 14,
                                                ),
                                                Container(
                                                  height: 5,
                                                  width: 100,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                Column(
                                                  children: [
                                                    ListTile(
                                                      onTap: () {
                                                        _launchUrl(
                                                          "https://www.themoviedb.org/movie/${info.id}",
                                                        );
                                                      },
                                                      leading: Icon(
                                                        CupertinoIcons.share,
                                                        color: Theme.of(context)
                                                            .primaryColor,
                                                      ),
                                                      title: Text(
                                                        "Open in Brower ",
                                                        style:
                                                            normalText.copyWith(
                                                                color: Colors
                                                                    .white),
                                                      ),
                                                    ),
                                                    Divider(
                                                      height: .5,
                                                      thickness: .5,
                                                      color:
                                                          Colors.grey.shade800,
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    child: const Icon(
                                      CupertinoIcons.ellipsis,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      BottomInfoSheet(
                        backdrops: imageBasePath + (info.backdropPath ?? ''),
                        child: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Flexible(
                                  flex: 1,
                                  child: DelayedDisplay(
                                    delay: const Duration(microseconds: 500),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        boxShadow: kElevationToShadow[8],
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: CachedNetworkImage(
                                            imageUrl: imageBasePath +
                                                (info.posterPath ?? ''),
                                            width: 120),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 16.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        DelayedDisplay(
                                          delay:
                                              const Duration(microseconds: 700),
                                          child: RichText(
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: info.title,
                                                  style: heading.copyWith(
                                                      fontSize: 22),
                                                ),
                                                TextSpan(
                                                  text:
                                                      " (${info.releaseDate.toString().split("-")[0]})",
                                                  style: heading.copyWith(
                                                    color: Colors.white
                                                        .withOpacity(.8),
                                                    fontSize: 18,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        DelayedDisplay(
                                          delay:
                                              const Duration(microseconds: 700),
                                          child: Text(
                                            (info.genres ?? []).join(','),
                                            style: normalText.copyWith(
                                                color: Colors.white),
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        DelayedDisplay(
                                          delay:
                                              const Duration(microseconds: 700),
                                          child: Row(
                                            children: [
                                              IconTheme(
                                                data: const IconThemeData(
                                                  color: Colors.amber,
                                                  size: 20,
                                                ),
                                                child: StarDisplay(
                                                  value: (((info.voteAverage ??
                                                                  0) *
                                                              5) /
                                                          10)
                                                      .round(),
                                                ),
                                              ),
                                              Text(
                                                "  ${info.voteAverage}/10",
                                                style: normalText.copyWith(
                                                  color: Colors.amber,
                                                  letterSpacing: 1.2,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          if (info.overview != '')
                            Container(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  DelayedDisplay(
                                      delay: const Duration(microseconds: 800),
                                      child: Text("Overview",
                                          style: heading.copyWith(
                                              color: Colors.white))),
                                  const SizedBox(height: 10),
                                  DelayedDisplay(
                                    delay: const Duration(microseconds: 1000),
                                    child: ReadMoreText(
                                      info.overview ?? '',
                                      trimLines: 6,
                                      colorClickableText: Colors.pink,
                                      trimMode: TrimMode.Line,
                                      trimCollapsedText: 'more',
                                      trimExpandedText: 'less',
                                      style: normalText.copyWith(
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white),
                                      moreStyle: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Future<void> _launchUrl(String _url) async {
    if (!await launchUrl(Uri.parse(_url))) {
      throw Exception('Could not launch $_url');
    }
  }
}

class CreateIcons extends StatelessWidget {
  final Widget child;
  final Function()? onTap;
  const CreateIcons({
    Key? key,
    required this.child,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: kElevationToShadow[2],
      ),
      child: ClipOval(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 30, sigmaY: 50),
          child: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black.withOpacity(.5),
            ),
            child: InkWell(onTap: onTap, child: child),
          ),
        ),
      ),
    );
  }
}
