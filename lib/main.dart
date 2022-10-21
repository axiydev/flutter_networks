import 'package:flutter/material.dart';
import 'package:flutter_networks/page/detail/detail_view.dart';
import 'package:flutter_networks/page/home/home_view.dart';

/*
Created by Axmadjon Isaqov on 09:15:08 21.10.2022
© 2022 @axi_dev 
*/
/*
Theme:::[Working with networks]
*/
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/posts': (context) => const HomeView(),
        '/detail': (context) => const DetailView()
      },
      home: const HomeView(),
    );
  }
}
