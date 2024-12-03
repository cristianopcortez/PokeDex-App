import 'package:dio/dio.dart';
import 'package:my_pokedex/Model/Move_details.dart';

class GetMoveDetail {
  final String url;
  GetMoveDetail({required this.url});

  static late Dio dio;

  Future<MoveDetail?> call(String url) async {
    print("GetMoveDetail call url: " + url);

    dio = Dio();
    try {
      final response = await dio.get(url);
      if (response.statusCode == 200) {
        print("response.statusCode: " + response.statusCode.toString());
        return MoveDetail.fromJson(response.data);
      } else {
        print("Error: response.statusCode: " + response.statusCode.toString());
        return null;
      }
    } catch (error) {
      print("Error: " + error.toString());
      return null;
    }
  }
}
