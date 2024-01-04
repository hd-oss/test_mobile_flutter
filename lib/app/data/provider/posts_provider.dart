import '../model/post_model.dart';
import 'http_provider.dart';

class PostsProvider extends HttpProvider {
  PostsProvider() {
    super.onInit();
  }
  Future<List<PostModel>> getMyPost() async {
    try {
      final response = await get('posts', headers: {
        'Content-Type': "application/json",
      });
      if (response.status.hasError) {
        return Future.error(handleResponse(response));
      } else {
        List<PostModel> listMyPosts = [];
        final postsFromApi = response.body;
        for (var data in postsFromApi) {
          listMyPosts.add(PostModel.fromJson(data));
        }
        return listMyPosts;
      }
    } catch (exception) {
      return Future.error(exception.toString());
    }
  }

  Future<PostModel> getMyPostById(String id) async {
    try {
      final response = await get('/mypatrol/$id', headers: {
        'Content-Type': "application/json",
      });
      if (response.status.hasError) {
        return Future.error(handleResponse(response));
      } else {
        return PostModel.fromJson(response.body['data']);
      }
    } catch (exception) {
      return Future.error(exception.toString());
    }
  }

  Future<dynamic> deletePostById({required String id}) async {
    try {
      print(id);
      final response = await delete('posts/$id');

      print(response.body);

      // if (response.status.hasError) {
      //   return Future.value(response.body['error']['message']);
      // } else {
      //   return Future.value(response.body['data']['message']);
      // }
    } catch (exception) {
      print(exception);
      return Future.error(exception.toString());
    }
  }

  Future<String> editMyPost({
    required Map<String, dynamic> body,
    required String id,
  }) async {
    try {
      final response = await put('posts/$id', body);
      print(response.body);
      if (response.status.hasError) {
        return Future.value('Something is wrong');
      } else {
        return Future.value('successfully created a post');
      }
    } catch (exception) {
      print(exception);
      return Future.error(exception.toString());
    }
  }

  Future<String> addMyPost({
    required Map<String, dynamic> body,
  }) async {
    try {
      final response = await post('posts', body);
      print(response.body);
      if (response.status.hasError) {
        return Future.value('Something is wrong');
      } else {
        return Future.value('successfully created a post');
      }
    } catch (exception) {
      print(exception);
      return Future.error(exception.toString());
    }
  }
}
