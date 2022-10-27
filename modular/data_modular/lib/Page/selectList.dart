import 'package:data_modular/ViewModel/dataClass%20.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class SelectList extends StatefulWidget {
  const SelectList({super.key});

  @override
  State<SelectList> createState() => _SelectListState();
}

class _SelectListState extends State<SelectList> {
  @override
  void initState() {
    final postModel = Provider.of<DataClass>(context, listen: false);
    postModel.listpriceTotal();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final postModel = Provider.of<DataClass>(context, listen: false);
    return Scaffold(
      appBar: AppBar(title: const Text('Select List')),
      body: ListView.builder(
          itemCount: postModel.checkList.length,
          itemBuilder: (BuildContext context, index) {
            return Card(
              elevation: 5,
              child: ListTile(
                leading: CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(
                      postModel.checkList[index].images[0].toString()),
                  backgroundColor: Colors.transparent,
                ),
                title: Text(postModel.checkList[index].title),
                trailing: Text(postModel.checkList[index].price.toString()),
              ),
            );
          }),
      floatingActionButton: ElevatedButton(
        child: Text(postModel.price.toString()),
        onPressed: () {},
      ),
    );
  }
}
