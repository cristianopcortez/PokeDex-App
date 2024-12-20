import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:line_icons/line_icons.dart';
import 'package:my_pokedex/Helpers/api_helper.dart';
import 'package:my_pokedex/Helpers/responsive_helper.dart';
import 'package:my_pokedex/Helpers/text_styles.dart';
import 'package:my_pokedex/Model/MovesList.dart';
import 'package:my_pokedex/UI/Moves/TM_Tile.dart';

class ListPage extends StatefulWidget {
  final String url, title, description, imgUrl;
  final int type;
  ListPage({required this.url, required this.title, required this.description,
    required this.type, required this.imgUrl});
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  PagingController<String, Results> _pagingController =
      PagingController(firstPageKey: "widget.url");
  final apiService = GetIt.instance.get<APIHelper>();

  @override
  void initState() {
    _pagingController = PagingController(firstPageKey: widget.url);
    _pagingController.addPageRequestListener((pageUrl) {
      _fetchPage(pageUrl);
    });
    super.initState();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  Future<void> _fetchPage(String pageUrl) async {
    print("_fetchPage: " + pageUrl);
    try {
      print(pageUrl);
      final newItems = await apiService.getMoves(pageUrl);
      if (newItems.next == null) {
        _pagingController.appendLastPage(newItems.results);
      } else {
        final nextPageKey = newItems.next;
        _pagingController.appendPage(newItems.results, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          width: ResponsiveHelper.instance.width,
          height: ResponsiveHelper.instance.height,
          child: Stack(
            children: [
              Positioned(
                left: ResponsiveHelper.instance.width - 160,
                bottom: (ResponsiveHelper.instance.height / 1.45),
                child: Image.asset(
                  'assets/poke_ball.png',
                  width: 230,
                  height: 230,
                ),
              ),
              Positioned(
                left: 10,
                top: 35,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    LineIcons.alternateLongArrowLeft,
                    color: Color(0xFFe94a41),
                  ),
                  iconSize: 30,
                ),
              ),
              Positioned(
                left: 30,
                top: 45,
                right: 25,
                child: Container(
                  width: ResponsiveHelper.instance.width,
                  height: ResponsiveHelper.instance.height,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 35.0),
                        child: Text(
                          widget.title,
                          style: AppTextStyle.extraLargeBold.copyWith(
                            color: Color(0xFFe94a41),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        widget.description,
                        style: AppTextStyle.regularBold.copyWith(
                          color: Color(0xFF827A7D),
                          fontSize: ResponsiveHelper.instance.fontSize - 4,
                        ),
                      ),
                      Expanded(
                          child: PagedGridView<String, Results>(
                        pagingController: _pagingController,
                        physics: BouncingScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 150 / 150,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                          crossAxisCount: 2,
                        ),
                        builderDelegate: PagedChildBuilderDelegate<Results>(
                          itemBuilder: (context, item, index) => TMTile(
                            moves: item,
                            type: widget.type,
                            imgUrl: widget.imgUrl,
                          ),
                        ),
                      )),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
