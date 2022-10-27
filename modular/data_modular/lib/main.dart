library data_modular;
import 'package:data_modular/Page/providerDemoScreen.dart';
import 'package:data_modular/Page/selectList.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter_modular/flutter_modular.dart';

class DataModular extends Module {
  @override
  List<Bind<Object>> get binds => [];

  @override
  List<Module> get imports => const [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (context, args) => const ProviderDemoScreen(),
        ),
        ChildRoute('/selectList', child: (context, args) => const SelectList()),
      ];
}


