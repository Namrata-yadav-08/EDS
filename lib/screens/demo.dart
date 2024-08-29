// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:zoom/screens/signupcontroller.dart';
// import 'package:zoom/utils/helper_functions.dart';
// import 'package:zoom/utils/userrepo.dart';
// import 'package:zoom/utils/validator.dart';


// import 'package:zoom/utils/validator.dart';

// class SignUp extends StatefulWidget {
//   @override
//   _SignUpState createState() => _SignUpState();
// }

// class _SignUpState extends State<SignUp> {
  
//  Future<void> _getCurrentLocation() async {
//     bool serviceEnabled;
//     LocationPermission permission;

//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       return Future.error('Location services are disabled.');
//     }

//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         return Future.error('Location permissions are denied.');
//    bool _isLoading = false;
//      final List<String> _dropdownItems = ['Hindi/हिंदी', 'English', 'Malayalam/മലയാളം'];
//    String? _selectedTopValue;


//   // Future<void> _getCurrentLocation() async {
//   //   setState(() {
//   //     _isLoading = true;
//   //   });

//   //   bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
//   //   if (!serviceEnabled) {
//   //     ScaffoldMessenger.of(context).showSnackBar(
//   //       SnackBar(content: Text('Location services are disabled.')),
//   //     );
//   //     setState(() {
//   //       _isLoading = false;
//   //     });
//   //     return;
//   //   }

//   //   LocationPermission permission = await Geolocator.checkPermission();
//   //   if (permission == LocationPermission.denied) {
//   //     permission = await Geolocator.requestPermission();
//   //     if (permission == LocationPermission.denied) {
//   //       ScaffoldMessenger.of(context).showSnackBar(
//   //         SnackBar(content: Text('Location permissions are denied.')),
//   //       );
//   //       setState(() {
//   //         _isLoading = false;
//   //       });
//   //       return;
//   //     }
//   //   }

//   //   if (permission == LocationPermission.deniedForever) {
//   //     return Future.error('Location permissions are permanently denied, we cannot request permissions.');
//   //     ScaffoldMessenger.of(context).showSnackBar(
//   //       SnackBar(content: Text('Location permissions are permanently denied.')),
//   //     );
//   //     setState(() {
//   //       _isLoading = false;
//   //     });
//   //     return;
//   //   }

//   //   Position position = await Geolocator.getCurrentPosition(
//   //       desiredAccuracy: LocationAccuracy.high);

//   //   setState(() {
//   //     SignupController.x = position.latitude;
//   //     SignupController.ycoordinate = position.longitude;

//   //   });
//   // }
//   // // Variables to hold selected dropdown values
//   // String? _selectedTopValue;


