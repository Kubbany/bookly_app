import 'package:bookly_app/features/home/data/models/book_model/book_model.dart';
import 'package:bookly_app/features/search/data/repos/search_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'search_books_state.dart';

class SearchBooksCubit extends Cubit<SearchBooksState> {
  SearchBooksCubit(this.searchRepo) : super(SearchBooksInitial());
  final SearchRepo searchRepo;
  List<BookModel>? bookResults;
  Future<void> searchBooks({required String bookTitle}) async {
    emit(SearchBooksLoading());
    var result = await searchRepo.searchBook(bookTitle: bookTitle);
    result.fold(
        (failure) => emit(
              SearchBooksFailure(errorMessage: failure.errorMessage),
            ), (books) {
      bookResults = books;
      emit(SearchBooksSuccess(books: books));
    });
  }
}
