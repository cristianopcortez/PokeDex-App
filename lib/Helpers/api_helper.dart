import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:my_pokedex/Model/Move_details.dart';
import 'package:my_pokedex/Model/MovesList.dart';
import 'package:my_pokedex/Model/ability_detail.dart';
import 'package:my_pokedex/Model/item_detail.dart';
import 'package:my_pokedex/Model/news.dart';
import 'package:my_pokedex/Model/pokemonAPI.dart';
import 'package:my_pokedex/models/type.dart';

class APIHelper {
  static late Dio dio;
  static final APIHelper apiHelper = APIHelper._internal();

  factory APIHelper() {
    dio = new Dio();
    return apiHelper;
  }

  APIHelper._internal();

  Future<News> getNews() async {
    late News news;

    await dio
        .get("https://newsapi.org/v2/everything?q=pokemon&from=" +
            DateFormat("yyyy-mm-dd")
                .format(DateTime.now().subtract(new Duration(days: 5))) +
            "&to=" +
            DateFormat("yyyy-mm-dd").format(DateTime.now()) +
            "&sortBy=popularity&apiKey=97f5536aca9c4c0995ede7bb29cf4e64")
        .then((receivedResponse) {
      Response response = receivedResponse;
      if (response.statusCode == 200) {
        news = News.fromJson(response.data);
      } else {
        return null;
      }
    }).catchError((onError) {
      print("Error : " + onError.toString());
      return null;
    });
    return news;
  }

  Future<PokemonAPI> getPokemon(String index) async {
    late PokemonAPI pokemonAPI;

    await dio
        .get("https://pokeapi.co/api/v2/pokemon/" + index)
        .then((receivedResponse) {
      Response response = receivedResponse;
      if (response.statusCode == 200) {
        pokemonAPI = PokemonAPI.fromJson(response.data);
      } else {
        return null;
      }
    }).catchError((onError) {
      print("Error : " + onError.toString());
      return null;
    });
    return pokemonAPI;
  }

  Future<MovesList> getMoves(String index) async {
    late MovesList pokemonAPI;
    // print("https://pokeapi.co/api/v2/machine/" + index);
    print("url: " + index);

    await dio.get(index).then((receivedResponse) {
      Response response = receivedResponse;
      // print("response : " + response.toString());
      print("response statusCode : " + response.statusCode.toString());
      if (response.statusCode == 200) {
        pokemonAPI = MovesList.fromJson(response.data);
      } else {
        return null;
      }
    }).catchError((onError) {
      print("Error : " + onError.toString());
      onError.printError();
      return null;
    });
    return pokemonAPI;
  }

  Future<MoveDetail> getMoveDetail(String url) async {
    late MoveDetail moveDetail;

    await dio.get(url).then((receivedResponse) {
      Response response = receivedResponse;
      if (response.statusCode == 200) {
        moveDetail = MoveDetail.fromJson(response.data);
      } else {
        return null;
      }
    }).catchError((onError) {
      print("Error : " + onError.toString());
      return null;
    });
    return moveDetail;
  }

  Future<AbilityDetail> getAbilityDetail(String url) async {
    late AbilityDetail abilityDetail;

    await dio.get(url).then((receivedResponse) {
      Response response = receivedResponse;
      if (response.statusCode == 200) {
        abilityDetail = AbilityDetail.fromJson(response.data);
      } else {
        return null;
      }
    }).catchError((onError) {
      print("Error : " + onError.toString());
      return null;
    });
    return abilityDetail;
  }

  Future<ItemDetail> geitemDetail(String url) async {
    late ItemDetail itemDetail;

    await dio.get(url).then((receivedResponse) {
      Response response = receivedResponse;
      print("geitemDetail response statusCode : " + response.statusCode.toString());
      if (response.statusCode == 200) {
        itemDetail = ItemDetail.fromJson(response.data);
      } else {
        return null;
      }
    }).catchError((onError) {
      print("Error : " + onError.toString());
      return null;
    });
    return itemDetail;
  }

  Future<TypeDetail> getTypeDetail(String url) async {
    late TypeDetail typeDetail;

    print("apihelper getTypeDetail url : " + url);

    await dio.get(url).then((receivedResponse) {
      Response response = receivedResponse;
      print("getTypeDetail response statusCode : " + response.statusCode.toString());
      if (response.statusCode == 200) {
        typeDetail = TypeDetail.fromJson(response.data);
      } else {
        return null;
      }
    }).catchError((onError) {
      print("Error : " + onError.toString());
      return null;
    });
    return typeDetail;
  }
}
