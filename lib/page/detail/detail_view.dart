import 'package:flutter/material.dart';
import 'package:flutter_networks/model/comment_model.dart';
import 'package:flutter_networks/model/post_model.dart';
import 'package:flutter_networks/service/network_src.dart';

class DetailView extends StatefulWidget {
  const DetailView({super.key});

  @override
  State<DetailView> createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> {
  late Map<String, dynamic> data;
  int? postId = 0;
  @override
  void didChangeDependencies() {
    data = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    if (data.containsKey('postId') && data['postId'] != null) {
      postId = data['postId'];
      setState(() {});
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Detail'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const Text(
                'Post',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: Colors.blue),
              ),
              FutureBuilder<PostModel>(
                future: NetworkSrc.getSinglePostsUsingGetMethod(postId: postId),
                initialData: PostModel.fromJson({}),
                builder: (context, AsyncSnapshot<PostModel> snapshot) {
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
                  PostModel? post = snapshot.data!;
                  return Card(
                    child: ListTile(
                      onTap: () {},
                      title: Text(post.title ?? 'title'),
                      subtitle: Text(post.body ?? 'body'),
                    ),
                  );
                },
              ),
              const Text(
                'Comments',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: Colors.blue),
              ),
              FutureBuilder<List<CommentModel>>(
                future: NetworkSrc.getSinglePostCommentsUsingGetMethod(
                    postId: postId!),
                initialData: [CommentModel.fromJson({})],
                builder: (context, AsyncSnapshot<List<CommentModel>> snapshot) {
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
                      primary: false,
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        CommentModel? comment = snapshot.data![index];
                        return Card(
                          child: ListTile(
                            onTap: () {},
                            title: Text(comment.email ?? 'title'),
                            subtitle: Text(comment.body ?? 'body'),
                          ),
                        );
                      });
                },
              ),
            ],
          ),
        ));
  }
}
