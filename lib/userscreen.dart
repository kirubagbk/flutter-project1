

import 'package:flutter/material.dart';

class UserDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> userDetails;

  const UserDetailsScreen(this.userDetails, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text(
        //     userDetails['firstName'] + ' ' + userDetails['lastName']
        //     ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('First Name: ${userDetails['firstName']}'),
          Text('Last Name: ${userDetails['lastName']}'),
          Text('Mobile Number: ${userDetails['mobileNumber']}'),
          Text('Address: ${userDetails['address']}'),
        ],
      ),
    );
  }
}
