import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MedicalBookingScreen(),
    );
  }
}

class MedicalBookingScreen extends StatelessWidget {
  const MedicalBookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      // Bọc trong Center và ConstrainedBox để giả lập khung điện thoại trên màn hình rộng
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420), // Giới hạn chiều rộng chuẩn mobile
          child: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1. Header Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Hello,',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                          Text(
                            'Mitch Koko',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.person, color: Colors.black54),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // 2. Medical Card Banner
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFECEF),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                            color: const Color(0xFFC5B4F3),
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'How do you feel?',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                'Fill out your medical card right now',
                                style: TextStyle(fontSize: 12, color: Colors.grey),
                              ),
                              const SizedBox(height: 10),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF8A72F3),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 8,
                                  ),
                                ),
                                onPressed: () {},
                                child: const Text(
                                  'Get Started',
                                  style: TextStyle(color: Colors.white, fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // 3. Search Bar
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: const TextField(
                      decoration: InputDecoration(
                        icon: Icon(Icons.search, color: Colors.grey),
                        hintText: 'How can we help you?',
                        hintStyle: TextStyle(color: Colors.grey),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // 4. Categories Horizontal List
                  SizedBox(
                    height: 90,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        _buildCategoryCard('Dentist', Icons.medical_services_outlined),
                        _buildCategoryCard('Surgeon', Icons.local_hospital_outlined),
                        _buildCategoryCard('Cardio', Icons.favorite_outline),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // 5. Doctor List Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'Doctor list',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'See all',
                        style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // 6. Doctor Cards Horizontal List
                  SizedBox(
                    height: 210,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        _buildDoctorCard('Dr. Mitch Koko', 'Psychologist 7 y.e.', '4.4'),
                        const SizedBox(width: 16),
                        _buildDoctorCard('Dr. Steve Jobs', 'Surgeon 7 y.e.', '5.0'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryCard(String title, IconData icon) {
    return Container(
      width: 95,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: const Color(0xFF8A72F3), size: 30),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildDoctorCard(String name, String specialty, String rating) {
    return Container(
      width: 160,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircleAvatar(
            radius: 32,
            backgroundColor: Color(0xFFE0E0E0),
            child: Icon(Icons.person, size: 35, color: Colors.white),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.star, color: Colors.amber, size: 14),
              const SizedBox(width: 4),
              Text(rating, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            name,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 2),
          Text(
            specialty,
            style: const TextStyle(color: Colors.grey, fontSize: 10),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}