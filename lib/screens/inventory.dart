import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zoom/screens/user_model.dart';

class AddItemScreen extends StatefulWidget {
  final UserModel user;

  AddItemScreen({required this.user, Key? key}) : super(key: key);

  @override
  _AddItemScreenState createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  final TextEditingController _itemNameController = TextEditingController();
  final TextEditingController _stationeryController = TextEditingController();
  final TextEditingController _uniformsController = TextEditingController();
  final TextEditingController _pulsesController = TextEditingController();
  final TextEditingController _riceController = TextEditingController();
  final TextEditingController _vegetablesController = TextEditingController();
  final TextEditingController _wheatController = TextEditingController();

  void _addItem() async {
    final String itemName = _itemNameController.text.trim();
    final int stationery = int.parse(_stationeryController.text.trim());
    final int uniforms = int.parse(_uniformsController.text.trim());
    final int pulses = int.parse(_pulsesController.text.trim());
    final int rice = int.parse(_riceController.text.trim());
    final int vegetables = int.parse(_vegetablesController.text.trim());
    final int wheat = int.parse(_wheatController.text.trim());

    if (itemName.isNotEmpty) {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(widget.user.id)
          .collection('inventory')
          .add({
        'item_name': itemName,
        'stationery': stationery,
        'uniforms': uniforms,
        'pulses': pulses,
        'rice': rice,
        'vegetables': vegetables,
        'wheat': wheat,
      });

      // Clear the input fields after adding
      _itemNameController.clear();
      _stationeryController.clear();
      _uniformsController.clear();
      _pulsesController.clear();
      _riceController.clear();
      _vegetablesController.clear();
      _wheatController.clear();

      // Show a success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Item added successfully')),
      );
    } else {
      // Show an error message if item name is empty
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Item name cannot be empty')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Color(
                      0xFFD9D9D9) // This is the same as #D9D9D9 in ARGB format
                  ),
              child: TextField(
                controller: _itemNameController,
                decoration: InputDecoration(labelText: 'Item Name'),
              ),
            ),
            TextField(
              controller: _stationeryController,
              decoration: InputDecoration(labelText: 'Stationery'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _uniformsController,
              decoration: InputDecoration(labelText: 'Uniforms'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _pulsesController,
              decoration: InputDecoration(labelText: 'Pulses'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _riceController,
              decoration: InputDecoration(labelText: 'Rice'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _vegetablesController,
              decoration: InputDecoration(labelText: 'Vegetables'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _wheatController,
              decoration: InputDecoration(labelText: 'Wheat'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addItem,
              child: Text('Add Item'),
            ),
          ],
        ),
      ),
    );
  }
}
