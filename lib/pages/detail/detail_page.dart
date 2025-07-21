import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:today_s_farm/providers/cart_provider.dart';
import 'package:today_s_farm/models/product_model.dart';
import 'package:today_s_farm/utils/price_formatter.dart';
import 'package:today_s_farm/utils/star_icon_formatter.dart';
import 'package:today_s_farm/pages/cart/cart_page.dart';
import 'package:today_s_farm/pages/detail/widgets/cart_dialog.dart';

class DetailPage extends StatefulWidget {
  final Product product;

  const DetailPage({Key? key, required this.product}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> with TickerProviderStateMixin {
  int _quantity = 1;
  ScrollController? _scrollController;
  AnimationController? _bottomBarController;
  Animation<double>? _bottomBarAnimation;
  bool _isBottomBarVisible = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _bottomBarController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _bottomBarAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _bottomBarController!, curve: Curves.easeInOut),
    );

    _scrollController!.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController?.dispose();
    _bottomBarController?.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController?.position.pixels != null) {
      if (_scrollController!.position.pixels > 100 && !_isBottomBarVisible) {
        setState(() {
          _isBottomBarVisible = true;
        });
        _bottomBarController?.forward();
      } else if (_scrollController!.position.pixels <= 100 &&
          _isBottomBarVisible) {
        setState(() {
          _isBottomBarVisible = false;
        });
        _bottomBarController?.reverse();
      }
    }
  }

  void _increment() {
    if (_quantity < 99) {
      setState(() => _quantity++);
    }
  }

  void _decrement() {
    if (_quantity > 1) {
      setState(() => _quantity--);
    }
  }

  void _addToCart() {
    final cartProvider = context.read<CartProvider>();
    cartProvider.addItem(widget.product, quantity: _quantity);

    _showCartDialog();
  }

  void _showCartDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CartDialog(product: widget.product, quantity: _quantity);
      },
    );
  }

  void _buyNow() {
    final cartProvider = context.read<CartProvider>();
    cartProvider.addItem(widget.product, quantity: _quantity);

    // CartPage로 이동
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CartPage()),
    );
  }

  Color _getOriginChipColor(String origin) {
    if (origin.contains('익산')) {
      return const Color(0xFFE3F2FD); // 연한 파랑
    } else if (origin.contains('평창')) {
      return const Color(0xFFF3E5F5); // 연한 보라
    } else if (origin.contains('청주')) {
      return const Color(0xFFE8F5E8); // 연한 초록
    } else if (origin.contains('서산')) {
      return const Color(0xFFFFF3E0); // 연한 주황
    } else if (origin.contains('강원')) {
      return const Color(0xFFE0F2F1); // 연한 청록
    } else if (origin.contains('고창')) {
      return const Color(0xFFFCE4EC); // 연한 분홍
    } else if (origin.contains('영양')) {
      return const Color(0xFFF1F8E9); // 연한 연두
    } else if (origin.contains('성주')) {
      return const Color(0xFFE8EAF6); // 연한 남색
    } else if (origin.contains('증평')) {
      return const Color(0xFFE0F7FA); // 연한 하늘
    } else {
      return const Color(0xFFE0E0E0); // 기본 회색
    }
  }

  Color _getOriginTextColor(String origin) {
    if (origin.contains('익산')) {
      return const Color(0xFF1976D2); // 진한 파랑
    } else if (origin.contains('평창')) {
      return const Color(0xFF7B1FA2); // 진한 보라
    } else if (origin.contains('청주')) {
      return const Color(0xFF388E3C); // 진한 초록
    } else if (origin.contains('서산')) {
      return const Color(0xFFF57C00); // 진한 주황
    } else if (origin.contains('강원')) {
      return const Color(0xFF00695C); // 진한 청록
    } else if (origin.contains('고창')) {
      return const Color(0xFFC2185B); // 진한 분홍
    } else if (origin.contains('영양')) {
      return const Color(0xFF689F38); // 진한 연두
    } else if (origin.contains('성주')) {
      return const Color(0xFF3F51B5); // 진한 남색
    } else if (origin.contains('증평')) {
      return const Color(0xFF0097A7); // 진한 하늘
    } else {
      return const Color(0xFF616161); // 기본 회색
    }
  }

  @override
  Widget build(BuildContext context) {
    final totalPrice = widget.product.price * _quantity;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5), // 배경색 변경
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F5F5), // 배경색 변경
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: const Color(0xFF333333)), // 색상 변경
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.product.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              Icons.shopping_cart_outlined,
              color: const Color(0xFF333333), // 색상 변경
              size: 28,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CartPage()),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                // 스크롤 가능한 콘텐츠 영역
                Expanded(
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    child: Column(
                      children: [
                        // 제품 이미지 영역
                        Container(
                          width: double.infinity,
                          color: const Color(0xFFF5F5F5), // 배경색 변경
                          child: widget.product.imageUrl != null
                              ? Image.asset(
                                  widget.product.imageUrl!,
                                  width: double.infinity,
                                  fit: BoxFit.fitWidth,
                                  errorBuilder: (_, __, ___) => Container(
                                    color: const Color(0xFFF5F5F5), // 배경색 변경
                                    height:
                                        MediaQuery.of(context).size.height *
                                        0.6,
                                    child: Icon(
                                      Icons.image,
                                      size: 60,
                                      color: const Color(0xFF9E9E9E), // 색상 변경
                                    ),
                                  ),
                                )
                              : Container(
                                  color: const Color(0xFFF5F5F5), // 배경색 변경
                                  height:
                                      MediaQuery.of(context).size.height * 0.6,
                                  child: Icon(
                                    Icons.image,
                                    size: 60,
                                    color: const Color(0xFF9E9E9E), // 색상 변경
                                  ),
                                ),
                        ),

                        // 제품 정보 섹션
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // 판매자 정보와 별점
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      // 원산지 Chip
                                      Chip(
                                        label: Text(
                                          widget.product.origin,
                                          style: TextStyle(
                                            color: _getOriginTextColor(
                                              widget.product.origin,
                                            ),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        backgroundColor: _getOriginChipColor(
                                          widget.product.origin,
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 4,
                                        ),
                                        materialTapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                        visualDensity: VisualDensity.compact,
                                        elevation: 0,
                                        side: BorderSide.none,
                                      ),
                                      const SizedBox(width: 8),
                                      // 농부 정보
                                      Text(
                                        '${widget.product.farmer} 농부',
                                        style: TextStyle(
                                          color: const Color(
                                            0xFF333333,
                                          ), // 색상 변경
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      PartialStarRating(
                                        rating: widget.product.star ?? 0.0,
                                        size: 21,
                                        filledColor: const Color(
                                          0xFFFBC02D,
                                        ), // 별 채우기 색상
                                        unfilledColor: const Color(
                                          0xFFE0E0E0,
                                        ), // 별 비우기 색상
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        widget.product.star?.toString() ??
                                            '0.0',
                                        style: TextStyle(
                                          color: const Color(
                                            0xFF9E9E9E,
                                          ), // 색상 변경
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        // 첫 번째 구분선
                        Divider(
                          color: const Color(0xFFE0E0E0), // 구분선 색상 변경
                          thickness: 1,
                          height: 1,
                          indent: 0,
                          endIndent: 0,
                        ),

                        // 제품명과 가격 정보 섹션
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 16,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // 제품명
                              Text(
                                widget.product.name,
                                style: TextStyle(
                                  color: const Color(0xFF333333), // 색상 변경
                                  fontSize: 23,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),

                              const SizedBox(height: 12),

                              // 가격
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                textBaseline: TextBaseline.alphabetic,
                                children: [
                                  Text(
                                    PriceFormatterWithOutUnit.format(
                                      widget.product.price,
                                    ),
                                    style: TextStyle(
                                      color: const Color(0xFFFBC02D), // 가격 색상
                                      fontSize: 38,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                  const SizedBox(width: 2),
                                  Text(
                                    '원',
                                    style: TextStyle(
                                      color: const Color(0xFF9E9E9E), // 색상 변경
                                      fontSize: 19,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 12),

                              // 배송 정보
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                textBaseline: TextBaseline.alphabetic,
                                children: [
                                  Text(
                                    '예상배송일',
                                    style: TextStyle(
                                      color: const Color(0xFF333333), // 색상 변경
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFE0E0E0), // 배경색 변경
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Text(
                                      widget.product.formattedDeliveryDate,
                                      style: TextStyle(
                                        color: const Color(
                                          0xFFFBC02D,
                                        ), // 배송일 색상
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        // 두 번째 구분선
                        Divider(
                          color: const Color(0xFFE0E0E0), // 구분선 색상 변경
                          thickness: 1,
                          height: 1,
                          indent: 0,
                          endIndent: 0,
                        ),

                        // 제품 설명 섹션
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 16,
                          ),
                          child: Text(
                            widget.product.description,
                            style: TextStyle(
                              color: const Color(0xFF333333), // 색상 변경
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                              height: 1.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            // 하단바
            AnimatedBuilder(
              animation: _bottomBarAnimation!,
              builder: (context, child) {
                return Positioned(
                  bottom:
                      _bottomBarAnimation!.value * -10 -
                      (1 - _bottomBarAnimation!.value) * 200,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F5F5), // 배경색 변경
                      border: Border(
                        top: BorderSide(
                          color: const Color(0xFFE0E0E0),
                          width: 1,
                        ), // 구분선 색상 변경
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            // 수량 선택기
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: const Color(
                                    0xFFE0E0E0,
                                  ), // 입력 필드 구분선 색상 변경
                                ),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Row(
                                children: [
                                  IconButton(
                                    onPressed: _quantity > 1
                                        ? _decrement
                                        : null,
                                    icon: Icon(
                                      Icons.remove,
                                      size: 24,
                                      color: _quantity > 1
                                          ? const Color(0xFF9E9E9E) // 색상 변경
                                          : const Color(0xFFB0B0B0), // 비활성화 색상
                                    ),
                                    constraints: const BoxConstraints(
                                      minWidth: 36,
                                      minHeight: 36,
                                    ),
                                  ),
                                  Text(
                                    '$_quantity',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xFF333333), // 색상 변경
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: _quantity < 99
                                        ? _increment
                                        : null,
                                    icon: Icon(
                                      Icons.add,
                                      size: 24,
                                      color: _quantity < 99
                                          ? const Color(0xFF333333) // 색상 변경
                                          : const Color(0xFFB0B0B0), // 비활성화 색상
                                    ),
                                    constraints: const BoxConstraints(
                                      minWidth: 36,
                                      minHeight: 36,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),
                            // 총 가격
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  '총 가격',
                                  style: TextStyle(
                                    color: const Color(0xFF9E9E9E), // 색상 변경
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  PriceFormatter.format(totalPrice),
                                  style: TextStyle(
                                    color: const Color(0xFFFBC02D), // 총 가격 색상
                                    fontSize: 22,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        // 액션 버튼들
                        Row(
                          children: [
                            // 장바구니 담기 버튼
                            Expanded(
                              child: ElevatedButton(
                                onPressed: _addToCart,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: const Color(
                                    0xFFFBC02D,
                                  ), // 버튼 색상
                                  elevation: 0,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                    side: BorderSide(
                                      color: const Color(0xFFFBC02D), // 버튼 색상
                                      width: 1,
                                    ),
                                  ),
                                ),
                                child: Text(
                                  '장바구니 담기',
                                  style: TextStyle(
                                    color: const Color(0xFFFBC02D), // 버튼 색상
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            // 바로 구매하기 버튼
                            Expanded(
                              child: ElevatedButton(
                                onPressed: _buyNow,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(
                                    0xFFFBC02D,
                                  ), // 버튼 색상
                                  foregroundColor: Colors.white,
                                  elevation: 0,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                ),
                                child: Text(
                                  '바로 구매하기',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
