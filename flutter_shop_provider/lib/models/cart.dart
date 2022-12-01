import 'package:flutter/foundation.dart';
import 'package:flutter_shop_provider/models/catalog.dart';

class CartModel extends ChangeNotifier {
  // 변경내역 감시 기능을 위한 ChangeNotifier 클래스 상속
  /// The private field backing [catalog].
  late CatalogModel _catalog;

  /// Internal, private state of the cart. Stores the ids of each item.
  final List<int> _itemIds = [];

  /// The current catalog. Used to construct items from numeric ids.
  CatalogModel get Catalog => _catalog;

  set catalog(CatalogModel newCatalog) {
    _catalog = newCatalog;
    // Notify listeners, in case the new catalog provides information
    // different from the previous one. For example, availability of an item
    // might have changed.
    notifyListeners(); // 변경 내역 감지 등록
  }

  /// List of items in the cart.
  List<Item> get items => _itemIds
      .map((id) => _catalog.getById(id))
      .toList(); // 아이템 인덱스 번호 가져와 리스트로 변환

  /// The current total price of all items.
  int get totalPrice =>
      items.fold(0, (total, current) => total + current.price); // 전체 합계를 계산

  /// Adds [item] to cart. This is the only way to modift the cart from outside.
  void add(Item item) {
    _itemIds.add(item.id);
    // This line tells [Model] that it should rebuild the widgets that
    // depend on it.
    notifyListeners(); // 변경 내역 감지 등록
  }

  void remove(Item item) {}
}
