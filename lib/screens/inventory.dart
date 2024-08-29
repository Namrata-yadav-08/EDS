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

  Future<void> _addItem() async {
    final String itemName = _itemNameController.text.trim();
    final int stationery = int.tryParse(_stationeryController.text.trim()) ?? 0;
    final int uniforms = int.tryParse(_uniformsController.text.trim()) ?? 0;
    final int pulses = int.tryParse(_pulsesController.text.trim()) ?? 0;
    final int rice = int.tryParse(_riceController.text.trim()) ?? 0;
    final int vegetables = int.tryParse(_vegetablesController.text.trim()) ?? 0;
    final int wheat = int.tryParse(_wheatController.text.trim()) ?? 0;

    if (itemName.isNotEmpty) {
      try {
        // Add the new item
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

        // Update quantities
        await FirebaseFirestore.instance
            .collection('Users')
            .doc(widget.user.id)
            .collection('inventory')
            .doc('quantities')
            .set({
          'stationery': FieldValue.increment(stationery),
          'uniforms': FieldValue.increment(uniforms),
          'pulses': FieldValue.increment(pulses),
          'rice': FieldValue.increment(rice),
          'vegetables': FieldValue.increment(vegetables),
          'wheat': FieldValue.increment(wheat),
        }, SetOptions(merge: true)); // Use merge to update existing document or create it if not exists

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

        // Fetch the updated quantities
        _fetchQuantities();
      } catch (e) {
        print('Error adding item: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error adding item')),
        );
      }
    } else {
      // Show an error message if item name is empty
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Item name cannot be empty')),
      );
    }
  }

  Future<void> _updateQuantities() async {
    final int stationery = int.tryParse(_stationeryController.text.trim()) ?? 0;
    final int uniforms = int.tryParse(_uniformsController.text.trim()) ?? 0;
    final int pulses = int.tryParse(_pulsesController.text.trim()) ?? 0;
    final int rice = int.tryParse(_riceController.text.trim()) ?? 0;
    final int vegetables = int.tryParse(_vegetablesController.text.trim()) ?? 0;
    final int wheat = int.tryParse(_wheatController.text.trim()) ?? 0;

    try {
      // Update quantities
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(widget.user.id)
          .collection('inventory')
          .doc('quantities')
          .set({
        'stationery': stationery,
        'uniforms': uniforms,
        'pulses': pulses,
        'rice': rice,
        'vegetables': vegetables,
        'wheat': wheat,
      }, SetOptions(merge: true));
      

      
        _itemNameController.clear();
        _stationeryController.clear();
        _uniformsController.clear();
        _pulsesController.clear();
        _riceController.clear();
        _vegetablesController.clear();
        _wheatController.clear();
      // Show a success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Quantities updated successfully')),
      );

      // Fetch the updated quantities
      _fetchQuantities();
    } catch (e) {
      print('Error updating quantities: $e');
      ScaffoldMessenger.of(context).showSnackBar(
       const SnackBar(content: Text('Error updating quantities')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor:Color.fromRGBO(192, 119, 33, 1.0) ,
        title: const Text('सामग्री जोड़ें', style: TextStyle(fontSize: 20, color:Colors.white),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(15)
                    ),
                      color: Color(0xFFD9D9D9)),
                  child: TextField(
                    controller: _itemNameController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(10),
                      labelText: "सामग्री जोड़ें",hintStyle: TextStyle(fontSize: 15, color:Color.fromRGBO(192, 119, 33, 1.0), )),
                      
                  ),
                ),
              ),
              _buildQuantityContainer(
                weight: false,
                imagePath: "assets/boy-at-school-png-sale-boy-and-girl-boy-and-girl-500.png",
                label: "यूनिफार्म",
                controller: _uniformsController,
                quantity: _quantities['uniforms']!,
              ),
              _buildQuantityContainer(
                weight:true,
                imagePath: "assets/rice-hd-png-rice-png-photos-1200.png",
                label: "चावल",
                controller: _riceController,
                quantity: _quantities['rice']!,
              ),
              _buildQuantityContainer(
                weight:true ,
                imagePath: "assets/flour-png-11553989035ynkldnd7ss.png",
                label: "आटा",
                controller: _wheatController,
                quantity: _quantities['wheat']!,
              ),
              _buildQuantityContainer(
                weight:true,
                imagePath: "assets/purepng.com-vegetablespotatocarrotbowlvegetable-971524598571f93zl.png",
                label: "सब्जी",
                controller: _vegetablesController,
                quantity: _quantities['vegetables']!,
              ),
              _buildQuantityContainer(
                weight:false,
                imagePath: "assets/Clipart-paper-write-pen.png",
                label: "लेखन सामग्री",
                controller: _stationeryController,
                quantity: _quantities['stationery']!,
              ),
              _buildQuantityContainer(
                weight:true,
                imagePath: "assets/pulses-2274.png",
                label: "दाल",
                controller: _pulsesController,
                quantity: _quantities['pulses']!,
              ),
            const  SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(192, 119, 33, 1.0),
                  ),
                  onPressed: _addItem,
                  child: const Text(
                    'सामग्री जोड़ें',
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                ),
              ),
            const  SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:  Color(0xFF34495E),
                  ),
                  onPressed: _updateQuantities,
                  child:const Text(
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
          color: const Color(0xFFD9D9D9),
          borderRadius: BorderRadius.circular(15.0), // Adjust the radius as needed
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
                weight?
                Text(
                  "$label ($quantity किलोग्राम)",
                  style:const TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                ):
                 Text(
                  "$label ($quantity)",
                  style:const TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                )
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
