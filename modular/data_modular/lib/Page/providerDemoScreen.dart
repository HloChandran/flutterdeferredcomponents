import 'dart:developer';

import 'package:data_modular/Page/selectList.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../ViewModel/dataClass .dart';

class ProviderDemoScreen extends StatefulWidget {
  const ProviderDemoScreen({super.key});

  @override
  State<ProviderDemoScreen> createState() => _ProviderDemoScreenState();
}

class _ProviderDemoScreenState extends State<ProviderDemoScreen> {
  TextEditingController searchController = TextEditingController();
  int checkCount = 0;
  @override
  void initState() {
    final postModel = Provider.of<DataClass>(context, listen: false);
    postModel.getPostData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final postModel = Provider.of<DataClass>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test'),
      ),
      body: postModel.loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      labelText: "Search",
                      suffixIcon: const Icon(Icons.search),
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: const BorderSide()),
                    ),
                    onSubmitted: (value) {
                      print('value$value');
                      postModel.searchData(searchController.text);
                    },
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Flexible(
                    child: ListView.builder(
                        itemCount: postModel.post!.products!.length,
                        itemBuilder: (BuildContext context, index) {
                          return Card(
                              elevation: 6,
                              child: CheckboxListTile(
                                activeColor: Colors.pink[300],
                                dense: true,
                                //font change
                                title: Text(
                                  postModel.post!.products![index].title,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 0.5),
                                ),
                                value: postModel
                                    .post!.products![index].selectvalue,
                                secondary: SizedBox(
                                  height: 50,
                                  width: 50,
                                  child: CircleAvatar(
                                    radius: 10,
                                    backgroundImage: NetworkImage(postModel
                                        .post!.products![index].images[0]
                                        .toString()),
                                    backgroundColor: Colors.transparent,
                                  ),
                                ),
                                onChanged: (bool? value) {
                                  if (kDebugMode) {
                                    print('test$value');
                                  }

                                  postModel.check(value ?? true, index);
                                },
                              ));
                        }),
                  ),
                ],
              ),
            ),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          if (postModel.cnt > 0) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SelectList()));
          } else {
            showDialog(
                barrierDismissible: false,
                context: context,
                builder: (ctx) => AlertDialog(
                      title: const Text('Alert...!'),
                      content: const Text('Kindly Select Any One Check Box..'),
                      actions: <Widget>[
                        ElevatedButton(
                          onPressed: (() {
                            Navigator.of(ctx).pop();
                          }),
                          child: const Text('OK'),
                        )
                      ],
                    ));
          }
        },
        child: const Text('Next Page'),
      ),
    );
  }
}
