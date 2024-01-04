import 'package:get/get.dart';
import 'package:test_mobile_flutter/app/data/model/post_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../data/repository/posts_repository.dart';

class HomeController extends GetxController {
  final repository = PostsRepository();

  RefreshController postRefreshConroller = RefreshController();
  final postModelList = <PostModel>[].obs;
  final isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    getDataHistoryPatrol();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> getDataHistoryPatrol() async {
    try {
      final response = await repository.getMyPost();
      postModelList.addAll(response);

      postRefreshConroller.loadComplete();
      isLoading(false);
      update();
    } catch (e) {
      postRefreshConroller.loadNoData();
      isLoading(false);
      update();
    }
  }

  void onPostRefresh() async {
    postModelList.clear();
    isLoading(true);
    update();
    await Future.delayed(const Duration(seconds: 1));
    getDataHistoryPatrol();
    postRefreshConroller.refreshCompleted();
  }

  void onPostLoad() async {
    await Future.delayed(const Duration(seconds: 1));
    getDataHistoryPatrol();
  }

  Future<void> deletePost(String id) async {
    try {
      final response = await repository.deletePostById(id);
      onPostRefresh();
      postRefreshConroller.loadComplete();
      isLoading(false);
      update();
    } catch (e) {
      postRefreshConroller.loadNoData();
      isLoading(false);
      update();
    }
  }
}
