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
  final TextEditingController _stationeryController = TextEditingController();
  final TextEditingController _uniformsController = TextEditingController();
  final TextEditingController _pulsesController = TextEditingController();
  final TextEditingController _riceController = TextEditingController();
  final TextEditingController _vegetablesController = TextEditingController();
  final TextEditingController _wheatController = TextEditingController();

  Map<String, int> _quantities = {
    'stationery': 0,
    'uniforms': 0,
    'pulses': 0,
    'rice': 0,
    'vegetables': 0,
    'wheat': 0,
  };

  @override
  void initState() {
    super.initState();
    _fetchQuantities();
  }

  Future<void> _fetchQuantities() async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection('Users')
          .doc(widget.user.id)
          .collection('inventory')
          .doc('quantities')
          .get();

      if (doc.exists) {
        final data = doc.data();
        setState(() {
          _quantities = {
            'stationery': data?['stationery'] ?? 0,
            'uniforms': data?['uniforms'] ?? 0,
            'pulses': data?['pulses'] ?? 0,
            'rice': data?['rice'] ?? 0,
            'vegetables': data?['vegetables'] ?? 0,
            'wheat': data?['wheat'] ?? 0,
          };
        });
      } else {
        print('Quantities document does not exist');
      }
    } catch (e) {
      print('Error fetching quantities: $e');
    }
  }

  Future<void> _updateQuantities() async {
    Map<String, dynamic> updates = {};

    if (_stationeryController.text.trim().isNotEmpty) {
      updates['stationery'] = int.tryParse(_stationeryController.text.trim()) ?? _quantities['stationery'];
    }
    if (_uniformsController.text.trim().isNotEmpty) {
      updates['uniforms'] = int.tryParse(_uniformsController.text.trim()) ?? _quantities['uniforms'];
    }
    if (_pulsesController.text.trim().isNotEmpty) {
      updates['pulses'] = int.tryParse(_pulsesController.text.trim()) ?? _quantities['pulses'];
    }
    if (_riceController.text.trim().isNotEmpty) {
      updates['rice'] = int.tryParse(_riceController.text.trim()) ?? _quantities['rice'];
    }
    if (_vegetablesController.text.trim().isNotEmpty) {
      updates['vegetables'] = int.tryParse(_vegetablesController.text.trim()) ?? _quantities['vegetables'];
    }
    if (_wheatController.text.trim().isNotEmpty) {
      updates['wheat'] = int.tryParse(_wheatController.text.trim()) ?? _quantities['wheat'];
    }

    if (updates.isNotEmpty) {
      try {
        await FirebaseFirestore.instance
            .collection('Users')
            .doc(widget.user.id)
            .collection('inventory')
            .doc('quantities')
            .update(updates); // Use update to replace the existing values

        _stationeryController.clear();
        _uniformsController.clear();
        _pulsesController.clear();
        _riceController.clear();
        _vegetablesController.clear();
        _wheatController.clear();

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('मात्रा सफलतापूर्वक अपडेट की गई')),
        );

        _fetchQuantities();
      } catch (e) {
        print('Error updating quantities: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error updating quantities')),
        );
      }
    } else {
      // Show a message if no fields are updated
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No updates to apply')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color.fromRGBO(192, 119, 33, 1.0),
        title: const Text(
          'सामग्री जोड़ें',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildQuantityContainer(
                color: Color(0xFF34495E) ,
                weight: false,
                imagePath: "assets/boy-at-school-png-sale-boy-and-girl-boy-and-girl-500.png",
                label: "यूनिफार्म",
                controller: _uniformsController,
                quantity: _quantities['uniforms']!,
              ),
              _buildQuantityContainer(
                weight: true,
                color: Color(0xFFD9D9D9), 
                imagePath: "assets/rice-hd-png-rice-png-photos-1200.png",
                label: "चावल",
                controller: _riceController,
                quantity: _quantities['rice']!,
              ),
              _buildQuantityContainer(
                
                weight: true,
                color: Color(0xFF34495E),
                imagePath: "assets/flour-png-11553989035ynkldnd7ss.png",
                label: "आटा",
                controller: _wheatController,
                quantity: _quantities['wheat']!,
              ),
              _buildQuantityContainer(
                weight: true,
                color:Color(0xFFD9D9D9), 
                imagePath: "assets/purepng.com-vegetablespotatocarrotbowlvegetable-971524598571f93zl.png",
                label: "सब्जी",
                controller: _vegetablesController,
                quantity: _quantities['vegetables']!,
              ),
              _buildQuantityContainer(
                weight: false,
                color: Color(0xFFD9D9D9),
                imagePath: "assets/Clipart-paper-write-pen.png",
                label: "लेखन सामग्री",
                controller: _stationeryController,
                quantity: _quantities['stationery']!,
              ),
              _buildQuantityContainer(
                color: Color(0xFF34495E),
                weight: true,
                
                imagePath: "assets/pulses-2274.png",
                label: "दाल",
                controller: _pulsesController,
                quantity: _quantities['pulses']!,
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(192, 119, 33, 1.0),
                  ),
                  onPressed: _updateQuantities,
                  child: const Text(
                    'मात्रा अपडेट करें',
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuantityContainer({
    required Color color,
    required String imagePath,
    required String label,
    required TextEditingController controller,
    required int quantity,
    required bool weight,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  height: 70,
                  width: 70,
                  child: Image.asset(imagePath),
                ),
                weight
                    ? Text(
                        "$label ($quantity किलोग्राम)",
                        style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                      )
                    : Text(
                        "$label ($quantity)",
                        style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                      ),
              ],
            ),
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.only(left: 5),
                border: InputBorder.none,
              ),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
      ),
    );
  }
}
