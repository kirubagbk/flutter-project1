// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegistrationSuccessPage extends StatelessWidget {
  const RegistrationSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('search page'),
        ),
        body: const Center(
          child: MyRecord(),
        ),
      ),
    );
  }
}


class MyRecord extends StatefulWidget {
  const MyRecord({super.key});

  @override
  _MyRecordState createState() => _MyRecordState();
}

class _MyRecordState extends State<MyRecord> {
  late String emailToSearch;
  TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    emailToSearch = '';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: emailController,
            onChanged: (value) {
              setState(() {
                emailToSearch = value;
              });
            },
            decoration: const InputDecoration(labelText: 'Enter Email'),
          ),
        ),
        // ElevatedButton(
        //   onPressed: () {
        //      },
        //   child: const Text('Search'),
        // ),
        // const SizedBox(height: 20),
       StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users') 
              .where('email', isEqualTo: emailToSearch)
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) 
          {

              if (snapshot.data!.docs.isNotEmpty) {
              
                var doc = snapshot.data!.docs[0]; 
                List<TableRow> rows = [
            const TableRow(children: [
              TableCell(child: Center(child: Text('first Name', style: TextStyle(fontWeight: FontWeight.bold)))),
              TableCell(child: Center(child: Text('last Name', style: TextStyle(fontWeight: FontWeight.bold)))),
              TableCell(child: Center(child: Text('email', style: TextStyle(fontWeight: FontWeight.bold)))),
              TableCell(child: Center(child: Text('mobile Number', style: TextStyle(fontWeight: FontWeight.bold)))),
              TableCell(child: Center(child: Text('address', style: TextStyle(fontWeight: FontWeight.bold)))),


            ]),
           ];
                snapshot.data!.docs.forEach((doc) {
            rows.add(
              TableRow(children: [
                TableCell(child: Center(child: Text(doc['firstName']))),
                TableCell(child: Center(child: Text(doc['lastName']))),
                TableCell(child: Center(child: Text(doc['email']))),
                TableCell(child: Center(child: Text(doc['mobileNumber']))),
                TableCell(child: Center(child: Text(doc['address']))),


            
              ]),
            );
                }
           );

        return Table(
          border: TableBorder.all(),
          children: rows,
        );
      } else {
        return Text('No record found for email: $emailToSearch');
      }
    } else {
      return const CircularProgressIndicator();
    }
  },
),
      ],
    );
  }
}



