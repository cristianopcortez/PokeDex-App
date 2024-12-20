import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_pokedex/Helpers/text_styles.dart';
import 'package:my_pokedex/Model/MovesList.dart';
import 'package:my_pokedex/UI/Abilities/ability_detail.dart';
import 'package:my_pokedex/UI/Items/Item_detail_sheet.dart';
import 'package:my_pokedex/Helpers/utility_helpers.dart';
import 'package:my_pokedex/utitliy/constants.dart';
import '../Types/type_details_riverpod.dart';
import 'move_using_mobx.dart';

class TMTile extends StatefulWidget {
  final Results moves;
  final int type;
  final String imgUrl;
  TMTile({required this.moves, required this.type, required this.imgUrl});
  @override
  _TMTileState createState() => _TMTileState();
}

class _TMTileState extends State<TMTile> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.type != 4) {
          showModalBottomSheet(
            context: context,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            isScrollControlled: true,
            builder: (context) {
              switch (widget.type) {
                case 0:
                  return MoveUsingMobX(url: widget.moves.url);
                  // return MoveDetailPage(url: widget.moves.url);
                  // return MoveDetailSheet(url: widget.moves.url);
                  break;

                case 1:
                  return AbilityDetailSheet(url: widget.moves.url);
                  break;

                case 2:
                  return ItemDetailSheet(url: widget.moves.url);
                  break;

                case 3:
                  print("case 3 - widget.moves.url: " + widget.moves.url);
                  return CharacterPage(url: widget.moves.url);
                  break;

                default:
                  return Container();
              }
            },
          );
        }
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10.0, left: 6, right: 6),
        height: 60,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6),
            boxShadow: [
              BoxShadow(
                offset: Offset(0.0, .5),
                blurRadius: 8.0,
                color: Colors.grey[300] ?? Colors.grey,
              )
            ]),
        child: GridTile(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: widget.type != 3
                    ? Image.asset(
                        widget.imgUrl,
                        height: 60,
                      )
                    : SvgPicture.asset(
                        "assets/pokemon_type_icons/" +
                            widget.moves.name.capitalizeFirst +
                            ".svg",
                        color: pokemonTypeMap[widget.moves.name.capitalizeFirst],
                        placeholderBuilder: (context) =>
                            Image.asset('assets/poke_ball.png'),
                        width: 40,
                      ),
              ),
              const SizedBox(height: 10),
              Text(
                  widget.moves == null
                      ? "pokemon.name"
                      : widget.moves.name.capitalizeFirst.replaceAll('-', " "),
                  textAlign: TextAlign.center,
                  style: AppTextStyle.smallBold),
            ],
          ),
        ),
      ),
    );
  }
}
