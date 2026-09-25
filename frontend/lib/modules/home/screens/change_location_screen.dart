import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../cart/controllers/cart_controller.dart';
import '../controllers/home_controller.dart';

class ChangeLocationScreen extends StatefulWidget {
  const ChangeLocationScreen({super.key});

  @override
  State<ChangeLocationScreen> createState() => _ChangeLocationScreenState();
}

class _ChangeLocationScreenState extends State<ChangeLocationScreen> {
  String? _selectedCity;
  final TextEditingController _citySearchController = TextEditingController();
  final TextEditingController _areaSearchController = TextEditingController();

  final List<Map<String, dynamic>> _cities = [
    {'name': 'Gurgaon', 'icon': Icons.apartment_rounded},
    {'name': 'New Delhi', 'icon': Icons.account_balance_rounded},
    {'name': 'Bangalore', 'icon': Icons.domain_rounded},
    {'name': 'Hyderabad', 'icon': Icons.mosque_rounded},
    {'name': 'Mumbai', 'icon': Icons.location_city_rounded},
    {'name': 'Pune', 'icon': Icons.temple_hindu_rounded},
    {'name': 'Kolkata', 'icon': Icons.nature_people_rounded},
    {'name': 'Buxar', 'icon': Icons.home_work_rounded},
    {'name': 'Patna', 'icon': Icons.location_on_rounded},
  ];

  final Map<String, List<String>> _cityAreas = {
    'Kolkata': ['Park Street', 'Salt Lake Sector V', 'New Town', 'Ballygunge', 'Howrah Station Area'],
    'Gurgaon': ['Cyber City Phase 2', 'Golf Course Road', 'Sohna Road', 'DLF Phase 4', 'Sector 56'],
    'New Delhi': ['Connaught Place', 'Hauz Khas', 'Saket', 'Vasant Kunj', 'Dwarka Sector 10'],
    'Bangalore': ['Indiranagar', 'Koramangala 4th Block', 'HSR Layout', 'Whitefield', 'Electronic City'],
    'Mumbai': ['Bandra West', 'Andheri East', 'Colaba', 'Juhu Tara Road', 'Powai Hiranandani'],
    'Buxar': ['Station Road', 'Civil Lines', 'Golambar', 'Charitravan', 'Nai Basti'],
    'Patna': ['Bailey Road', 'Boring Road', 'Kankarbagh', 'Patliputra Colony', 'Rajendra Nagar'],
  };

  @override
  void dispose() {
    _citySearchController.dispose();
    _areaSearchController.dispose();
    super.dispose();
  }

