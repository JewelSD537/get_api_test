import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<dynamic> product = [];

  Future<void> fetchData() async {
    final uri = Uri.parse("https://dummyjson.com/products");
    final response = await http.get(uri);

    if (response.statusCode == 200) {

      final jsonData = jsonDecode(response.body);

      setState(() {
        product = jsonData["products"];
      });

    } else {
      print("Not Found");
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Get API")),
      ),

      body: product.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: product.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(10),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product[index]["title"],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(product[index]["description"], maxLines: 1,
                    overflow: TextOverflow.ellipsis,),
                  Text(product[index]["category"]),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
