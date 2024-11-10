import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_pokedex/models/type.dart';

import '../Helpers/api_helper.dart';

class MyStateNotifier extends StateNotifier<String> {
  MyStateNotifier() : super('');

  void updateValue(String newValue) {
    state = newValue;
  }
}

/*
final myStateNotifierProvider = StateNotifierProvider<MyStateNotifier, String>((ref) {
  return MyStateNotifier();
});

// VERSÃO COM ASYNCNOTIFIERPROVIDER
final urlProvider = StateNotifierProvider<UrlNotifier, String>((ref) {
  return UrlNotifier();
});

class UrlNotifier extends StateNotifier<String> {
  UrlNotifier() : super('https://pokeapi.co/api/v2/type/10/'); // Replace with your initial URL

  void updateUrl(String newUrl) {
    state = newUrl;
  }
}
*/

final asyncTypeDetailsProvider =
AsyncNotifierProvider<AsyncNewsNotifier, TypeDetail>(
        () => AsyncNewsNotifier(url: ''));

class AsyncNewsNotifier extends AsyncNotifier<TypeDetail> {
  late final String url;

  AsyncNewsNotifier({required this.url});

  Future<TypeDetail> fetchTypeDetails() async {
    state = const AsyncLoading();
    TypeDetail typeDetail;
    state = await AsyncValue.guard(() async {
      typeDetail = await gettypeDetails2(url);
      return typeDetail;
    });
    return TypeDetail(
        damageRelations: DamageRelations(
            doubleDamageFrom: [],
            doubleDamageTo: [],
            halfDamageFrom: [],
            halfDamageTo: [],
            noDamageFrom: [],
            noDamageTo: []
        ),
        id: 0,
        moveDamageClass: DamageType(name: '', url: ''),
        name: ''
    );
  }

  Future<TypeDetail> gettypeDetails2(String url) async {
    final typeDetails = await APIHelper().getTypeDetail(url);
    await Future.delayed(Duration(seconds: 2));
    return typeDetails;
  }

  void initialize() {
    fetchTypeDetails();
  }

  @override
  FutureOr<TypeDetail> build() {
    this.url = url;
    return fetchTypeDetails();
  }
}

// VERSÃO COM STATENOTIFIER
/*
final urlProvider = StateNotifierProvider<UrlNotifier, String>((ref) {
  return UrlNotifier();
});

class UrlNotifier extends StateNotifier<String> {
  UrlNotifier() : super('https://pokeapi.co/api/v2/type/10/'); // Replace with your initial URL

  void updateUrl(String newUrl) {
    state = newUrl;
  }
}

final asyncTypeDetailsProvider = StateNotifierProvider<AsyncNewsNotifier, AsyncValue<TypeDetail>>((ref) {
  final url = ref.watch(urlProvider);
  return AsyncNewsNotifier(url: url);
});

class AsyncNewsNotifier extends StateNotifier<AsyncValue<TypeDetail>> {
  late final String url;

  AsyncNewsNotifier({required this.url}) : super(const AsyncValue.loading());

  Future<void> fetchTypeDetails() async {
    try {
      final typeDetails = await APIHelper().getTypeDetail(url);
      state = AsyncValue.data(typeDetails);
    } catch (error) {
      state = AsyncValue.error(error, StackTrace.current);
    }
  }

  void initialize() {
    fetchTypeDetails();
  }
}*/
