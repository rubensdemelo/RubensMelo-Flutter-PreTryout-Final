import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(EasyTips());

class EasyTips extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Easy Tips',
      home: EasyTipsHomePage(),
    );
  }
}

class EasyTipsHomePage extends StatefulWidget {
  EasyTipsHomePage({Key key}) : super(key: key);

  @override
  _EasyTipsHomePageState createState() => _EasyTipsHomePageState();
}

class _EasyTipsHomePageState extends State<EasyTipsHomePage> {
  final _billTextController = TextEditingController();
  double _bill = 0;
  double _tip = 15.0;
  double _tipAmount = 0;
  double _totalAmount = 0;

  void _calculateAmount() {
    setState(() {
      if (_bill != 0) {
        _tipAmount = _tip * _bill / 100;
        _totalAmount = _bill + _tipAmount;
      }
    });
  }

  void _incrementTip() {
    _tip += 1;
    _calculateAmount();
  }

  void _decrementTip() {
    _tip -= 1;
    _calculateAmount();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('EasyTips'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Bill',
              ),
              textAlign: TextAlign.center,
              controller: _billTextController,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              onChanged: (bill) {
                _bill = double.tryParse(bill);
                _calculateAmount();
              },
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Text('Tip %'),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                        icon: Icon(Icons.remove), onPressed: _decrementTip),
                    Text(_tip.ceil().toString()),
                    IconButton(icon: Icon(Icons.add), onPressed: _incrementTip),
                  ],
                ),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Tip Amount'),
                Text('\$ ${_tipAmount.toStringAsFixed(2)}'),
              ],
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total Amount'),
                Text('\$ ${_totalAmount.toStringAsFixed(2)}'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
