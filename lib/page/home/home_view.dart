import 'package:flutter/material.dart';
import 'package:flutter_networks/model/post_model.dart';
import 'package:flutter_networks/service/network_src.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  void navigateToDetail({required int postId}) {
    Navigator.of(context).pushNamed('/detail', arguments: {'postId': postId});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
      ),
      body: FutureBuilder<List<PostModel>>(
        future: NetworkSrc.getPostsUsingGetMethod(),
        initialData: [PostModel.fromJson({})],
        builder: (context, AsyncSnapshot<List<PostModel>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!snapshot.hasData || snapshot.hasError) {
            return const Center(
              child: Text('you have an error or you have not data'),
            );
          }

          return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                PostModel? post = snapshot.data![index];
                return Card(
                  child: ListTile(
                    onTap: () {
                      navigateToDetail(postId: post.id ?? 1);
                    },
                    title: Text(post.title ?? 'title'),
                    subtitle: Text(post.body ?? 'body'),
                  ),
                );
              });
        },
      ),
    );
  }
}
