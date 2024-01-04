import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../routes/app_pages.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post Apps'),
        centerTitle: true,
      ),
      body: GetBuilder<HomeController>(
        builder: (controller) => controller.isLoading.isTrue
            ? Center(
                child: GetPlatform.isIOS
                    ? const CupertinoActivityIndicator()
                    : const CircularProgressIndicator(),
              )
            : SmartRefresher(
                controller: controller.postRefreshConroller,
                enablePullUp: true,
                enablePullDown: true,
                onRefresh: controller.onPostRefresh,
                onLoading: controller.onPostLoad,
                footer: CustomFooter(
                  builder: (context, mode) {
                    Widget body;
                    if (mode == LoadStatus.idle) {
                      body = const Text("Tarik keatas ");
                    } else if (mode == LoadStatus.loading) {
                      body = GetPlatform.isIOS
                          ? const CupertinoActivityIndicator()
                          : const CircularProgressIndicator();
                    } else if (mode == LoadStatus.failed) {
                      body = const Text("Gagal menampilkan");
                    } else if (mode == LoadStatus.canLoading) {
                      body = const Text("Lepas untuk menampilkan");
                    } else {
                      body = const Text('');
                    }
                    return SizedBox(
                      height: 55.0,
                      child: Center(child: body),
                    );
                  },
                ),
                child: ListView.builder(
                  itemCount: controller.postModelList.length,
                  physics: const ScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    var data = controller.postModelList[index];
                    var decs = data.body;
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          onTap: () => Get.toNamed(
                            Routes.FORM,
                            arguments: data,
                            parameters: {'state': 'edit_post'},
                          ),
                          title: Text(
                            '${data.title}',
                            style: const TextStyle(fontSize: 20),
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: Text(decs!.length > 50
                              ? '${decs.substring(0, 50)}...'
                              : decs),
                          trailing: InkWell(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(50.0),
                            ),
                            onTap: () =>
                                controller.deletePost(data.id.toString()),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.delete_forever_rounded,
                                size: 40,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () =>
            Get.toNamed(Routes.FORM, parameters: {'state': 'add_post'}),
      ),
    );
  }
}
