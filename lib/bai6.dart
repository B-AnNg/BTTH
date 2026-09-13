import 'package:flutter/material.dart';

void main() {
  runApp(const MusicPlayerApp());
}

class MusicPlayerApp extends StatelessWidget {
  const MusicPlayerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MusicPlayerScreen(),
    );
  }
}

class MusicPlayerScreen extends StatelessWidget {
  const MusicPlayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE4EBF5),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420), // Giới hạn khung chuẩn mobile
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  // 1. Thanh tiêu đề phía trên (Nút Back, Chữ PLAYLIST, Nút Menu)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildNeumorphicButton(icon: Icons.arrow_back),
                      const Text(
                        'PLAYLIST',
                        style: TextStyle(
                          letterSpacing: 2,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                          fontSize: 12,
                        ),
                      ),
                      _buildNeumorphicButton(icon: Icons.menu),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // 2. Thẻ chứa Album Art (Đã chèn anh1.jpg), Tên nghệ sĩ, Bài hát và Tim đỏ
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFE4EBF5),
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withOpacity(0.9),
                          offset: const Offset(-6, -6),
                          blurRadius: 16,
                        ),
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          offset: const Offset(6, 6),
                          blurRadius: 16,
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Hình ảnh album từ assets/images/anh1.jpg
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: SizedBox(
                            height: 240,
                            width: double.infinity,
                            child: Image.asset(
                              'assets/images/anh1.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Tên ca sĩ, bài hát và biểu tượng yêu thích
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  'Kota The Friend',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Birdie',
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const Icon(Icons.favorite, color: Colors.red, size: 26),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // 3. Thời gian và các nút Trộn bài (Shuffle), Lặp lại (Repeat)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text('0:00', style: TextStyle(color: Colors.grey, fontSize: 12)),
                      Icon(Icons.shuffle, color: Colors.grey, size: 18),
                      Icon(Icons.repeat, color: Colors.grey, size: 18),
                      Text('4:22', style: TextStyle(color: Colors.grey, fontSize: 12)),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // 4. Thanh tiến độ bài hát (Progress Bar màu xanh)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: 0.35,
                      backgroundColor: Colors.grey.shade300,
                      valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
                      minHeight: 6,
                    ),
                  ),
                  const Spacer(),

                  // 5. Các nút điều khiển phát nhạc (Previous, Play/Pause, Next)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildControlBoxButton(icon: Icons.skip_previous),
                      _buildControlBoxButton(icon: Icons.play_arrow, isLarge: true),
                      _buildControlBoxButton(icon: Icons.skip_next),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Widget tạo nút bấm bo góc nổi khối Neumorphism nhỏ ở thanh trên
  Widget _buildNeumorphicButton({required IconData icon}) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFE4EBF5),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.9),
            offset: const Offset(-4, -4),
            blurRadius: 10,
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(4, 4),
            blurRadius: 10,
          ),
        ],
      ),
      child: Icon(icon, color: Colors.black54, size: 18),
    );
  }

  // Widget tạo các nút điều khiển nhạc phía dưới với hiệu ứng khối nổi đẹp mắt
  Widget _buildControlBoxButton({required IconData icon, bool isLarge = false}) {
    return Container(
      padding: EdgeInsets.all(isLarge ? 20 : 16),
      decoration: BoxDecoration(
        color: const Color(0xFFE4EBF5),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.9),
            offset: const Offset(-6, -6),
            blurRadius: 12,
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(6, 6),
            blurRadius: 12,
          ),
        ],
      ),
      child: Icon(icon, color: Colors.black87, size: isLarge ? 32 : 24),
    );
  }
}