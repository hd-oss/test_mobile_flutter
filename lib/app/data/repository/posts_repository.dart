import '../model/post_model.dart';
import '../provider/posts_provider.dart';

class PostsRepository {
  final PostsProvider _upgradingProvider = PostsProvider();

  /// Method : GET
  Future<List<PostModel>> getMyPost() => _upgradingProvider.getMyPost();
  Future<PostModel> getMyPostById(String id) =>
      _upgradingProvider.getMyPostById(id);
  Future<dynamic> deletePostById(String id) =>
      _upgradingProvider.deletePostById(id: id);
  Future<String> editMyPost(dynamic id, Map<String, dynamic> body) =>
      _upgradingProvider.editMyPost(id: id, body: body);
  Future<String> addMyPost(Map<String, dynamic> body) =>
      _upgradingProvider.addMyPost(body: body);
}
