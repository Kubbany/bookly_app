import 'package:bookly_app/core/utils/app_router.dart';
import 'package:bookly_app/core/widgets/custom_error_widget.dart';
import 'package:bookly_app/features/home/presentation/manager/similar_books_cubit/similar_books_cubit.dart';
import 'package:bookly_app/features/home/presentation/views/widgets/custom_book_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SimilarBooksListView extends StatelessWidget {
  const SimilarBooksListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SimilarBooksCubit, SimilarBooksState>(
      builder: (context, state) {
        if (state is SimilarBooksSuccess) {
          return Padding(
            padding: const EdgeInsets.only(
              left: 30,
              top: 10,
            ),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.17,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: state.books.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.only(
                    top: 8,
                    bottom: 8,
                    right: 10,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      GoRouter.of(context).push(
                        AppRouter.kBookDetailsView,
                        extra: state.books[index],
                      );
                    },
                    child: CustomBookImage(
                      aspectRatio: 0.6,
                      borderRadius: 16,
                      imageUrl:
                          state.books[index].volumeInfo.imageLinks?.thumbnail ??
                              "",
                    ),
                  ),
                ),
              ),
            ),
          );
        } else if (state is SimilarBooksFailure) {
          return Center(
            child: CustomErrorWidget(
              errorMessage: state.errorMessage,
            ),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.only(
              left: 30,
              top: 10,
            ),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.17,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) => const Padding(
                  padding: EdgeInsets.only(
                    top: 8,
                    bottom: 8,
                    right: 10,
                  ),
                  child: Skeletonizer(
                    child: CustomBookImage(
                      aspectRatio: 0.6,
                      borderRadius: 16,
                      imageUrl: "https://i.imgur.com/OB0y6MR.jpg",
                    ),
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
