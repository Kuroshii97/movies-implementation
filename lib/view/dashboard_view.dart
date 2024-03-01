import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:movies_application/model/movie.dart';
import 'package:movies_application/view/movies_detail_view.dart';
import 'package:movies_application/view/search_movie_view.dart';
import 'package:movies_application/viewmodel/dashboard_viewmodel.dart';
import 'package:provider/provider.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  late DashboardViewModel _dashboardViewModelReader;
  late DashboardViewModel _dashboardViewModelWatcher;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _dashboardViewModelReader.getMovieForDashboard();
    });
  }

  @override
  Widget build(BuildContext context) {
    _dashboardViewModelReader = context.read<DashboardViewModel>();
    _dashboardViewModelWatcher = context.watch<DashboardViewModel>();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Netplix',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.transparent,
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const SearchMovieView(),
                ),
              );
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.search,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          _carousel(),
          _dotIndicator(),
          _latestMovies(),
          _actionMovies(),
        ],
      ),
    );
  }

  Widget _carousel() {
    if (_dashboardViewModelWatcher.movieList.isEmpty) {
      return Container();
    } else {
      return CarouselSlider.builder(
        itemCount: _dashboardViewModelWatcher.featuredMovies.length,
        itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
          return _movieCardWidget(
              _dashboardViewModelWatcher.featuredMovies[itemIndex]);
        },
        options: CarouselOptions(
          autoPlay: true,
          onPageChanged: (index, reason) {
            _dashboardViewModelReader.updatePosition(index);
          },
        ),
      );
    }
  }

  Widget _movieCardWidget(Movie featuredMovie) {
    return InkWell(
      onTap: (){
        _openMovieDetail(featuredMovie);
      },
      child: Card(
        child: Row(
          children: [
            _imageMovie(featuredMovie),
            const SizedBox(
              width: 10,
            ),
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    featuredMovie.originalTitleText!.text!,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const Flexible(
                    child: Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _imageMovie(Movie movie) {
    if (movie.primaryImage != null) {
      return Image.network(
        movie.primaryImage!.url!,
        height: 100,
        width: 100,
      );
    } else {
      return const SizedBox(
        height: 100,
        width: 100,
      );
    }
  }

  Widget _dotIndicator() {
    if (_dashboardViewModelWatcher.featuredMovies.isEmpty) {
      return Container();
    } else {
      return DotsIndicator(
        dotsCount: _dashboardViewModelWatcher.featuredMovies.length,
        position: _dashboardViewModelWatcher.position,
      );
    }
  }

  Widget _latestMovies() {
    var latestList = <SizedBox>[];
    if (_dashboardViewModelWatcher.movieList.isNotEmpty) {
      for (var element in _dashboardViewModelWatcher.movieList) {
        latestList.add(
          SizedBox(
            width: 150,
            height: 150,
            child: GestureDetector(
              onTap: (){
                _openMovieDetail(element);
              },
              child: Card(
                child: Column(
                  children: [
                    _imageMovie(element),
                    Text(
                      element.originalTitleText!.text!,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w600),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }
    }
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Latest'),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: latestList,
            ),
          )
        ],
      ),
    );
  }

  Widget _actionMovies() {
    var latestList = <SizedBox>[];
    if (_dashboardViewModelWatcher.actionMovieList.isNotEmpty) {
      for (var element in _dashboardViewModelWatcher.actionMovieList) {
        latestList.add(
          SizedBox(
            width: 150,
            height: 150,
            child: GestureDetector(
              onTap: (){
                _openMovieDetail(element);
              },
              child: Card(
                child: Column(
                  children: [
                    _imageMovie(element),
                    Text(
                      element.originalTitleText!.text!,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w600),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }
    }
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Action'),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: latestList,
            ),
          )
        ],
      ),
    );
  }

   void _openMovieDetail(Movie featuredMovie) {
    _dashboardViewModelReader.selectMovieDetails(featuredMovie);
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return const FractionallySizedBox(
            heightFactor: 0.8,
            child: MoviesDetailView(),
          );
        });
  }


}
