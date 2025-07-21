import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:today_s_farm/providers/cart_provider.dart';
import 'package:today_s_farm/models/product_model.dart';
import 'package:today_s_farm/utils/price_formatter.dart';
import 'package:today_s_farm/constants/app_colors.dart';
import 'package:today_s_farm/utils/star_icon_formatter.dart';
import 'package:today_s_farm/pages/cart/cart_page.dart';
import 'package:today_s_farm/pages/detail/widgets/cart_dialog.dart';
import 'package:today_s_farm/pages/detail/widgets/bottom_bar.dart';
import 'package:today_s_farm/pages/detail/widgets/farmer_info/farmer_info.dart';
import 'package:today_s_farm/pages/detail/widgets/product_info/product_info_section.dart';

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

  @override
  Widget build(BuildContext context) {
    final totalPrice = widget.product.price * _quantity;

    return Scaffold(
      backgroundColor: Colors.white, // 배경색 - 흰색
      appBar: AppBar(
        backgroundColor: Colors.white, // 배경색 - 흰색
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.textPrimary), // 색상 변경
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
              color: AppColors.textPrimary, // 색상 변경
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
                          color: Colors.white, // 배경색 - 흰색
                          child: widget.product.imageUrl != null
                              ? Image.asset(
                                  widget.product.imageUrl!,
                                  width: double.infinity,
                                  fit: BoxFit.fitWidth,
                                  errorBuilder: (_, __, ___) => Container(
                                    color: Colors.white, // 배경색 - 흰색
                                    height:
                                        MediaQuery.of(context).size.height *
                                        0.6,
                                    child: Icon(
                                      Icons.image,
                                      size: 60,
                                      color: AppColors.textSecondary, // 색상 변경
                                    ),
                                  ),
                                )
                              : Container(
                                  color: Colors.white, // 배경색 - 흰색
                                  height:
                                      MediaQuery.of(context).size.height * 0.6,
                                  child: Icon(
                                    Icons.image,
                                    size: 60,
                                    color: AppColors.textSecondary, // 색상 변경
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
                              FarmerInfo(product: widget.product),
                            ],
                          ),
                        ),

                        // 첫 번째 구분선
                        Divider(
                          color: AppColors.divider, // 구분선 색상 변경
                          thickness: 1,
                          height: 1,
                          indent: 0,
                          endIndent: 0,
                        ),

                        // 제품명과 가격 정보 섹션
                        ProductInfoSection(product: widget.product),

                        // 두 번째 구분선
                        Divider(
                          color: AppColors.divider, // 구분선 색상 변경
                          thickness: 1,
                          height: 1,
                          indent: 0,
                          endIndent: 0,
                        ),

                        // 제품 설명 섹션
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.product.description,
                                style: TextStyle(
                                  color: AppColors.textPrimary, // 색상 변경
                                  fontSize: 17,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // 바텀바 공간 확보
                        const SizedBox(height: 200),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            // 하단바
            BottomBar(
              product: widget.product,
              quantity: _quantity,
              onIncrement: _increment,
              onDecrement: _decrement,
              onAddToCart: _addToCart,
              onBuyNow: _buyNow,
              animation: _bottomBarAnimation,
            ),
          ],
        ),
      ),
    );
  }
}
