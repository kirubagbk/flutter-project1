// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'dart:io';
import 'package:path_provider/path_provider.dart';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:task_project/userscreen.dart';

class AllUsers extends StatefulWidget {
  const AllUsers({Key? key}) : super(key: key);

  @override
  State<AllUsers> createState() => _AllUsersState();
}

class _AllUsersState extends State<AllUsers> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                showSearch(context: context, delegate: CustomSearchDelegate());
              },
              icon: const Icon(Icons.search),
            ),

            IconButton(
              onPressed: () {
                generateAndDownloadPDF(context);
              },
              icon: const Icon(Icons.download),
            ),
          ],
          title: const Text('Data Screen'),
        ),
        body: const Column(
          children: [
            Expanded(
              child: MyTable(),
            ),
          ],
        ),
      ),
    );
  }
}

class MyTable extends StatefulWidget {
  const MyTable({Key? key}) : super(key: key);

  @override
  State<MyTable> createState() => _MyTableState();
}

class _MyTableState extends State<MyTable> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          List<TableRow> rows = [
            const TableRow(children: [
              TableCell(child: Center(child: Text('First Name', style: TextStyle(fontWeight: FontWeight.bold)))),
              TableCell(child: Center(child: Text('Last Name', style: TextStyle(fontWeight: FontWeight.bold)))),
              TableCell(child: Center(child: Text('Email', style: TextStyle(fontWeight: FontWeight.bold)))),
              TableCell(child: Center(child: Text('Mobile Number', style: TextStyle(fontWeight: FontWeight.bold)))),
              TableCell(child: Center(child: Text('Address', style: TextStyle(fontWeight: FontWeight.bold)))),
            ]),
          ];

          for (var doc in snapshot.data!.docs) {
            rows.add(
              TableRow(children: [
                TableCell(child: Center(child: Text(doc['firstName'].toString()))),
                TableCell(child: Center(child: Text(doc['lastName'].toString()))),
                TableCell(child: Center(child: Text(doc['email'].toString()))),
                TableCell(child: Center(child: Text(doc['mobileNumber'].toString()))),
                TableCell(child: Center(child: Text(doc['address'].toString()))),
              ]),
            );
          }

          return Table(
            border: TableBorder.all(),
            columnWidths: const <int, TableColumnWidth>{
              0: FixedColumnWidth(75.0),
              1: FixedColumnWidth(75.0),
              2: FixedColumnWidth(120.0),
              3: FixedColumnWidth(85.0),
              4: FixedColumnWidth(60.0),
            },
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: rows,
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}

class CustomSearchDelegate extends SearchDelegate<String> {
  List<Map<String, dynamic>> searchResults = [];

  CustomSearchDelegate() {
    getEmailsFromFirebase();
  }

  Future<void> getEmailsFromFirebase() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('users').get();

      searchResults = querySnapshot.docs
          .map((doc) => {
                'email': doc['email'].toString(),
                'details': {
                  'firstName': doc['firstName'].toString(),
                  'lastName': doc['lastName'].toString(),
                  'mobileNumber': doc['mobileNumber'].toString(),
                  'address': doc['address'].toString(),
                }
              })
          .toList();
      print('searchResults: $searchResults');
    } catch (e) {
      print('Error fetching email: $e');
    }
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, query);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }



  @override
  Widget buildResults(BuildContext context) {
    List<Map<String, dynamic>> matchQuery = [];
    for (var result in searchResults) {
      if (result['email'].toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(result);
      }
    }

    if (matchQuery.length == 1) {
      var result = matchQuery[0];
      return UserDetailsScreen(result['details']);
    }

    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result['email']),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UserDetailsScreen(result['details']),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Map<String, dynamic>> matchQuery = [];
    for (var result in searchResults) {
      if (result['email'].toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(result);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result['email']),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UserDetailsScreen(result['details']),
              ),
            );
          },
        );
      },
    );
  }
}



//pdf download kana file

Future<void> generateAndDownloadPDF(BuildContext context) async {
  final pdf = pw.Document();

  pdf.addPage(
    pw.Page(
      build: (context) {
        return pw.Center(
          child: pw.Text('User Data Table', style: const pw.TextStyle(fontSize: 20)),
        );
      },
    ),
  );

  var snapshot = await FirebaseFirestore.instance.collection('users').get();

  pdf.addPage(
    pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      build: (context) {
        return [
          pw.Table.fromTextArray(
            headerAlignment: pw.Alignment.centerLeft,
            cellAlignment: pw.Alignment.centerLeft,
            headerHeight: 30,
            cellHeight: 30,
            headerDecoration: const pw.BoxDecoration(
              color: PdfColors.grey200,
            ),
            cellStyle: const pw.TextStyle(
              fontSize: 10,
            ),
            headers: ['First Name', 'Last Name', 'Email', 'Mobile Number', 'Address'],
            data: MyTableData.getData(snapshot),
          ),
        ];
      },
    ),
  );
 final downloadsDirectory = await getDownloadsDirectory();
  final file = File('${downloadsDirectory!.path}/example.pdf');
  await file.writeAsBytes(await pdf.save());

  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text('PDF Downloaded Successfully'),
    ),
  );
}
class MyTableData {
  static List<List<String>> getData(QuerySnapshot<Object?> snapshot) {
    return snapshot.docs.map((doc) {
      return [
        doc['firstName'].toString(),
        doc['lastName'].toString(),
        doc['email'].toString(),
        doc['mobileNumber'].toString(),
        doc['address'].toString(),
      ];
    }).toList();
  }
}


