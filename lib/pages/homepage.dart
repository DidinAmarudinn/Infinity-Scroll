import 'package:flutter/material.dart';
import 'package:infinity_scroll_app/provider/passanger_provider.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  RefreshController refreshController = RefreshController(
    initialRefresh: true,
  );

  @override
  void dispose() {
    super.dispose();
    refreshController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final passangerProvider = Provider.of<PassangerProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Infinity Scroll"),
      ),
      body: SmartRefresher(
        enablePullUp: true,
        enablePullDown: false,
        controller: refreshController,
        onRefresh: () async {
          await passangerProvider.getDataPassanger(
              refreshController: refreshController, isRefresh: true);
          if (passangerProvider.result) {
            refreshController.refreshCompleted();
          } else {
            refreshController.refreshFailed();
          }
        },
        onLoading: () async {
          await passangerProvider.getDataPassanger(
              refreshController: refreshController);
          if (passangerProvider.result) {
            refreshController.loadComplete();
          } else {
            refreshController.loadFailed();
          }
        },
        child: ListView.separated(
          itemBuilder: (context, index) {
            final passanger = passangerProvider.listData[index];
            return ListTile(
              title: Text(passanger.name),
              subtitle: Text(passanger.airline[0].country),
              trailing: Text(passanger.airline[0].name),
            );
          },
          separatorBuilder: (context, index) => const Divider(),
          itemCount: passangerProvider.listData.length,
        ),
      ),
    );
  }
}
