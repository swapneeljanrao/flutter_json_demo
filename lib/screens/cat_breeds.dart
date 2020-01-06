import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_json_demo/api/cat_api.dart';
import 'package:flutter_json_demo/models/cats.dart';

import 'cat_info.dart';

class CatBreedsPage extends StatefulWidget {
  CatBreedsPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _CatBreedsPageState createState() => _CatBreedsPageState();
}

class _CatBreedsPageState extends State<CatBreedsPage> {
  BreedList breedList = BreedList();

  void getCatData() async {
    var catJson = await CatAPI().getCatBreeds();
    print(catJson);

    var catMap = json.decode(catJson);
    setState(() {
      breedList = BreedList.fromJson(catMap);
    });
  }

  @override
  void initState() {
    super.initState();
    getCatData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
          itemCount: (breedList == null ||
                  breedList.breeds == null ||
                  breedList.breeds.length == 0)
              ? 0
              : breedList.breeds.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return CatInfo(
                      catId: breedList.breeds[index].id,
                      catBreed: breedList.breeds[index].name);
                }));
              },
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(breedList.breeds[index].name),
                    subtitle: Text(breedList.breeds[index].description),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
