import 'package:flutter/material.dart';

void main() {
  runApp(const EWalletApp());
}

class EWalletApp extends StatelessWidget {
  const EWalletApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E-Wallet App',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        scaffoldBackgroundColor: const Color(0xFFF5F6F8),
      ),
      home: const WalletHomeScreen(),
    );
  }
}

class WalletHomeScreen extends StatefulWidget {
  const WalletHomeScreen({super.key});

  @override
  State<WalletHomeScreen> createState() => _WalletHomeScreenState();
}

class _WalletHomeScreenState extends State<WalletHomeScreen> {
  // Dữ liệu mô phỏng ví điện tử
  final double _balance = 5250.25;
  final String _cardNumber = "12345678";
  final String _expiryDate = "10/24";
  int _currentCardIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Header: My Cards & Add Button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: const TextSpan(
                      text: 'My ',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      children: [
                        TextSpan(
                          text: 'Cards',
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _showActionSnackBar(context, "Thêm thẻ mới (Add Card)"),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: Color(0xFFE4E7EB),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.add, color: Colors.black54, size: 20),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // 2. Card View (Màu tím đặc trưng)
              Container(
                width: double.infinity,
                height: 190,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF7C66DC),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF7C66DC).withOpacity(0.4),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Balance',
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                    Text(
                      '\$$_balance',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _cardNumber,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 16,
                            letterSpacing: 2,
                          ),
                        ),
                        Text(
                          _expiryDate,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),

              // Page Indicators (Dấu chấm chuyển thẻ)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(3, (index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: _currentCardIndex == index ? 16 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: _currentCardIndex == index ? Colors.black87 : Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 30),

              // 3. Quick Actions: Send, Pay, Bills
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildQuickActionButton(
                    context,
                    icon: Icons.send_rounded,
                    color: Colors.green,
                    label: 'Send',
                    onTap: () => _showActionDialog(context, 'Chức năng Gửi tiền (Send)'),
                  ),
                  _buildQuickActionButton(
                    context,
                    icon: Icons.payment_rounded,
                    color: Colors.blue,
                    label: 'Pay',
                    onTap: () => _showActionDialog(context, 'Chức năng Thanh toán (Pay)'),
                  ),
                  _buildQuickActionButton(
                    context,
                    icon: Icons.receipt_long_rounded,
                    color: Colors.orange,
                    label: 'Bills',
                    onTap: () => _showActionDialog(context, 'Chức năng Hóa đơn (Bills)'),
                  ),
                ],
              ),
              const SizedBox(height: 30),

              // 4. Menu Items: Statistics & Transactions
              _buildMenuItem(
                context,
                icon: Icons.bar_chart_rounded,
                iconColor: Colors.blue,
                title: 'Statistics',
                subtitle: 'Payment and Income',
                onTap: () => _showActionDialog(context, 'Mở trang Thống kê (Statistics)'),
              ),
              const SizedBox(height: 15),
              _buildMenuItem(
                context,
                icon: Icons.swap_horiz_rounded,
                iconColor: Colors.green,
                title: 'Transactions',
                subtitle: 'Transaction History',
                onTap: () => _showActionDialog(context, 'Mở trang Lịch sử giao dịch (Transactions)'),
              ),
            ],
          ),
        ),
      ),
      // Bottom Floating Action Button (Nút tròn có ký hiệu tiền tệ)
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFE91E63),
        onPressed: () => _showActionSnackBar(context, "Nút thao tác nhanh ví điện tử"),
        child: const Text(
          '\$',
          style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  // Widget tùy chỉnh nút chức năng nhanh (Send, Pay, Bills)
  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: iconColor, size: 24),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(color: Colors.grey.shade500, fontSize: 13),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        onTap: onTap,
      ),
    );
  }

  Widget _buildQuickActionButton(
    BuildContext context, {
    required IconData icon,
    required Color color,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w500, color: Colors.black87),
          ),
        ],
      ),
    );
  }

  // Hàm hiển thị thông báo tương tác mẫu
  void _showActionDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Thông báo chức năng'),
        content: Text('Đang xử lý: $message'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Đóng'),
          ),
        ],
      ),
    );
  }

  void _showActionSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 1)),
    );
  }
}