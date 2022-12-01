import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_shop_provider/models/cart.dart';
import 'package:flutter_shop_provider/models/catalog.dart';

class MyCatalog extends StatelessWidget {
  const MyCatalog({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        // 사용자 정의 스크롤 정의
        slivers: [
          _MyAppBar(),
          const SliverToBoxAdapter(child: SizedBox(height: 12)), // 실버박스 아답터 필수
          SliverList(
            // 실버 리스트
            delegate: SliverChildBuilderDelegate(
                (context, index) => _MyListItem(index)),
          ),
        ],
      ),
    );
  }
}

class _AddButton extends StatelessWidget {
  final Item item;
  const _AddButton({required this.item});
  @override
  Widget build(BuildContext context) {
    // This can lead to significant performance improvements.
    var isInCart = context.select<CartModel, bool>(
      // 카트 위젯 선택
      // Here, we are only interested whether [item] is inside the cart.
      (cart) => cart.items.contains(item), // 장바구니에 특정 아이템 추출
    );
    return TextButton(
      onPressed: isInCart // 카트 확인
          ? null
          : () {
              var cart = context.read<CartModel>(); // 변경 발생 시 위젯 재빌드 x
              cart.add(item); // 장바구니에 추가 - 상태 변경
            },
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
          // 버튼 오버레이 색상 (상태별로 스타일 변경)
          if (states.contains(MaterialState.pressed)) {
            // 버튼 클릭된 상태
            return Theme.of(context).primaryColor;
          }
          return null; // Defer to the widget's default.
        }),
      ),
      child: isInCart
          ? const Icon(Icons.check, semanticLabel: 'ADDED') // 클릭 후 아이콘 변경
          : const Text('ADD'),
    );
  }
}

class _MyAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: Text('Catalog', style: Theme.of(context).textTheme.displayLarge),
      floating: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.shopping_cart), // 장바구니 아이콘
          onPressed: () => Navigator.pushNamed(context, '/cart'),
        ),
      ],
    );
  }
}

class _MyListItem extends StatelessWidget {
  final int index;
  const _MyListItem(this.index);
  @override
  Widget build(BuildContext context) {
    var item = context.select<CatalogModel, Item>(
      // 선택된 카탈로그
      (catalog) => catalog.getByPosition(index),
    );
    var textTheme = Theme.of(context).textTheme.titleLarge;
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 8), // 수평, 수직 여백
      child: LimitedBox(
        // 최대 크기까지 자동 증가
        maxHeight: 48,
        child: Row(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Container(
                color: item.color,
              ),
            ),
            const SizedBox(width: 24),
            Expanded(
              // 자식 위젯 크기를 최대로 확장
              child: Text(item.name, style: textTheme),
            ),
            const SizedBox(width: 24),
            _AddButton(item: item),
          ],
        ),
      ),
    );
  }
}
