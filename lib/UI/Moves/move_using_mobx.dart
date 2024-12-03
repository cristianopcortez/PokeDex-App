import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_pokedex/UI/Moves/move_detail_mobx.dart';
import '../../Helpers/get_move_detail.dart';
import 'package:provider/provider.dart';

class MoveUsingMobX extends StatelessWidget {
  const MoveUsingMobX({super.key, required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    //
    // It Provides UseCases down to the widget tree using Bloc's D.I widget.
    //
    // MobX doesn't have a widget that allow us to provide dependencies,
    // because of that it's hard to decouple things properly when using it.
    // E.g.: Inject dependencies in Store's constructors.
    //
    // MobX recommendation is to use 'Provider':
    // https://mobx.netlify.app/guides/stores#the-triad-of-widget---store---service
    // But here we've used Bloc's Repository widget
    //
    return RepositoryProvider.value(
      value: url,
      child: AppView(url: url,),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key, required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    return Provider<GetMoveDetail>(
      create: (_) => GetMoveDetail(url: url),
      child: MoveDetailPage(url: url),
    );
  }
}