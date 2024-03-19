import 'package:asf_flutter_common/asf_flutter_common.dart';
import 'package:flutter/material.dart';
import '../data/model/post.dart';

class PostListTile extends StatelessWidget {
  final Post post;
  final VoidCallback? onTap;
  const PostListTile({super.key, required this.post, this.onTap});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: this.onTap,
      leading: CircleAvatar(
        // Immagine del profilo dell'utente
        backgroundImage: NetworkImage(post.placeholderImageUrl),
      ),
      title: Text(post.title), // Nome utente
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(post.body), // Testo del post
          SizedBox(height: 8),
          Text(DateFormats.baseInformations().format(post.creationDate)), // Data del post
        ],
      ),
    );
  }
}
