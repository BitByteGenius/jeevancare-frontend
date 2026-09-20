import 'package:intl/intl.dart';
import '../../app/constants/app_constants.dart';

class Formatters {
  static final NumberFormat _currencyFormatter = NumberFormat.currency(
    symbol: AppConstants.currencySymbol,
    decimalDigits: 0,
    locale: 'en_IN',
  );

  static final NumberFormat _decimalCurrencyFormatter = NumberFormat.currency(
    symbol: AppConstants.currencySymbol,
    decimalDigits: 1,
    locale: 'en_IN',
  );

  static String formatCurrency(double amount) {
    if (amount % 1 == 0) {
      return _currencyFormatter.format(amount);
    }
    return _decimalCurrencyFormatter.format(amount);
  }

  static String formatDiscount(int percent) {
    return '$percent% off';
  }
}
