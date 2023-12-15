// ignore_for_file: use_build_context_synchronously, unused_local_variable, unused_element

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_project/search.dart';


final _firebase=FirebaseAuth.instance;
class CouponPage extends StatefulWidget {

  const CouponPage({super.key});

  @override
  State<CouponPage> createState() => _CouponPageState();
}

class _CouponPageState extends State<CouponPage> {

   final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

Future<String> _submit() async {
  if (_firstNameController.text.trim().isEmpty ||
      _lastNameController.text.trim().isEmpty ||
      _emailController.text.trim().isEmpty ||
      _mobileNumberController.text.trim().isEmpty ||
      _addressController.text.trim().isEmpty) {
    return 'All fields must be filled';
  }

  try {
    UserCredential userCredential =
        await FirebaseAuth.instance.signInAnonymously();

    await FirebaseFirestore.instance.collection('users').add({
      'firstName': _firstNameController.text,
      'lastName': _lastNameController.text,
      'email': _emailController.text,
      'mobileNumber': _mobileNumberController.text,
      'address': _addressController.text
    });

    _firstNameController.clear();
    _lastNameController.clear();
    _emailController.clear();
    _mobileNumberController.clear();
    _addressController.clear();

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AllUsers()),
    );

    print('Submitted successfully!');
    return 'Submitted successfully';
  } catch (e) {
    print('Error: $e');
    return 'Error submitting data';
  }
}

//   Future<String> _submit() async {
//     try {
//       // Sign in with Firebase Authentication
//       UserCredential userCredential = await FirebaseAuth.instance.signInAnonymously();

//       if(_firstNameController.text.trim().isEmpty){
//       return  'First Name cannt be empty';
//     }
//     if(_lastNameController.text.trim().isEmpty){
//       return 'Last Name cannt be empty';
//     }
//     if(_emailController.text.trim().isEmpty){
//       return 'Email cannt be empty';
//     }
//     if(_mobileNumberController.text.trim().isEmpty){
//       return 'Mobile number cannt be empty';
//     }
//     if(_addressController.text.trim().isEmpty){
//       return 'Address cannt be empty';
//     }

//       // Store additional user data in Firestore
//       await FirebaseFirestore.instance.collection('users').add({
//         'firstName': _firstNameController.text,
//         'lastName': _lastNameController.text,
//         'email': _emailController.text,
//         'mobileNumber': _mobileNumberController.text,
//         'address': _addressController.text
//       });
//      _firstNameController.clear();
//     _lastNameController.clear();
//     _emailController.clear();
//     _mobileNumberController.clear();
//     _addressController.clear();
//  Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => AllUsers()),
//         );
//       print('Submitted successfully!');
//       return 'Submitted successfully';
//     } catch (e) {
//       print('Error: $e');
//       return 'error';
//     }
//   }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Coupon Page'),
      ),
      body: Container(
          padding: const EdgeInsets.all(20),
          child: Form(

            child: ListView(
          
              children: [
                const Text('First Name'),
                const SizedBox(
                  height: 5,
                ),
                 
                TextFormField(
                  
                   controller: _firstNameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person),
                    hintText: 'Enter Name',
                    
                  )
            
                ),
                
          
                const SizedBox(
                  height: 5,
                ),
                const Text('Last Name'),
                const SizedBox(
                  height: 5,
                ),
                 TextFormField(
                  controller: _lastNameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person),
          
                    hintText: 'Enter Name',
                  ),
                ),
          
          
                const SizedBox(
                  height: 10,
                ),
                const Text('Email'),
                const SizedBox(
                  height: 5,
                ),
          
          
                 TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.mail),
                    hintText: 'Enter Email',
                  ),
                  keyboardType: TextInputType.emailAddress,
                  textCapitalization: TextCapitalization.none,
                 
                ),
            const SizedBox(
                  height: 10,
                ),
                const Text('Mobile'),
                const SizedBox(
                  height: 5,
                ),
          
                 TextFormField(
                   controller: _mobileNumberController,
                  decoration: const InputDecoration(           
                    border: OutlineInputBorder(),                 
                    prefixIcon: Icon(Icons.phone),
                    hintText: 'Enter Mobile',
                  ),
                  keyboardType: TextInputType.number,
                    
                  
                ),
                
          
                const SizedBox(
                  height: 10,
                ),
                const Text('Address'),
                const SizedBox(
                  height: 5,
                )
                ,
                 TextFormField(
                  controller: _addressController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.home),
                    hintText: 'Enter Address',
                    
                  ),
                   
                ),
                const SizedBox(
                  height: 20,
                ),
          
          
              ElevatedButton(
                onPressed: () async {
                  String result = await _submit();
                  if (result != 'Submitted successfully') {
                    ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(result),
                        duration: const Duration(seconds: 3), 
                      ),
                    );
                    }
                  },
                  child: const Text(
                    'submit',
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ),
],
),
),
),
);
}
}
