import 'package:flutter/material.dart';
import 'package:mlplayground/Pages/gradientDescent.dart';
import 'package:mlplayground/Pages/linearRegression.dart';
import 'package:mlplayground/Pages/welcome.dart';
import 'package:mlplayground/provider/Gradient-Descent/GDfit-provider.dart';
import 'package:mlplayground/provider/Gradient-Descent/Reg-line-provider.dart';
import 'package:mlplayground/provider/Gradient-Descent/sample-data.dart';
import 'package:mlplayground/provider/Line%20Provider/AlgoProvider.dart';
import 'package:mlplayground/provider/Line%20Provider/lineProvider.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      pageBuilder: (context, state){
        return const MaterialPage(
          child: welocomePage(),
        );
      }
    ),

    GoRoute(
      path: '/linear-regression-simulator',
      pageBuilder: (context, state){
        return const MaterialPage(
          child: Linearregression(),
        );
      }
    ),
    GoRoute(
      path: '/gradient-descent-simulator',
      pageBuilder: (context, state){
        return const MaterialPage(
          child: Gradientdescent(),
        );
      }
    ),

  ],
);


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => lineprovider(),),
      ChangeNotifierProvider(create: (context) => regLineProvider(),),
      ChangeNotifierProvider(create: (context)=> LinReg()),
      ChangeNotifierProvider(create: (context)=>sampleData()),
      ChangeNotifierProvider(create: (context)=> Gdfitprovider()),
      ChangeNotifierProvider(create: (context)=> Reglinesprovider()),
    ],
    child:  MaterialApp.router(
      routerConfig: _router,  
    )
    );
  }
}
