import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  List<dynamic> _data = [];

  Future<void> fetchData() async {
    final response = await http.get(
      Uri.parse("https://dummyjson.com/products"),
    );

    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);
      setState(() {
        _data = decoded['products'];
      });
    }
  }

  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: ListView.builder(
            itemCount: _data.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(_data[index]['title']),
                subtitle: Text(_data[index]['description']),
                trailing: Image.network(_data[index]['thumbnail']),
              );
            },
          ),
        ),
      ),
    );
  }
}
