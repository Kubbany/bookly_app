import 'package:bookly_app/core/utils/styles.dart';
import 'package:bookly_app/core/widgets/custom_error_widget.dart';
import 'package:bookly_app/features/home/data/models/book_model/book_model.dart';
import 'package:bookly_app/features/home/presentation/views/widgets/book_list_view_item.dart';
import 'package:bookly_app/features/home/presentation/views/widgets/dummy_book_item.dart';
import 'package:bookly_app/features/search/presentation/manager/search_book_cubit/search_books_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SearchResultListView extends StatelessWidget {
  const SearchResultListView({super.key, required this.books});
  final List<BookModel> books;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBooksCubit, SearchBooksState>(
      builder: (context, state) {
        if (state is SearchBooksInitial || books == []) {
          return const Center(
            child: Text(
              "Start Searching",
              style: Styles.textStyle20,
              textAlign: TextAlign.center,
            ),
          );
        } else if (state is SearchBooksSuccess) {
          return state.books.isEmpty
              ? const Center(
                  child: Text(
                    "Start Searching",
                    style: Styles.textStyle20,
                    textAlign: TextAlign.center,
                  ),
                )
              : ListView.builder(
                  itemCount: state.books.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                        bottom: 15,
                        top: 5,
                      ),
                      child: BookListViewItem(
                        book: state.books[index],
                      ),
                    );
                  },
                );
        } else if (state is SearchBooksFailure) {
          return Center(
            child: CustomErrorWidget(
              errorMessage: state.errorMessage,
            ),
          );
        } else {
          return Skeletonizer(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return const Padding(
                  padding: EdgeInsets.only(
                    bottom: 15,
                    top: 5,
                  ),
                  child: DummyBookItem(),
                );
              },
            ),
          );
        }
      },
    );
  }
}
