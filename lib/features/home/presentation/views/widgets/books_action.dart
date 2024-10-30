import 'package:bookly_app/core/utils/functions/launch_url.dart';
import 'package:bookly_app/core/widgets/custom_button.dart';
import 'package:bookly_app/features/home/data/models/book_model/book_model.dart';
import 'package:flutter/material.dart';

class BooksAction extends StatelessWidget {
  const BooksAction({super.key, required this.book});
  final BookModel book;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 38,
        vertical: 37,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: CustomButton(
              onPressed: () {
                launchCustomURL(
                  context,
                  book.accessInfo!.pdf!.acsTokenLink!,
                );
              },
              backgroundColor: Colors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                bottomLeft: Radius.circular(16),
              ),
              text: getFree(book),
              textColor: Colors.black,
              fontSize: getFree(book) == "Free" ? 20 : 16,
            ),
          ),
          Expanded(
            child: CustomButton(
              onPressed: () {
                launchCustomURL(
                  context,
                  book.volumeInfo.previewLink,
                );
              },
              backgroundColor: const Color(0xffEF8262),
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
              text: getPreview(book),
              textColor: Colors.white,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  String getPreview(BookModel book) {
    if (book.volumeInfo.previewLink == null) {
      return "Not Available";
    } else {
      return "Preview";
    }
  }

  String getFree(BookModel book) {
    if (!book.accessInfo!.pdf!.isAvailable!) {
      return "Not Available";
    } else {
      return "Free";
    }
  }
}
