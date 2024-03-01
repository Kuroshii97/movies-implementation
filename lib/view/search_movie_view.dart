import 'dart:async';

import 'package:flutter/material.dart';
import 'package:movies_application/model/movie.dart';
import 'package:movies_application/view/movies_detail_view.dart';
import 'package:movies_application/viewmodel/dashboard_viewmodel.dart';
import 'package:provider/provider.dart';

class SearchMovieView extends StatefulWidget {
  const SearchMovieView({super.key});

  @override
  State<SearchMovieView> createState() => _SearchMovieViewState();
}

class _SearchMovieViewState extends State<SearchMovieView> {
  final TextEditingController _searchTextEditingController =
      TextEditingController();
  Timer? _debounce;

  late DashboardViewModel _dashboardViewModelReader;
  late DashboardViewModel _dashboardViewModelWatcher;

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
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            TextFormField(
              controller: _searchTextEditingController,
              style: const TextStyle(color: Colors.black),
              onChanged: (value) {
                if (_debounce?.isActive ?? false) _debounce?.cancel();
                _debounce = Timer(const Duration(milliseconds: 500), () {
                  _dashboardViewModelReader.searchMovie(value);
                });
              },
              decoration: InputDecoration(
                hintStyle: TextStyle(color: Colors.grey),
                contentPadding: const EdgeInsets.only(top: 15.5),
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.black,
                ),
                hintText: 'Search Movie',
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemCount: _dashboardViewModelWatcher.searchedMovies.length,
                itemBuilder: (BuildContext context, index) {
                  return SizedBox(
                    width: 150,
                    height: 150,
                    child: GestureDetector(
                      onTap: (){
                        _openMovieDetail(_dashboardViewModelWatcher.searchedMovies[index]);
                      },
                      child: Card(
                        child: Column(
                          children: [
                            _imageMovie(_dashboardViewModelWatcher.searchedMovies[index]),
                            Text(
                              _dashboardViewModelWatcher.searchedMovies[index].originalTitleText!.text!,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
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
