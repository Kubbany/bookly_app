import 'package:bookly_app/core/utils/styles.dart';
import 'package:bookly_app/features/home/presentation/views/widgets/similar_books_list_view.dart';
import 'package:flutter/material.dart';

class SimilarBooksSection extends StatelessWidget {
  const SimilarBooksSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 30,
          ),
          child: Text(
            "You can also like",
            style: Styles.textStyle16.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SimilarBooksListView(),
      ],
    );
  }
}
