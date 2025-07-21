class PriceFormatter {
  static String format(int price) {
    if (price == 0) return '무료';
    return '${price.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}원';
  }
}

class PriceFormatterWithOutUnit {
  static String format(int price) {
    if (price == 0) return '무료';
    return price.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );
  }
}
