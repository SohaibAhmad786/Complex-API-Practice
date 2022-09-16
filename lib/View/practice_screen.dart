import 'dart:convert';

import 'package:complx_api/Model/usermodel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ComplexApiExample extends StatefulWidget {
  const ComplexApiExample({super.key});

  @override
  State<ComplexApiExample> createState() => _ComplexApiExampleState();
}

List<UserModel> ulist = [];

class _ComplexApiExampleState extends State<ComplexApiExample> {
  Future<List<UserModel>> getApiData() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      ulist.clear();
      for (var i in data) {
        ulist.add(UserModel.fromJson(i));
      }
      return ulist;
    } else {
      return ulist;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        backgroundColor: Colors.pinkAccent,
        body: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                  future: getApiData(),
                  builder: (context, AsyncSnapshot<List<UserModel>> snapshot) {
                    if (!snapshot.hasData) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Center(child: CircularProgressIndicator()),
                        ],
                      );
                    } else {
                      return ListView.builder(
                          itemCount: ulist.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    ReuseableRow(
                                        title: "Name",
                                        value: snapshot.data![index].name
                                            .toString()),
                                    ReuseableRow(
                                        title: "Address , Street",
                                        value: snapshot
                                            .data![index].address!.street
                                            .toString()),
                                    ReuseableRow(
                                        title: "Address , Suite",
                                        value: snapshot
                                            .data![index].address!.suite
                                            .toString()),
                                    ReuseableRow(
                                        title: "Address , City",
                                        value: snapshot
                                            .data![index].address!.city
                                            .toString()),
                                    ReuseableRow(
                                        title: "Address , ZipCode",
                                        value: snapshot
                                            .data![index].address!.zipcode
                                            .toString()),
                                    ReuseableRow(
                                        title: "Address , geo , lat",
                                        value: snapshot
                                            .data![index].address!.geo!.lat
                                            .toString()),
                                    ReuseableRow(
                                        title: "Address , geo , lng",
                                        value: snapshot
                                            .data![index].address!.geo!.lng
                                            .toString()),
                                  ],
                                ),
                              ),
                            );
                          });
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

class ReuseableRow extends StatelessWidget {
  String title, value;
  ReuseableRow({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(value),
        ],
      ),
    );
  }
}
