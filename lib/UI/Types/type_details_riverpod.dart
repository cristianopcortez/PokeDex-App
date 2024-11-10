import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import '../../Helpers/responsive_helper.dart';
import '../../Helpers/text_styles.dart';
import '../../Helpers/utility_helpers.dart';
import '../../models/type.dart';
import '../../providers/providers.dart';
import '../../utitliy/constants.dart';

// -----------------------------------------------------------------------------
// Page
// -----------------------------------------------------------------------------
class CharacterPage extends StatelessWidget {
  final String url;
  const CharacterPage({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    print("CharacterPage url : " + url);
    return CharacterView(url: url, key: key);
  }
}

// -----------------------------------------------------------------------------
// View
// -----------------------------------------------------------------------------
class CharacterView extends ConsumerStatefulWidget {
  final String url;
  const CharacterView({super.key, required this.url});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CharacterViewState(url: url);
}

class _CharacterViewState extends ConsumerState<CharacterView> {
  final String url;
  _CharacterViewState({required this.url});

  late final stateVarAsyncTypeDetailsProvider;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      print("_CharacterViewState WidgetsBinding.instance.addPostFrameCallback( url : " + url);
    });
  }

  @override
  Widget build(BuildContext context) {
    return _Content(url: url,);
  }
}

// -----------------------------------------------------------------------------
// Content
// -----------------------------------------------------------------------------
class _Content extends ConsumerStatefulWidget {
  final String url;
  _Content({
    required this.url
  });

  @override
  ConsumerState<_Content> createState() => __ContentState(url: url);
}

class __ContentState extends ConsumerState<_Content> {
  final _scrollController = ScrollController();

  final String url;
  __ContentState({
    required this.url
  });

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {

    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final typeDetailFuture = ref.watch(asyncTypeDetailsProvider.notifier).gettypeDetails2(widget.url);

        return FutureBuilder<TypeDetail>(
          future: typeDetailFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Show a loading widget while waiting for the async operation
              return Padding(
                padding: const EdgeInsets.only(top: 18.0, bottom: 18.0),
                child: Image(
                  image: AppImages.loadingGif,
                  height: 140,
                ),
              );
            } else if (snapshot.hasError) {
              // Show an error widget if the async operation failed
              return DefaultWidget();
            } else if (snapshot.hasData) {
              // Show the main content if data is available
              final typeDetail = snapshot.data!;
              return DraggableScrollableSheet(
                expand: false,
                initialChildSize: 0.8,
                maxChildSize: 1,
                builder: (context, scrollController) => Container(
                  margin: const EdgeInsets.only(left: 30, right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      Text(
                        typeDetail.name.isNotEmpty ? typeDetail.name.capitalizeFirstGet.replaceAll('-', " ") : "",
                        style: AppTextStyle.extraLargeBold.copyWith(color: Color(0xFFe94a41)),
                      ),
                      const SizedBox(height: 20),
                      buildDamageWidget(
                        title: "Double Damage\nFrom : ",
                        list: typeDetail.damageRelations.doubleDamageFrom,
                      ),
                      // (Continue adding the other widgets here as in your original code)
                    ],
                  ),
                ),
              );
            } else {
              // In case the future returned null, show a fallback widget
              return DefaultWidget();
            }
          },
        );
      },
    );

  }

  Row buildDamageWidget({required String title, var list}) {
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: Text(
            title.capitalizeFirstGet,
            style: AppTextStyle.regularBold.copyWith(
              color: Color(0xFF827A7D),
              fontSize: ResponsiveHelper.instance.fontSize - 4,
            ),
          ),
        ),
        Expanded(
          flex: 6,
          child: SizedBox(
            height: 40,
            child: list.isEmpty
                ? Text(
              "No Data",
              style: AppTextStyle.smallBold,
            )
                : ListView.builder(
              shrinkWrap: true,
              itemCount: list.length,
              physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Tooltip(
                  message: list[index].name.toString().capitalizeFirstGet,
                  child: Container(
                    padding: const EdgeInsets.all(4.0),
                    child: SvgPicture.asset(
                      "assets/pokemon_type_icons/" +
                          list[index].name.toString().capitalizeFirstGet +
                          ".svg",
                      color: pokemonTypeMap[
                      list[index].name.toString().capitalizeFirstGet],
                      placeholderBuilder: (context) =>
                          Image.asset('assets/poke_ball.png'),
                      width: 30,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      // ref.read(asyncTypeDetailsProvider.notifier).fetchNextPage();
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}

class DefaultWidget extends StatelessWidget {
  const DefaultWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return
      Padding(
        padding: const EdgeInsets.only(top: 18.0, bottom: 18.0),
        child: Image(
          image: AppImages.loadingGif,
          height: 140,
        ),
      );
  }
}