  void _onSelectLocation(String locationName) {
    if (Get.isRegistered<CartController>()) {
      CartController.to.selectedAddress.value = locationName;
    }
    if (Get.isRegistered<HomeController>()) {
      final homeController = Get.find<HomeController>();
      final cityName = _selectedCity ?? locationName.split(',').first.trim();
      homeController.selectedCity.value = cityName;
      homeController.selectedLocality.value = locationName;
    }
    Get.back();
    Get.rawSnackbar(
      messageText: Text(
        'Delivery location set to $locationName',
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
      ),
      backgroundColor: const Color(0xFF16A34A),
      borderRadius: 8,
      margin: const EdgeInsets.all(16),
      icon: const Icon(Icons.check_circle_outline_rounded, color: Colors.white),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredCities = _cities.where((c) {
      final q = _citySearchController.text.trim().toLowerCase();
      return q.isEmpty || (c['name'] as String).toLowerCase().contains(q);
    }).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: const Icon(Icons.arrow_back, size: 20, color: Color(0xFF0F172A)),
            ),
          ),
        ),
        title: const Text(
          'Change delivery location',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w800,
            color: Color(0xFF0F172A),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Purple Hero Banner (Screenshots 1 & 3)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF5B4DE3), Color(0xFF6D5DFC)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Center(
                child: Text(
                  _selectedCity == null
                      ? 'Search for your city'
                      : 'Medicines delivered in minutes,\nnow available in your city!',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    height: 1.3,
                  ),
                ),
              ),
            ),

            // Stepper / City Selection Container (Screenshots 1 & 3)
            Transform.translate(
              offset: const Offset(0, -18),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: _selectedCity == null
                    ? _buildStep1CityInput()
                    : _buildStep2AreaInput(),
              ),
            ),

            // "Use your current location" Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: InkWell(
                onTap: () => _onSelectLocation('Current Location (Buxar)'),
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFEE2E2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.gps_fixed_rounded,
                          size: 20,
                          color: Color(0xFFFF5247),
                        ),
                      ),
                      const SizedBox(width: 14),
                      const Text(
                        'Use your current location',
                        style: TextStyle(
                          fontSize: 14.5,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFFFF5247),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Cities List or Area Suggestions
            if (_selectedCity == null) ...[
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Cities',
                  style: TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF64748B),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: filteredCities.length,
                separatorBuilder: (context, index) => const Divider(
                  height: 1,
                  color: Color(0xFFF1F5F9),
                  indent: 68,
                ),
                itemBuilder: (context, index) {
                  final city = filteredCities[index];
                  final cityName = city['name'] as String;
                  return InkWell(
                    onTap: () {
                      setState(() {
                        _selectedCity = cityName;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      child: Row(
                        children: [
                          // 3D Soft Peach Landmark Tile
                          Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFF1F2),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: const Color(0xFFFFE4E6)),
                            ),
                            child: Icon(
                              city['icon'] as IconData,
                              size: 24,
                              color: const Color(0xFFF43F5E),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              cityName,
                              style: const TextStyle(
                                fontSize: 14.5,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF0F172A),
                              ),
                            ),
                          ),
                          const Icon(Icons.chevron_right_rounded, size: 20, color: Color(0xFF94A3B8)),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ] else ...[
              // Area Suggestions for Selected City
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Popular areas in $_selectedCity',
                  style: const TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF64748B),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              ...(_cityAreas[_selectedCity] ?? ['Main Market', 'Station Road', 'City Center']).map((area) {
                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  leading: const Icon(Icons.location_pin, color: Color(0xFF16A34A)),
                  title: Text(area, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
                  subtitle: Text('$_selectedCity, India', style: const TextStyle(fontSize: 12, color: Color(0xFF64748B))),
                  trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: Color(0xFF94A3B8)),
                  onTap: () => _onSelectLocation('$area, $_selectedCity'),
                );
              }),
            ],

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // Step 1: City Search Input (Screenshot 1)
  Widget _buildStep1CityInput() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
      child: Row(
        children: [
          // Pin icon with "1" inside
          Stack(
            alignment: Alignment.center,
            children: const [
              Icon(Icons.location_on, size: 26, color: Color(0xFF0F172A)),
              Positioned(
                top: 4,
                child: Text(
                  '1',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: _citySearchController,
              onChanged: (_) => setState(() {}),
              decoration: const InputDecoration(
                hintText: 'Search for your city',
                hintStyle: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF94A3B8),
                  fontWeight: FontWeight.w500,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Step 2: City Selected + Delivery Area Input (Screenshot 3)
  Widget _buildStep2AreaInput() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Step 1: Selected City
          GestureDetector(
            onTap: () {
              setState(() {
                _selectedCity = null;
              });
            },
            child: Row(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: const [
                    Icon(Icons.location_on, size: 24, color: Color(0xFF0F172A)),
                    Positioned(
                      top: 4,
                      child: Text(
                        '1',
                        style: TextStyle(color: Colors.white, fontSize: 8.5, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 12),
                Text(
                  _selectedCity!,
                  style: const TextStyle(
                    fontSize: 14.5,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF0F172A),
                  ),
                ),
                const Spacer(),
                const Text(
                  'Change',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFFFF5247),
                  ),
                ),
              ],
            ),
          ),

          // Dotted Vertical Line
          Padding(
            padding: const EdgeInsets.only(left: 11, top: 4, bottom: 4),
            child: SizedBox(
              height: 18,
              child: CustomPaint(
                painter: _VerticalDottedPainter(),
              ),
            ),
          ),

          // Step 2: Delivery Area Search Input
          Row(
            children: [
              Stack(
                alignment: Alignment.center,
                children: const [
                  Icon(Icons.location_on, size: 24, color: Color(0xFF0D9488)),
                  Positioned(
                    top: 4,
                    child: Text(
                      '2',
                      style: TextStyle(color: Colors.white, fontSize: 8.5, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextField(
                  controller: _areaSearchController,
                  autofocus: true,
                  onSubmitted: (val) {
                    if (val.trim().isNotEmpty) {
                      _onSelectLocation('$val, $_selectedCity');
                    }
                  },
                  decoration: const InputDecoration(
                    hintText: 'Search for your delivery area',
                    hintStyle: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF94A3B8),
                      fontWeight: FontWeight.w500,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Hint Pill underneath
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFF0FDF4),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: const Color(0xFFDCFCE7)),
            ),
            child: RichText(
              text: const TextSpan(
                style: TextStyle(fontSize: 11.5, color: Color(0xFF166534)),
                children: [
                  TextSpan(text: 'Your delivery area can be a '),
                  TextSpan(text: 'building name, locality, landmark, street name', style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: ' etc.'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _VerticalDottedPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF94A3B8)
      ..strokeWidth = 1.5;

    double startY = 0;
    while (startY < size.height) {
      canvas.drawLine(Offset(0, startY), Offset(0, startY + 3), paint);
      startY += 6;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
