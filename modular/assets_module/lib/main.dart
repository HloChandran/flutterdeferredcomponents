library assets_module;

import 'package:assets_module/second.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AssetsModule extends Module {
  @override
  List<Bind<Object>> get binds => [];

  @override
  List<Module> get imports => const [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (context, args) => const AssetsModulePage(title: 'Assets Module'),
        ),
        ChildRoute('/secondPage', child: (context, args) => const SecondPage()),
      ];
}

class AssetsModulePage extends StatefulWidget {
  const AssetsModulePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<AssetsModulePage> createState() => _AssetsModulePageState();
}

class _AssetsModulePageState extends State<AssetsModulePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Modular.to.pushNamed('secondPage',
                    arguments: {"img": 'assets/assets_module/img/img' + index.toString() + '.jpg'});
              },
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image(
                  fit: BoxFit.cover,
                  height: 200,
                  width: 200,
                  image: AssetImage('assets/assets_module/img/img' + index.toString() + '.jpg'),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
