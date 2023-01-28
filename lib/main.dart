import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'dart:async';
import 'dart:io';

import 'package:thiena_app/variables.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ConnectivityResult? _connectivityResult;

  late StreamSubscription _connectivitySubscription;

  @override
  initState() {
    super.initState();

    _connectivitySubscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      print('Current connectivity status: $result');
      setState(() {
        _connectivityResult = result;
      });
    });
  }

  @override
  dispose() {
    super.dispose();

    _connectivitySubscription.cancel();
  }

  IconData internetConnection = Icons.network_check_outlined;

  IconData _getInternetConnection() {
    dynamic result = _connectivityResult;
    if (result == ConnectivityResult.wifi) {
      return Icons.wifi;
    } else if (result == ConnectivityResult.mobile) {
      return Icons.network_cell_outlined;
    } else {
      return Icons.mobile_off_sharp;
    }
  }

  void _showAirplaneMode(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: ((_) {
        return GestureDetector(
          onTap: () {},
          behavior: HitTestBehavior.opaque,
          child: Container(
            height: 100,
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                const Icon(Icons.restart_alt_outlined),
                ElevatedButton(
                  onPressed: () => print('Bottom'),
                  child: const Text('Opened'),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () => _showAirplaneMode(context),
              icon: Icon(_getInternetConnection()),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.wb_sunny_rounded),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search_rounded),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.camera_alt_outlined),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.more_vert),
            )
          ],
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(
                  Icons.people_outline_sharp,
                ),
              ),
              Tab(
                text: 'Chats',
              ),
              Tab(
                text: 'Status',
              ),
              Tab(
                text: 'Calls',
              ),
            ],
          ),
          title: const Text('Whatsapp'),
          backgroundColor: MyColors.tealGreen.color(),
        ),
        body: TabBarView(
          children: [
            Container(
              color: MyColors.tealGreenDark.color(),
              child: ListView.builder(
                itemBuilder: (ctx, index) {
                  return InkWell(
                    onTap: () {
                      const SnackBar(
                        content: Text("Long pressed"),
                      );
                    },
                    child: Card(
                      // margin: const EdgeInsets.symmetric(
                      //   vertical: 8,
                      //   horizontal: 5,
                      // ),
                      color: Colors.transparent,
                      elevation: 0,
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.blueGrey.shade400,
                          radius: 30,
                          child: const FittedBox(
                            fit: BoxFit.contain,
                            child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Icon(
                                Icons.people_alt_rounded,
                                size: 56,
                                color: Colors.white54,
                              ),
                            ),
                          ),
                        ),
                        title: const Text(
                          'Group Name',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        subtitle: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 7),
                              child: Icon(
                                Icons.done_all_sharp,
                                color: Colors.grey,
                              ),
                            ),
                            Text(
                              'Three',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 16),
                            ),
                          ],
                        ),
                        trailing: IconButton(
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.amber,
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ),
                  );
                },
                itemCount: 9,
              ),
            ),
            const Icon(Icons.camera_alt),
            const Tab(
              icon: Icon(Icons.grade),
            ),
            const Tab(
              icon: Icon(Icons.email),
            ),
          ],
        ),
      ),
    );
  }
}
