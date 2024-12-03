// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'move_detail_page_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MoveDetailPageStore on MoveDetailPageStoreBase, Store {
  late final _$_contentStatusAtom =
      Atom(name: 'MoveDetailPageStoreBase._contentStatus', context: context);

  MoveDetailPageStatus get contentStatus {
    _$_contentStatusAtom.reportRead();
    return super._contentStatus;
  }

  @override
  MoveDetailPageStatus get _contentStatus => contentStatus;

  @override
  set _contentStatus(MoveDetailPageStatus value) {
    _$_contentStatusAtom.reportWrite(value, super._contentStatus, () {
      super._contentStatus = value;
    });
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
