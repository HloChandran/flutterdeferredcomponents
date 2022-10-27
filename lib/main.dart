import 'package:data_modular/ViewModel/dataClass%20.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:assets_module/main.dart' deferred as assetsmodule;

import 'package:data_modular/main.dart' deferred as datamodule;

import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

void main() {
  return runApp(ModularApp(module: AppModule(), child: const AppWidget()));
}

class AppModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<Module> get imports => [];

  @override
  List<ModularRoute> get routes => routeProvider.getRoutes();
}

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => DataClass(),
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Modular',
          theme: ThemeData(primarySwatch: Colors.blue),
          routeInformationParser: Modular.routeInformationParser,
          routerDelegate: Modular.routerDelegate,
        ));
  }
}

RouteProvider routeProvider = RouteProvider();

class SomeWidget extends StatefulWidget {
  const SomeWidget({Key? key}) : super(key: key);

  @override
  _SomeWidgetState createState() => _SomeWidgetState();
}

class _SomeWidgetState extends State<SomeWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Dynamic Feature Modules'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MaterialButton(
                    color: Colors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    onPressed: () async {
                      try {
                        await installAssetsModuleUsingQueue();
                      } catch (e) {
                        debugPrint('error ' + e.toString());
                      }
                    },
                    child: const Text('Assets Module',
                        style: TextStyle(color: Colors.white))),
                const SizedBox(
                  width: 10,
                ),
                MaterialButton(
                    color: Colors.blue,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    onPressed: () async {
                      try {
                        await installDataModule();
                      } catch (e) {
                        debugPrint('error ' + e.toString());
                      }
                    },
                    child: const Text(
                      'Data Module',
                      style: TextStyle(color: Colors.white),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> installDataModule() async {
    var data = <Future>[];
    data.add(dataloadLibrary());
    await Future.wait(data);
  }

  Future<void> installAssetsModuleUsingQueue() async {
    var queue = <Future>[];
    queue.add(loadAssetsLibrary());
    await Future.wait(queue);
  }

  Future<dynamic> loadAssetsLibrary() {
    debugPrint("loadLibrary init........");
    callToast("loadLibrary init........");
    return assetsmodule.loadLibrary().then((value) {
      debugPrint("loadLibrary loaded........");
      callToast("loadLibrary loaded........");
      routeProvider.addModuleRoute(
          ModuleRoute('/assets/', module: assetsmodule.AssetsModule()));
      Modular.reassemble();
      Modular.to.pushNamed('/assets');
    }).onError((error, stackTrace) {
      debugPrint("load error.........." + error.toString());
      callToast("load error.........." + error.toString());
    }).catchError((e) {
      debugPrint("load catchError.........." + e.toString());
      callToast("load catchError.........." + e.toString());
    });
  }
}

Future<dynamic> dataloadLibrary() {
  callToast('loadLibrary DataModular init........');

  return datamodule.loadLibrary().then((value) {
    routeProvider.addModuleRoute(
        ModuleRoute('/data/', module: datamodule.DataModular()));
    Modular.reassemble();
    Modular.to.pushNamed('/data');
  }).onError((error, stackTrace) {
    debugPrint("load error.........." + error.toString());
    callToast("load error.........." + error.toString());
  }).catchError((e) {
    debugPrint("load catchError.........." + e.toString());
    callToast("load catchError.........." + e.toString());
  });
}

var initRoutes = [
  ChildRoute(
    '/',
    child: (context, args) => const SomeWidget(),
  ),
];

class RouteProvider {
  List<ParallelRoute> routes = [];
  RouteProvider() {
    routes.addAll(initRoutes);
  }

  List<ModularRoute> getRoutes() {
    return routes;
  }

  void addRoute(ModularRoute item) {
    routes.add(item as ParallelRoute);
  }

  void replaceRoute(List<ParallelRoute> item) {
    routes = item;
  }

  void addChildRoute(ChildRoute route) {
    routes.add(route);
  }

  void addModuleRoute(ModuleRoute route) {
    routes.add(route);
  }

  void addAsChildren(String parent, ParallelRoute route) {
    var foundItem = routes.firstWhere((element) => element.name == parent);
    foundItem.children.add(route);
    routes.removeWhere((element) => element.name == parent);
    routes.add(foundItem);
  }
}

void callToast(String mesg) {
  Fluttertoast.showToast(
      msg: mesg,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 3,
      backgroundColor: Colors.black54,
      textColor: Colors.white,
      fontSize: 14.0);
}
