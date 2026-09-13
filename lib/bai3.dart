import 'package:flutter/material.dart';

void main() {
  runApp(const MoodApp());
}

class MoodApp extends StatelessWidget {
  const MoodApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mental Health UI',
      debugShowCheckedModeBanner: false,
      home: const MoodScreen(),
    );
  }
}

class MoodScreen extends StatefulWidget {
  const MoodScreen({super.key});

  @override
  State<MoodScreen> createState() => _MoodScreenState();
}

class _MoodScreenState extends State<MoodScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2373F2), // Màu xanh dương đặc trưng của giao diện mẫu
      body: SafeArea(
        child: Column(
          children: [
            // --- 1. HEADER: LỜI CHÀO VÀ NÚT THÔNG BÁO ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Hi, Jared!',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        '23 Jan, 2021',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.notifications, color: Colors.white),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),

            // --- 2. THANH TÌM KIẾM (SEARCH BAR) ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: const Color(0xFF1B5EC4), // Xanh đậm hơn chút cho thanh tìm kiếm
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const TextField(
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    icon: Icon(Icons.search, color: Colors.white70),
                    hintText: 'Search',
                    hintStyle: TextStyle(color: Colors.white70),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // --- 3. CÂU HỎI TÂM TRẠNG & CÁC NÚT CẢM XÚC ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'How do you feel?',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Icon(Icons.more_horiz, color: Colors.white70),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  MoodCard(emoji: '😞', label: 'Bad'),
                  MoodCard(emoji: '🙁', label: 'Fine'),
                  MoodCard(emoji: '😊', label: 'Well'),
                  MoodCard(emoji: '😁', label: 'Excellent'),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // --- 4. KHUNG TRẮNG CHỨA DANH SÁCH BÀI TẬP (EXERCISES) ---
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Color(0xFFF3F4F6), // Màu nền xám nhạt hiện đại
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'Exercises',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        Icon(Icons.more_horiz, color: Colors.black54),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: ListView(
                        children: const [
                          ExerciseCard(
                            backgroundColor: Colors.orange,
                            icon: Icons.favorite,
                            title: 'Speaking Skillz',
                            subtitle: '16 Exercises',
                          ),
                          SizedBox(height: 12),
                          ExerciseCard(
                            backgroundColor: Colors.green,
                            icon: Icons.person,
                            title: 'Reading Skills',
                            subtitle: '8 Exercises',
                          ),
                          SizedBox(height: 12),
                          ExerciseCard(
                            backgroundColor: Colors.pink,
                            icon: Icons.star,
                            title: 'Writing Skills',
                            subtitle: '20 Exercises',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      // --- 5. THANH ĐIỀU HƯỚNG DƯỚI CÙNG (BOTTOM NAVIGATION BAR) ---
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), label: 'Chat'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
    );
  }
}

// Widget phụ trợ cho mục Cảm xúc
class MoodCard extends StatelessWidget {
  final String emoji;
  final String label;

  const MoodCard({super.key, required this.emoji, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: const Color(0xFF1B5EC4),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            emoji,
            style: const TextStyle(fontSize: 24),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

// Widget phụ trợ cho thẻ bài tập (Exercise Card)
class ExerciseCard extends StatelessWidget {
  final Color backgroundColor;
  final IconData icon;
  final String title;
  final String subtitle;

  const ExerciseCard({
    super.key,
    required this.backgroundColor,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.04),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: Colors.white),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.more_horiz, color: Colors.grey),
        ],
      ),
    );
  }
}