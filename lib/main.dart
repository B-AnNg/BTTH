import 'package:flutter/material.dart';
import 'dart:math';
//import 'bai3.dart' as bt3;
//import 'bai4.dart' as bt4;
//import 'bai5.dart' as bt5;
import 'bai6.dart' as bt6;

void main() {
  //runApp(const CalculatorApp());
  //bt3.main();
  //bt4.main();
  //bt5.main();
  bt6.main();
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _displayValue = '0'; // Số đang nhập ở màn hình dưới
  String _historyValue = '';  // Chuỗi hiển thị toàn bộ lịch sử phía trên (VD: 5 × 5 +)
  
  // Lưu danh sách các số và toán tử để xử lý đúng thứ tự ưu tiên (Nhân/Chia trước, Cộng/Trừ sau)
  List<String> _tokens = []; 

  void _onButtonPressed(String label) {
    setState(() {
      switch (label) {
        case 'C':
          _displayValue = '0';
          _historyValue = '';
          _tokens.clear();
          break;
        case 'CE':
          _displayValue = '0';
          break;
        case '⌫':
          if (_displayValue.length > 1) {
            _displayValue = _displayValue.substring(0, _displayValue.length - 1);
          } else {
            _displayValue = '0';
          }
          break;
        case '+':
        case '-':
        case '×':
        case '÷':
          if (_historyValue.endsWith('=')) {
            _historyValue = '$_displayValue $label';
            _tokens = [_displayValue, label];
          } else {
            _tokens.add(_displayValue);
            _tokens.add(label);
            _historyValue = _tokens.join(' ');
          }
          _displayValue = '0';
          break;
        case '=':
          if (_tokens.isNotEmpty && !_historyValue.endsWith('=')) {
            _tokens.add(_displayValue);
            _historyValue = '${_tokens.join(' ')} =';
            double result = _evaluateExpression(_tokens);
            _displayValue = _formatNumber(result);
            _tokens = [_displayValue]; // Lưu lại kết quả để tính tiếp nếu muốn
          }
          break;
        case '%':
        case '¹/x':
        case 'x²':
        case '²√x':
          _handleAdvanced(label);
          break;
        case '+/-':
          if (_displayValue != '0' && _displayValue != 'Error') {
            if (_displayValue.startsWith('-')) {
              _displayValue = _displayValue.substring(1);
            } else {
              _displayValue = '-$_displayValue';
            }
          }
          break;
        case '.':
          if (_historyValue.endsWith('=')) {
            _historyValue = '';
            _displayValue = '0.';
            _tokens.clear();
          } else if (!_displayValue.contains('.')) {
            _displayValue += '.';
          }
          break;
        default: // Nhập số (0-9)
          if (_historyValue.endsWith('=')) {
            _historyValue = '';
            _displayValue = label;
            _tokens.clear();
          } else if (_displayValue == '0') {
            _displayValue = label;
          } else {
            _displayValue += label;
          }
      }
    });
  }

  // Thuật toán tính toán chuẩn ưu tiên Nhân/Chia trước, Cộng/Trừ sau
  double _evaluateExpression(List<String> tokens) {
    if (tokens.isEmpty) return 0;
    List<dynamic> list = [];
    for (var t in tokens) {
      if (double.tryParse(t) != null) {
        list.add(double.parse(t));
      } else {
        list.add(t);
      }
    }

    // Bước 1: Xử lý nhân, chia trước
    for (int i = 0; i < list.length; i++) {
      if (list[i] == '×' || list[i] == '÷') {
        double prev = list[i - 1];
        double next = list[i + 1];
        double res = (list[i] == '×') ? (prev * next) : (next == 0 ? 0 : prev / next);
        
        list[i - 1] = res;
        list.removeAt(i); // xóa toán tử
        list.removeAt(i); // xóa số tiếp theo
        i--;
      }
    }

    // Bước 2: Xử lý cộng, trừ sau
    double result = list[0];
    for (int i = 1; i < list.length; i += 2) {
      String op = list[i];
      double nextVal = list[i + 1];
      if (op == '+') result += nextVal;
      if (op == '-') result -= nextVal;
    }

    return result;
  }

  void _handleAdvanced(String label) {
    double val = double.tryParse(_displayValue) ?? 0;
    double res = val;
    if (label == '%') res = val / 100;
    if (label == 'x²') res = val * val;
    if (label == '¹/x') res = val == 0 ? 0 : 1 / val;
    if (label == '²√x') res = val < 0 ? 0 : sqrt(val);

    _displayValue = _formatNumber(res);
  }

  String _formatNumber(double num) {
    if (num == num.toInt()) {
      return num.toInt().toString();
    }
    return num.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF3F3F3),
        elevation: 0,
        title: const Row(
          children: [
            Text(
              'Standard',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            SizedBox(width: 8),
            Icon(Icons.open_in_full, size: 16, color: Colors.black54),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.history, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Color(0xFFF3F3F3)),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text('Calculator', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey)),
              ),
            ),
            _buildDrawerItem(Icons.calculate, 'Standard', isSelected: true),
            _buildDrawerItem(Icons.science_outlined, 'Scientific'),
            _buildDrawerItem(Icons.show_chart, 'Graphing'),
            _buildDrawerItem(Icons.code, 'Programmer'),
            _buildDrawerItem(Icons.calendar_today, 'Date calculation'),
            const Divider(),
            const Padding(
              padding: EdgeInsets.only(left: 16, top: 8, bottom: 4),
              child: Text('Converter', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey)),
            ),
            _buildDrawerItem(Icons.attach_money, 'Currency'),
            _buildDrawerItem(Icons.view_in_ar, 'Volume'),
            _buildDrawerItem(Icons.straighten, 'Length'),
            _buildDrawerItem(Icons.fitness_center, 'Weight and mass'),
            _buildDrawerItem(Icons.thermostat, 'Temperature'),
            _buildDrawerItem(Icons.flash_on, 'Energy'),
            _buildDrawerItem(Icons.grid_on, 'Area'),
            _buildDrawerItem(Icons.speed, 'Speed'),
            const Divider(),
            _buildDrawerItem(Icons.settings_outlined, 'Settings'),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              alignment: Alignment.bottomRight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    _historyValue,
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _displayValue,
                    style: const TextStyle(fontSize: 56, fontWeight: FontWeight.w300, color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildMemoryButton('MC'),
                _buildMemoryButton('MR'),
                _buildMemoryButton('M+'),
                _buildMemoryButton('M-'),
                _buildMemoryButton('MS'),
                _buildMemoryButton('M~'),
              ],
            ),
          ),
          const SizedBox(height: 4),
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.all(4),
              child: Column(
                children: [
                  _buildButtonRow(['%', 'CE', 'C', '⌫']),
                  _buildButtonRow(['¹/x', 'x²', '²√x', '÷']),
                  _buildButtonRow(['7', '8', '9', '×']),
                  _buildButtonRow(['4', '5', '6', '-']),
                  _buildButtonRow(['1', '2', '3', '+']),
                  _buildButtonRow(['+/-', '0', '.', '=']),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, {bool isSelected = false}) {
    return ListTile(
      leading: Icon(icon, color: isSelected ? Colors.blue : Colors.black87),
      title: Text(
        title,
        style: TextStyle(fontWeight: isSelected ? FontWeight.bold : FontWeight.normal, color: isSelected ? Colors.blue : Colors.black87),
      ),
      onTap: () => Navigator.pop(context),
    );
  }

  Widget _buildMemoryButton(String text) {
    return TextButton(
      onPressed: () {},
      style: TextButton.styleFrom(minimumSize: const Size(40, 30), padding: EdgeInsets.zero),
      child: Text(text, style: const TextStyle(fontSize: 12, color: Colors.grey)),
    );
  }

  Widget _buildButtonRow(List<String> labels) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: labels.map((label) {
          final isEquals = label == '=';
          return Expanded(
            child: Container(
              margin: const EdgeInsets.all(2),
              child: ElevatedButton(
                onPressed: () => _onButtonPressed(label),
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: isEquals ? const Color(0xFF0067C0) : const Color(0xFFF9F9F9),
                  foregroundColor: isEquals ? Colors.white : Colors.black,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                  padding: EdgeInsets.zero,
                ),
                child: Text(
                  label,
                  style: TextStyle(fontSize: 18, fontWeight: isEquals ? FontWeight.bold : FontWeight.normal),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}