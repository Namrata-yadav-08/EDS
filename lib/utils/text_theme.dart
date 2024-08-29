import 'package:flutter/material.dart';

class ttexttheme {
  ttexttheme._();
  static TextTheme lighttheme = TextTheme( headlineLarge: TextStyle(  fontSize: 32.0, fontWeight: FontWeight.bold,  color: Colors.black,  ),
     headlineMedium: TextStyle( fontSize: 32.0, fontWeight: FontWeight.w600, color: Colors.black,),
       headlineSmall: TextStyle(fontSize: 18.0,fontWeight: FontWeight.w600,color:Colors.black),


      titleLarge: TextStyle( fontSize: 16.0, fontWeight: FontWeight.w600, color: Colors.black,),
      titleMedium: TextStyle( fontSize: 16.0, fontWeight: FontWeight.w500, color: Colors.black,),
      titleSmall:  TextStyle( fontSize: 16.0, fontWeight: FontWeight.w400, color: Colors.black,),


       bodyLarge: TextStyle( fontSize: 14.0, fontWeight: FontWeight.w500, color: Colors.black,),
      bodyMedium: TextStyle( fontSize: 14.0, fontWeight: FontWeight.normal, color: Colors.black,),
      bodySmall:  TextStyle( fontSize: 14.0, fontWeight: FontWeight.w500, color: Colors.black.withOpacity(0.5)),

   labelLarge: TextStyle( fontSize: 12.0, fontWeight: FontWeight.w500, color: Colors.black,),
      labelMedium: TextStyle( fontSize: 12.0, fontWeight: FontWeight.normal, color: Colors.black.withOpacity(0.5)),
       );

  static TextTheme darktheme =TextTheme(headlineLarge: TextStyle(  fontSize: 32.0, fontWeight: FontWeight.bold,  color: Colors.white,  ),
     headlineMedium: TextStyle( fontSize: 32.0, fontWeight: FontWeight.w600, color: Colors.white,),
       headlineSmall: TextStyle(fontSize: 18.0,fontWeight: FontWeight.w600,color:Colors.white),


      titleLarge: TextStyle( fontSize: 16.0, fontWeight: FontWeight.w600, color: Colors.white,),
      titleMedium: TextStyle( fontSize: 16.0, fontWeight: FontWeight.w500, color: Colors.white,),
      titleSmall:  TextStyle( fontSize: 16.0, fontWeight: FontWeight.w400, color: Colors.white,),


       bodyLarge: TextStyle( fontSize: 14.0, fontWeight: FontWeight.w500, color: Colors.white,),
      bodyMedium: TextStyle( fontSize: 14.0, fontWeight: FontWeight.normal, color: Colors.white,),
      bodySmall:  TextStyle( fontSize: 14.0, fontWeight: FontWeight.w500, color: Colors.white.withOpacity(0.5)),

   labelLarge: TextStyle( fontSize: 12.0, fontWeight: FontWeight.w500, color: Colors.white,),
      labelMedium: TextStyle( fontSize: 12.0, fontWeight: FontWeight.normal, color: Colors.white.withOpacity(0.5)),
       );
      
}