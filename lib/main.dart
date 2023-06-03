import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/services.dart';
import 'package:ytquran/constant.dart';
import 'package:ytquran/surah_builder.dart';

import 'index.dart';

bool fabIsClickedSearch = true;

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {

  List<Map<String, dynamic>> searchByWord(String word) {
    List<Map<String, dynamic>> results = [];
    for (var item in arabic) {
      String ayaText = item["aya_text_emlaey"];
      if (ayaText.contains(word)) {
        results.add(item);
      }
    }
    return results;
  }

  Widget buildSearchResult(List<Map<String, dynamic>> results) {
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        Map<String, dynamic> item = results[index];
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SurahBuilder(
                  arabic: quran[0],
                  sura: item['sura_no'] - 1,
                  suraName: item['sura_name_ar'],
                  ayah: item['aya_no'] - 1,
                ),
              ),
            );
          },

          child: Card(
            elevation: 5,
      color: Colors.orange[300],
            child: ListTile(
              title: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "${item["sura_name_ar"]}",
                          style: TextStyle(
                            fontSize:20,

                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        "رقم الآية: ${item["aya_no"]}",
                        style: TextStyle(
                          fontSize:15,

                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Divider(color: Colors.black,thickness: 2),
                  Text(
                    item["aya_text_emlaey"],
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),

        );
      },
    );
  }

  List<Map<String, dynamic>> searchResults = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quran Search'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (value) {
                searchResults = searchByWord(value);

                setState(() {
                  // Show search results
                  // You can use the search results as you like
                  // For now, I'm just printing them in the console
                  print(searchResults);
                });
              },
              decoration: InputDecoration(
                labelText: 'Search',
              ),
            ),
          ),
          Expanded(
            child: buildSearchResult(searchResults),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await readJson();
      await getSettings();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quran',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const IndexPage(),
    );
  }
}
