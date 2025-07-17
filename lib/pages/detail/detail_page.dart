import 'package:flutter/material.dart';

/// [DetailPage]는 상품 상세 정보와 구매 기능을 제공합니다.
///
/// 수행할 체크리스트:
/// - [x] 상단바: 뒤로가기 버튼과 Title (BackButton 이용, Navigator.pop)
/// - [x] 상품 상세 페이지: 상품 이미지, 이름·가격, 설명 (스크롤 가능)
/// - [x] 구매하기 영역:
///    - [x] -, + 버튼으로 수량 조절 (1~99)
///    - [x] 수량 변경 시 총 가격 갱신
///    - [x] 구매하기 버튼 클릭 시 확인/완료 팝업
///    - [x] 취소 시 팝업 닫기, 확인 시 '구매 완료' 팝업 표시 및 닫기
class DetailPage extends StatefulWidget {
  final String title;
  final String description;
  final String? imageUrl;
  final int price;

  const DetailPage({
    Key? key,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.price,
  }) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int _quantity = 1;

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

  Future<void> _purchase() async {
    // 확인 팝업
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        content: Text('${widget.title}을 $_quantity개 구매하시겠습니까?'),
        actions: [
          TextButton(
            child: const Text('취소'),
            onPressed: () => Navigator.pop(context, false), // [x]
          ),
          TextButton(
            child: const Text('확인'),
            onPressed: () => Navigator.pop(context, true), // [x]
          ),
        ],
      ),
    );

    if (confirm == true) {
      // 구매 완료 팝업
      await showDialog(
        context: context,
        builder: (_) => AlertDialog(
          content: const Text('구매 완료'),
          actions: [
            TextButton(
              child: const Text('확인'),
              onPressed: () => Navigator.pop(context), // [x]
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final totalPrice = widget.price * _quantity;

    return Scaffold(
      // ------------------- 상단바 -------------------
      appBar: AppBar(
        leading: BackButton(
          onPressed: () => Navigator.pop(context), // 이전 페이지로 이동 [x]
        ),
        title: Text(widget.title), // Title 표시 [x]
        centerTitle: true,
      ),

      // ------------------- 본문 -------------------
      body: Column(
        children: [
          // 상품 이미지 큰 화면 [x]
          widget.imageUrl != null
              ? Image.network(
                  widget.imageUrl!,
                  width: double.infinity,
                  height: 250,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    color: Colors.grey.shade300,
                    width: double.infinity,
                    height: 250,
                    child: const Center(child: Text('Image')),
                  ),
                )
              : Container(
                  color: Colors.grey.shade300,
                  width: double.infinity,
                  height: 250,
                  child: const Center(child: Text('No Image')),
                ),
          const SizedBox(height: 16),

          // 상품 이름 & 가격 [x]
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.title, style: const TextStyle(fontSize: 18)),
                Text(
                  '${widget.price.toString().replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (m) => ',')}원',
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // 상품 설명 스크롤 가능 [x]
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SingleChildScrollView(
                child: Text(
                  widget.description,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          ),
        ],
      ),

      // ------------------- 구매하기 영역 -------------------
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Colors.grey.shade300)),
        ),
        child: Row(
          children: [
            // 수량 감소 버튼 [-] [x]
            IconButton(onPressed: _decrement, icon: const Icon(Icons.remove)),
            // 현재 수량 표시 [x]
            Text('$_quantity', style: const TextStyle(fontSize: 16)),
            // 수량 증가 버튼 [+] [x]
            IconButton(onPressed: _increment, icon: const Icon(Icons.add)),

            const Spacer(),

            // 총 가격 표시 [x]
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text('총 가격', style: TextStyle(fontSize: 14)),
                Text(
                  '${totalPrice.toString().replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (m) => ',')}원',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(width: 16),

            // 구매하기 버튼 [x]
            ElevatedButton(onPressed: _purchase, child: const Text('구매하기')),
          ],
        ),
      ),
    );
  }
}
