import 'package:flutter/material.dart';
import 'package:movies_application/viewmodel/dashboard_viewmodel.dart';
import 'package:provider/provider.dart';

class MoviesDetailView extends StatefulWidget {
  const MoviesDetailView({super.key});

  @override
  State<MoviesDetailView> createState() => _MoviesDetailViewState();
}

class _MoviesDetailViewState extends State<MoviesDetailView> {
  late DashboardViewModel _dashboardViewModelReader;
  late DashboardViewModel _dashboardViewModelWatcher;

  @override
  Widget build(BuildContext context) {
    _dashboardViewModelReader = context.read<DashboardViewModel>();
    _dashboardViewModelWatcher = context.watch<DashboardViewModel>();
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              RawMaterialButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                elevation: 2.0,
                fillColor: Colors.grey,
                padding: const EdgeInsets.all(5.0),
                shape: const CircleBorder(),
                child: const Icon(
                  Icons.close,
                  color: Colors.white,
                ),
              )
            ],
          ),
          _imageMovie(),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _dashboardViewModelWatcher.movie.originalTitleText!.text!,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const Expanded(
                  child: Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                    maxLines: 12,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _imageMovie() {
    if (_dashboardViewModelWatcher.movie.primaryImage != null) {
      return Image.network(
        _dashboardViewModelWatcher.movie.primaryImage!.url!,
        height: 200,
        width: MediaQuery.of(context).size.width - 40,
      );
    } else {
      return const SizedBox(
        height: 200,
      );
    }
  }
}
