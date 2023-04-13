import 'package:flutter/material.dart';

class Tasbih extends StatefulWidget {
  const Tasbih({Key? key}) : super(key: key);

  @override
  _TasbihState createState() => _TasbihState();
}

class _TasbihState extends State<Tasbih> {
  int _count = 0;
  int _maxCount = 100;

  void _incrementCount() {
    if (_count < _maxCount) {
      setState(() {
        _count++;
      });
    }
  }

  void _resetCount() {
    setState(() {
      _count = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tasbih'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: _incrementCount,
              child: Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  '$_count',
                  style: TextStyle(fontSize: 32.0, color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'سُبْحَانَ اللهِ',
              style: TextStyle(fontSize: 24.0),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _resetCount,
              child: Text('Reset'),
            ),
          ],
        ),
      ),
    );
  }
}
