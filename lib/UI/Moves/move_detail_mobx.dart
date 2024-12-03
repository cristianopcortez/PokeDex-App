import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_pokedex/Helpers/text_styles.dart';
import 'package:my_pokedex/Model/Move_details.dart';
import 'package:my_pokedex/Helpers/utility_helpers.dart';
import 'package:my_pokedex/utitliy/constants.dart';
import 'package:provider/provider.dart';
import '../../Helpers/get_move_detail.dart';
import 'move_detail_page_store.dart';

// -----------------------------------------------------------------------------
// Page
// -----------------------------------------------------------------------------
class MoveDetailPage extends StatelessWidget {
  final String url;
  MoveDetailPage({required this.url});
  MoveDetail? moveDetails;

  @override
  Widget build(BuildContext context) {
    //
    // We're creating an Store here and passing it manually as dependency to
    // constructors.
    //
    // A different option would be to use Provider to provide it down to the
    // widget tree. This approach is also suggested by the MobX's documentation
    //

    print("MoveDetailPage url: " + url);

    return MoveDetailView(
      store: MoveDetailPageStore(
        getMoveDetail: context.read<GetMoveDetail>(),
        url: url
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// View
// -----------------------------------------------------------------------------
class MoveDetailView extends StatefulWidget {
  const MoveDetailView({super.key, required this.store});

  final MoveDetailPageStore store;

  @override
  State<MoveDetailView> createState() => _MoveDetailViewState();
}

class _MoveDetailViewState extends State<MoveDetailView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.store.fetchMoveDetail();
    });
  }

  @override
  Widget build(BuildContext context) {
    print(widget.store.contentStatus);
    return Observer(
      builder: (_) => widget.store.contentStatus == MoveDetailPageStatus.loading
          ? const Center(child: Padding(
                        padding: const EdgeInsets.only(top: 18.0, bottom: 18.0),
                        child: Image(
                          image: AppImages.loadingGif,
                          height: 140,
                        ),
                      )
      )
          : _MoveDetailContent(store: widget.store),
    );
  }
}

// -----------------------------------------------------------------------------
// Content
// -----------------------------------------------------------------------------
class _MoveDetailContent extends StatefulWidget {
  const _MoveDetailContent({super.key, required this.store});

  final MoveDetailPageStore store;

  @override
  State<_MoveDetailContent> createState() => __MoveDetailContent();
}

class __MoveDetailContent extends State<_MoveDetailContent> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    print("__MoveDetailContent build moveDetail:");
    print(widget.store.moveDetail);
    final moveDetails = widget.store.moveDetail;

    return DraggableScrollableSheet(
        initialChildSize: .7,
        maxChildSize: 1,
        expand: false,
        builder: (context, scrollController) {
          if (moveDetails != null) {
            return Stack(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 8, 18, 8),
                    child: SvgPicture.asset(
                      "assets/pokemon_type_icons/" +
                          (moveDetails.type.name.capitalizeFirst) +
                          ".svg",
                      color: pokemonTypeMap[
                      moveDetails.type.name.capitalizeFirst],
                      placeholderBuilder: (context) =>
                          Image.asset('assets/poke_ball.png'),
                      width: 90,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 30, right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      Text(
                        (moveDetails.name.capitalizeFirst)
                            .replaceAll('-', " "),
                        style: AppTextStyle.extraLargeBold.copyWith(
                          color: Color(0xFFe94a41),
                        ),
                      ),
                      const SizedBox(height: 25),
                      buildAboutInformation(
                          "Type", moveDetails.type.name.capitalizeFirst),
                      const SizedBox(height: 5),
                      moveDetails.accuracy != null ? (
                        buildAboutInformation(
                            "Accuracy", moveDetails.accuracy.toString())
                      ) : const SizedBox(height: 0),
                      const SizedBox(height: 5),
                      moveDetails.pp != null ? buildAboutInformation(
                          "PP", moveDetails.pp.toString()
                      ) : const SizedBox(height: 0),
                      const SizedBox(height: 5),
                      moveDetails.power != null ? buildAboutInformation(
                          "Power", moveDetails.power.toString()
                      ) : const SizedBox(height: 0),
                      const SizedBox(height: 5),
                      buildAboutInformation(
                          "Priority", moveDetails.priority.nullCheck),
                      const SizedBox(height: 15),
                      Text(
                        "Other Information",
                        style: AppTextStyle.smallBold,
                      ),
                      const SizedBox(height: 15),
                      buildAboutInformation("Contest Type",
                          moveDetails.contestType!.name.capitalizeFirst),
                      const SizedBox(height: 5),
                      buildAboutInformation("Damage class",
                          moveDetails.damageClass!.name.capitalizeFirst),
                      const SizedBox(height: 5),
                      buildAboutInformation("Flinch chance",
                          moveDetails.meta!.flinchChance.nullCheck),
                      const SizedBox(height: 5),
                      buildAboutInformation(
                          "Healing", moveDetails.meta!.healing.nullCheck),
                      const SizedBox(height: 5),
                      buildAboutInformation("Stat chance",
                          moveDetails.meta!.statChance.nullCheck),
                      const SizedBox(height: 5),
                      buildAboutInformation("Crit rate ",
                          moveDetails.meta!.critRate.nullCheck),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return Padding(
              padding: const EdgeInsets.only(top: 18.0, bottom: 18.0),
              child: Image(
                image: AppImages.loadingGif,
                height: 140,
              ),
            );
          }
        });
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
      // widget.store.fetchNextPage();
      print("---------- _isBottom");
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}