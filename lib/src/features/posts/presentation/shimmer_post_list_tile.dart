import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerPostListTile extends StatelessWidget {
  const ShimmerPostListTile();
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: CircleAvatar(
          backgroundColor: Colors.white,
          radius: 25,
        ),
      ),
      title: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          height: 12,
          color: Colors.white,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: 12,
              color: Colors.white,
              margin: EdgeInsets.only(top: 8),
            ),
          ),
          SizedBox(height: 8),
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: 12,
              color: Colors.white,
              width: 80,
            ),
          ),
        ],
      ),
    );
  }
}