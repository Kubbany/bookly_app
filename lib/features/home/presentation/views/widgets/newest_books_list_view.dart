import 'package:bookly_app/core/widgets/custom_error_widget.dart';
import 'package:bookly_app/features/home/presentation/manager/newest_books_cubit/newest_books_cubit.dart';
import 'package:bookly_app/features/home/presentation/views/widgets/book_list_view_item.dart';
import 'package:bookly_app/features/home/presentation/views/widgets/dummy_book_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class NewestBooksListView extends StatelessWidget {
  const NewestBooksListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewestBooksCubit, NewestBooksState>(
      builder: (context, state) {
        if (state is NewestBooksSuccess) {
          return SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: state.books.length,
              (context, index) => Padding(
                padding: const EdgeInsets.only(
                  bottom: 15,
                  top: 5,
                  left: 30,
                  right: 30,
                ),
                child: BookListViewItem(
                  book: state.books[index],
                ),
              ),
            ),
          );
        } else if (state is NewestBooksFailure) {
          return SliverFillRemaining(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
              ),
              child: Center(
                child: CustomErrorWidget(
                  errorMessage: state.errorMessage,
                ),
              ),
            ),
          );
        } else {
          return SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: 6,
              (context, index) => const Padding(
                padding: EdgeInsets.only(
                  bottom: 15,
                  top: 5,
                  left: 30,
                  right: 30,
                ),
                child: Skeletonizer(
                  child: DummyBookItem(),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
