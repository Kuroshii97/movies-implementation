import 'package:dio/dio.dart';
import 'package:movies_application/network/dio_manager.dart';
import 'package:movies_application/util/custom_exception.dart';

class NetworkProvider {
  dynamic _handleResponse(Response response) {
    return response.data;
  }

  _handleError(dynamic error) {
    if (error is DioError) {
      if (error.response == null) {
        throw FetchDataException(error.message!);
      } else {
        throw BadRequestException(error.response!.data['message']);
      }
    } else {
      throw FetchDataException(error.message);
    }
  }

  Future<dynamic> getMoviesList() async {
    dynamic responseJson;

    try {
      final response = await DioManager.getDio()
          .get('/titles', queryParameters: {'limit': 10, 'sort':'year.decr'});
      responseJson = _handleResponse(response);
    } catch (error) {
      _handleError(error);
    }
    return responseJson;
  }

  Future<dynamic> getActionMoviesList() async {
    dynamic responseJson;

    try {
      final response = await DioManager.getDio()
          .get('/titles', queryParameters: {'limit': 10, 'sort':'year.decr', 'genre':'Action'});
      responseJson = _handleResponse(response);
    } catch (error) {
      _handleError(error);
    }
    return responseJson;
  }

  Future<dynamic> searchMovieByName(String movieName) async {
    dynamic responseJson;

    try {
      final response = await DioManager.getDio()
          .get('/titles/search/title/$movieName', queryParameters: {'limit': 10, 'sort':'year.decr'});
      responseJson = _handleResponse(response);
    } catch (error) {
      _handleError(error);
    }
    return responseJson;
  }

  Future<dynamic> selectMovieDetailById(String id) async {
    dynamic responseJson;

    try {
      final response = await DioManager.getDio()
          .get('/titles/search/title/$id');
      responseJson = _handleResponse(response);
    } catch (error) {
      _handleError(error);
    }
    return responseJson;
  }

}
