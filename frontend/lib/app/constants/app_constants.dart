class AppConstants {
  static const String appName = 'JeevanCare';
  static const String appTagline = 'Your Trusted Health Companion';
  static const String currencySymbol = '₹';
  
  // Default delivery address
  static const String defaultCity = 'Buxar';
  static const String defaultLocality = 'Station Road, Buxar - 802101';

  // API Config (Backend-ready)
  static const String baseApiUrl = 'https://api.jeevancare.in/v1';
  static const int connectTimeoutMs = 15000;
  static const int receiveTimeoutMs = 15000;

  // Search Hint Texts (Rotating in home search bar)
  static const List<String> searchPlaceholders = [
    'Search medicines & health products',
    'Search weight management...',
    'Search skin care',
    'Search healthy snacks',
    'Search pet care',
    'Search oral care',
    'Search diabetes care',
  ];
}
