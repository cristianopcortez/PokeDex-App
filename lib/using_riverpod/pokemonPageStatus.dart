import 'package:equatable/equatable.dart';

import '../Model/pokemon.dart';

enum PokemonPageStatus { initial, loading, success, failure }

class PokemonPageState extends Equatable {
  const PokemonPageState({
    this.status = PokemonPageStatus.initial,
    this.pokemons = const [],
    this.hasReachedEnd = false,
    this.currentPage = 1,
  });

  final PokemonPageStatus status;
  final List<Pokemon> pokemons;
  final bool hasReachedEnd;
  final int currentPage;

  PokemonPageState copyWith({
    PokemonPageStatus? status,
    List<Pokemon>? characters,
    bool? hasReachedEnd,
    int? currentPage,
  }) {
    return PokemonPageState(
      status: status ?? this.status,
      pokemons: characters ?? this.pokemons,
      hasReachedEnd: hasReachedEnd ?? this.hasReachedEnd,
      currentPage: currentPage ?? this.currentPage,
    );
  }

  @override
  List<Object> get props => [
    status,
    pokemons,
    hasReachedEnd,
    currentPage,
  ];
}
