import 'package:get/get.dart';
import 'package:mobx/mobx.dart';
import 'package:my_pokedex/Model/Move_details.dart';
import '../../Helpers/get_move_detail.dart';

part 'move_detail_page_store.g.dart';

enum MoveDetailPageStatus { initial, loading, success, failed }

class MoveDetailPageStore = MoveDetailPageStoreBase with _$MoveDetailPageStore;

abstract class MoveDetailPageStoreBase with Store {
  MoveDetailPageStoreBase({
    required GetMoveDetail getMoveDetail,
    required this.url
  }) : _moveDetail = getMoveDetail;

  final GetMoveDetail _moveDetail;
  final String url;

  @observable
  MoveDetail? moveDetail = null;

  @readonly
  var _contentStatus = MoveDetailPageStatus.initial;

  String get _url => url;

  @action
  Future<void> fetchMoveDetail() async {
    _contentStatus = MoveDetailPageStatus.loading;

    try {
      final mvDetail = await _moveDetail.call(url);
      moveDetail = mvDetail;
      print("fetchMoveDetail() moveDetail: " + moveDetail.toString());
      _contentStatus = MoveDetailPageStatus.success;
    } catch (e) {
      e.printError();
      _contentStatus = MoveDetailPageStatus.failed;
    }
  }

}

