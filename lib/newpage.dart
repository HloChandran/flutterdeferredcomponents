import 'package:flutter/material.dart';

class NewPage extends StatefulWidget {
  const NewPage({Key ?key}) : super(key: key);

  @override
  State<NewPage> createState() => _NewPageState();
}

class _NewPageState extends State<NewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Page'),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Image(
                fit: BoxFit.cover,
                height: 200,
                width: 200,
                image: AssetImage('assets/assets_module/img/img' + index.toString() + '.jpg'),
              ),
            );
          },
        ),
      ),
    );
  }
}
