import 'dart:io';

import 'package:flutter/material.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({Key? key}) : super(key: key);

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  int? _selectedMobileBanking;
  int? _selectedCard;

  File? _cardImage;

  void _handleMobileBankingChange(int? value) {
    setState(() {
      _selectedMobileBanking = value;
    });
  }

  void _handleCardChange(int? value) {
    setState(() {
      _selectedCard = value;
    });
  }

  void _handleImageUpload(File image) {
    setState(() {
      _cardImage = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Mobile Banking',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Radio<int>(
                  value: 0,
                  groupValue: _selectedMobileBanking,
                  onChanged: _handleMobileBankingChange,
                ),
                SizedBox(
                  width: 50, // Adjust the width as needed
                  height: 50, // Adjust the height as needed
                  child: Image.asset('assets/images/bkash.jpg'), // Image for Option 1
                ),
              ],
            ),
            Row(
              children: [
                Radio<int>(
                  value: 1,
                  groupValue: _selectedMobileBanking,
                  onChanged: _handleMobileBankingChange,
                ),
                SizedBox(
                  width: 50, // Adjust the width as needed
                  height: 50, // Adjust the height as needed
                  child: Image.asset('assets/images/rocket.png'), // Image for Option 2
                ),
              ],
            ),
            Row(
              children: [
                Radio<int>(
                  value: 2,
                  groupValue: _selectedMobileBanking,
                  onChanged: _handleMobileBankingChange,
                ),
                SizedBox(
                  width: 50, // Adjust the width as needed
                  height: 50, // Adjust the height as needed
                  child: Image.asset('assets/images/nogod.png'), // Image for Option 3
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Card',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Radio<int>(
                  value: 0,
                  groupValue: _selectedCard,
                  onChanged: _handleCardChange,
                ),
                SizedBox(
                  width: 50, // Adjust the width as needed
                  height: 50, // Adjust the height as needed
                  child: Image.asset('assets/images/paypal.png'), // Image for Card Option 1
                ),
              ],
            ),
            Row(
              children: [
                Radio<int>(
                  value: 1,
                  groupValue: _selectedCard,
                  onChanged: _handleCardChange,
                ),
                SizedBox(
                  width: 50, // Adjust the width as needed
                  height: 50, // Adjust the height as needed
                  child: Image.asset('assets/images/visa.jpg'), // Image for Card Option 2
                ),
              ],
            ),
            Row(
              children: [
                Radio<int>(
                  value: 2,
                  groupValue: _selectedCard,
                  onChanged: _handleCardChange,
                ),
                SizedBox(
                  width: 50, // Adjust the width as needed
                  height: 50, // Adjust the height as needed
                  child: Image.asset('assets/images/mastercard.webp'), // Image for Card Option 3
                ),
              ],
            ),
            Row(
              children: [
                Radio<int>(
                  value: 3,
                  groupValue: _selectedCard,
                  onChanged: _handleCardChange,
                ),
                SizedBox(
                  width: 50, // Adjust the width as needed
                  height: 50, // Adjust the height as needed
                  child: Image.asset('assets/images/americanexpress.jpg'), // Image for Card Option 4
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