//   // // Sample dropdown menu items
//   // final List<String> _dropdownItems = ['Hindi/हिंदी', 'English', 'Malayalam/മലയാളം'];
//   //     _isLoading = false;
//   //   });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
    
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//             SizedBox(
//               width:double.infinity,
//             ),
//               Center(
//       body: _isLoading
//           ? Center(child: CircularProgressIndicator())
//           : SingleChildScrollView(
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                      Center(
//                 child: IntrinsicWidth(
//                   child: DropdownButtonFormField<String>(
                    
//                     decoration: InputDecoration(
//                       hintText: "Select Language",
               
//                        border: InputBorder.none
                       
//                     ),
//                     value: _selectedTopValue,
//                     items: _dropdownItems.map((String value) {
//                       return DropdownMenuItem<String>(
//                         value: value,
//                         child: Text(value),
//                       );
//                     }).toList(),
//                     onChanged: (String? newValue) {
//                       setState(() {
//                         _selectedTopValue = newValue;
//                       });
//                     },
//                   ),
//                 ),
//               ),
        
//               SizedBox(
//               height:MediaQuery.of(context).size.height*0.01,
//               ),
//               Center(
//                 child: Text("साइन अप करें ", style: TextStyle(
//                   fontSize: MediaQuery.of(context).size.height*0.06,
//                   fontWeight: FontWeight.bold,
//                   color:Color.fromRGBO(192, 119, 33, 1.0)
        
//                 ),),
//               ),
//               SizedBox(height: THelperFunctions.screenHeight()*0.01,),
//               Form(
//                 key:SignupController.signup,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                    children: [
//                     Text("अधिकारी का नाम", style: TextStyle(
                      
//                       fontSize: THelperFunctions.screenHeight()*0.022,
                        
//                     ),),
//                     Container(
//                       decoration: BoxDecoration(
                      
//                         border: Border.all(
//                           color: Color.fromRGBO(187, 187, 187, 1.0),
//                           width: 1,
                          
//                         ),
//                         borderRadius: BorderRadius.circular(10)
                      
//                       ),
//                       child: TextFormField(
//                          validator: (value) =>
//                                     Validator.validateText("Lastname", value),
//                         controller: SignupController.Schoolname,
//                         decoration: InputDecoration(
//                           contentPadding: EdgeInsets.only(left:5.0),
//                           border: InputBorder.none,
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: THelperFunctions.screenHeight()*0.022,
//                     ),
//                     Text("प्राधिकरण का प्रकार", style: TextStyle(
//                       fontSize: THelperFunctions.screenHeight()*0.022,
                        
//                     ),),
//                     Container(
//                       decoration: BoxDecoration(
                        
//                         border: Border.all(
//                           color: Color.fromRGBO(187, 187, 187, 1.0),
//                           width: 1,
                          
//                         ),
//                         borderRadius: BorderRadius.circular(10)
                      
//                       ),
//                       child: TextFormField(
//                         validator: (value) =>
//                                     Validator.validateText("Firstname", value),
//                         controller: SignupController.firstname,
//                         decoration: InputDecoration(
//                           contentPadding: EdgeInsets.only(left:5.0),
//                           border: InputBorder.none,
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: THelperFunctions.screenHeight()*0.022,
//                     ),
//                      Text("कार्यालय का ई-मेल", style: TextStyle(
//                       fontSize: THelperFunctions.screenHeight()*0.022,
                        
//                     ),),

//                     Container(
//                       decoration: BoxDecoration(
                        
//                         border: Border.all(
//                           color: Color.fromRGBO(187, 187, 187, 1.0),
//                           width: 1,
                          
//                         ),
//                         borderRadius: BorderRadius.circular(10)
                      
//                       ),
//                       child: TextFormField(
//                         controller: SignupController.email,
//                         validator: (value) =>
//                                     Validator.validateEmail(value),
//                         decoration: InputDecoration(
//                           contentPadding: EdgeInsets.only(left:5.0),
//                           border: InputBorder.none,
//                         ),
//                       ),
//                     ),
//                       SizedBox(
//                       height: THelperFunctions.screenHeight()*0.022,
//                     ),
//                      Text("पासवर्ड", style: TextStyle(
//                       fontSize: THelperFunctions.screenHeight()*0.022,
                        
//                     ),),
//                     Container(
//                       decoration: BoxDecoration(
                        
//                         border: Border.all(
//                           color: Color.fromRGBO(187, 187, 187, 1.0),
//                           width: 1,
                          
//                         ),
//                         borderRadius: BorderRadius.circular(10)
                      
//                       ),
//                       child: TextFormField(
//                         controller: SignupController.password,
//                         obscureText: true,
//                         obscuringCharacter: "*",
//                         validator: (value) =>
//                                     Validator.validatepassword(value),
//                         decoration: InputDecoration(
//                           contentPadding: EdgeInsets.only(left:5.0),
//                           border: InputBorder.none,
//                         ),
//                       ),
//                     ),

//                        SizedBox(
//                       height: THelperFunctions.screenHeight()*0.022,
//                     ),
//                     Text("कार्यालय का फ़ोन नंबर", style: TextStyle(
//                       fontSize: THelperFunctions.screenHeight()*0.022,
                        
//                     ),),
//                     Container(
//                       decoration: BoxDecoration(
                        
//                         border: Border.all(
//                           color: Color.fromRGBO(187, 187, 187, 1.0),
//                           width: 1,
                          
//                         ),
//                         borderRadius: BorderRadius.circular(10)
                      
//                       ),
//                       child: TextFormField(
//                         controller: SignupController.phonenumber,
//                         validator: (value) =>
//                                   Validator.phonenumber(value),
//                         decoration: InputDecoration(
//                           contentPadding: EdgeInsets.only(left:5.0),
//                           border: InputBorder.none,
//                         ),
//                       ),
//                     ),
//                       SizedBox(
//                       height: THelperFunctions.screenHeight()*0.022,
//                     ),
//                       InkWell(
//                         onTap:() async{
//                                 await _getCurrentLocation();
//                           if (SignupController.signup.currentState!
//                                     .validate() 
//                               ) {
//                               SignupController.signUpcall(
                              
//                                   SignupController.email.text,
//                                   SignupController.password.text,
//                                   context);
//                             }
//                           },
//                         child: Container(
//                           height:THelperFunctions.screenHeight()*0.06,
//                           width:double.infinity,
//                         decoration: BoxDecoration(
//                           color: Color.fromRGBO(192, 119, 33, 1.0)
//                           ,
//                           border: Border.all(
//                             color: Color.fromRGBO(187, 187, 187, 1.0),
//                             width: 1,
                            
//                           ),
//                           borderRadius: BorderRadius.circular(10)
                        
//                         ),
//                         child: Center(child: Text("साइन अप करें",style: TextStyle(fontSize: THelperFunctions.screenHeight()*0.023, fontWeight: FontWeight.bold, color: Colors.white),))
//                         ),
//                       ),
//                      SizedBox(height: 10,),
                   
//                    ],
//                 ),
//               ),
//               // Middle Dropdown
     
//                    IntrinsicHeight(
//                     child: Image.asset("assets/Group 22.png"),
//                    )
//             ],
//           ),
//         ),
//       ),
//                     SizedBox(height: MediaQuery.of(context).size.height * 0.02),
//                     Center(
//                       child: Text(
//                         "साइन अप करें",
//                         style: TextStyle(
//                           fontSize: MediaQuery.of(context).size.height * 0.06,
//                           fontWeight: FontWeight.bold,
//                           color: Color.fromRGBO(192, 119, 33, 1.0),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: THelperFunctions.screenHeight() * 0.01),
//                     Form(
//                       key: SignupController.signup,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             "विद्यालय का नाम",
//                             style: TextStyle(
//                               fontSize: THelperFunctions.screenHeight() * 0.022,
//                             ),
//                           ),
//                           Container(
//                             decoration: BoxDecoration(
//                               border: Border.all(
//                                 color: Color.fromRGBO(187, 187, 187, 1.0),
//                                 width: 1,
//                               ),
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                             child: TextFormField(
//                               validator: (value) =>
//                                   Validator.validateText("School Name", value),
//                               controller: SignupController.collegename,
//                               decoration: InputDecoration(
//                                 contentPadding: EdgeInsets.only(left: 5.0),
//                                 border: InputBorder.none,
//                               ),
//                             ),
//                           ),
//                           SizedBox(height: THelperFunctions.screenHeight() * 0.022),
//                           Text(
//                             "प्रधानाचार्य का नाम",
//                             style: TextStyle(
//                               fontSize: THelperFunctions.screenHeight() * 0.022,
//                             ),
//                           ),
//                           Container(
//                             decoration: BoxDecoration(
//                               border: Border.all(
//                                 color: Color.fromRGBO(187, 187, 187, 1.0),
//                                 width: 1,
//                               ),
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                             child: TextFormField(
//                               validator: (value) =>
//                                   Validator.validateText("Principal Name", value),
//                               controller: SignupController.firstname,
//                               decoration: InputDecoration(
//                                 contentPadding: EdgeInsets.only(left: 5.0),
//                                 border: InputBorder.none,
//                               ),
//                             ),
//                           ),
//                           SizedBox(height: THelperFunctions.screenHeight() * 0.022),
//                           Text(
//                             "प्रधानाचार्य का ई-मेल",
//                             style: TextStyle(
//                               fontSize: THelperFunctions.screenHeight() * 0.022,
//                             ),
//                           ),
//                           Container(
//                             decoration: BoxDecoration(
//                               border: Border.all(
//                                 color: Color.fromRGBO(187, 187, 187, 1.0),
//                                 width: 1,
//                               ),
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                             child: TextFormField(
//                               controller: SignupController.email,
//                               validator: (value) =>
//                                   Validator.validateEmail(value),
//                               decoration: InputDecoration(
//                                 contentPadding: EdgeInsets.only(left: 5.0),
//                                 border: InputBorder.none,
//                               ),
//                             ),
//                           ),
//                           SizedBox(height: THelperFunctions.screenHeight() * 0.022),
//                           Text(
//                             "पासवर्ड",
//                             style: TextStyle(
//                               fontSize: THelperFunctions.screenHeight() * 0.022,
//                             ),
//                           ),
//                           Container(
//                             decoration: BoxDecoration(
//                               border: Border.all(
//                                 color: Color.fromRGBO(187, 187, 187, 1.0),
//                                 width: 1,
//                               ),
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                             child: TextFormField(
//                               controller: SignupController.password,
//                               obscureText: true,
//                               validator: (value) =>
//                                   Validator.validatepassword(value),
//                               decoration: InputDecoration(
//                                 contentPadding: EdgeInsets.only(left: 5.0),
//                                 border: InputBorder.none,
//                               ),
//                             ),
//                           ),
//                           SizedBox(height: THelperFunctions.screenHeight() * 0.022),
//                           Text(
//                             "फोन नंबर",
//                             style: TextStyle(
//                               fontSize: THelperFunctions.screenHeight() * 0.022,
//                             ),
//                           ),
//                           Container(
//                             decoration: BoxDecoration(
//                               border: Border.all(
//                                 color: Color.fromRGBO(187, 187, 187, 1.0),
//                                 width: 1,
//                               ),
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                             child: TextFormField(
//                               controller: SignupController.phonenumber,
//                               validator: (value) =>
//                                   Validator.phonenumber(value),
//                               decoration: InputDecoration(
//                                 contentPadding: EdgeInsets.only(left: 5.0),
//                                 border: InputBorder.none,
//                               ),
//                             ),
//                           ),
//                           SizedBox(height: THelperFunctions.screenHeight() * 0.04),
//                           Center(
//                             child: ElevatedButton(
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: Color.fromRGBO(187, 187, 187, 1.0),
//                                 padding: EdgeInsets.symmetric(vertical: 14.0),
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(8.0),
//                                 ),
//                               ),
//                               onPressed: () async {
//                                 if (SignupController.signup.currentState
//                                     ?.validate() ?? false) {
//                                   if (SignupController.x == null ||
//                                       SignupController.ycoordinate == null) {
//                                     await _getCurrentLocation();
//                                   }
//                                   setState(() {
//                                     _isLoading = true;
//                                   });
//                                   await SignupController.signUpCall(
//                                     SignupController.email.text,
//                                     SignupController.password.text,
//                                     context,
//                                   );
//                                   setState(() {
//                                     _isLoading = false;
//                                   });
//                                 }
//                               },
//                               child: Text(
//                                 "साइन अप करें",
//                                 style: TextStyle(
//                                   fontSize: THelperFunctions.screenHeight() * 0.025,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//     );
//   }
// } 