import 'package:bookly_app/core/utils/styles.dart';
import 'package:bookly_app/features/search/presentation/manager/search_book_cubit/search_books_cubit.dart';
import 'package:bookly_app/features/search/presentation/views/widgets/custom_search_text_field.dart';
import 'package:bookly_app/features/search/presentation/views/widgets/search_result_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchViewBody extends StatelessWidget {
  const SearchViewBody({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 30,
        vertical: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomSearchTextField(
            onChanged: (value) async {
              await BlocProvider.of<SearchBooksCubit>(context)
                  .searchBooks(bookTitle: value);

              if (value == "") {
                // ignore: use_build_context_synchronously
                BlocProvider.of<SearchBooksCubit>(context).bookResults!.clear();
              }
            },
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "Results",
            style: Styles.textStyle18,
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: SearchResultListView(
              books:
                  BlocProvider.of<SearchBooksCubit>(context).bookResults ?? [],
            ),
          ),
        ],
      ),
    );
  }
}
