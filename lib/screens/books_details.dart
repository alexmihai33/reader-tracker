import 'package:flutter/material.dart';
import 'package:reader_tracker/db/database_helper.dart';
import 'package:reader_tracker/models/book.dart';
import 'package:reader_tracker/utils/book_details_arguments.dart';
import 'package:reader_tracker/widgets/book_thumbnail.dart';

class BookDetailsScren extends StatefulWidget {
  const BookDetailsScren({super.key});

  @override
  State<BookDetailsScren> createState() => _BookDetailsScrenState();
}

class _BookDetailsScrenState extends State<BookDetailsScren> {
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as BookDetailsArguments;
    final Book book = args.itemBook;
    final bool isFromSavedScreen = args.isFromSavedScreen;
    final theme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: Text(book.title)),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              BookThumbnail(book: book),
              Column(
                children: [
                  Text(
                    book.title,
                    style: theme.headlineSmall,
                    textAlign: TextAlign.center,
                  ),
                  Text(book.authors.join(', & '), style: theme.labelLarge),
                  Text(
                    'Published: ${book.publishedDate}',
                    style: theme.bodySmall,
                  ),
                  Text('Page count: ${book.pageCount}', style: theme.bodySmall),
                  Text('Language: ${book.language}', style: theme.bodySmall),
                  SizedBox(height: 10),
                  SizedBox(
                    child: !isFromSavedScreen
                        ? ElevatedButton(
                            onPressed: () async {
                              try {
                                await DatabaseHelper.instance.insert(book);
                                SnackBar snackBar = const SnackBar(
                                  content: Text("Book Saved"),
                                );
                                ScaffoldMessenger.of(
                                  context,
                                ).showSnackBar(snackBar);
                              } catch (e) {
                                print("Error: $e");
                              }
                            },
                            child: Text("Save"),
                          )
                        : ElevatedButton.icon(
                            onPressed: () async {
                              try {
                                await DatabaseHelper.instance
                                    .toggleFavoriteStatus(
                                      book.id,
                                      book.isFavorite,
                                    );
                                SnackBar snackBar = const SnackBar(
                                  content: Text("Added to Favorite"),
                                );
                                ScaffoldMessenger.of(
                                  context,
                                ).showSnackBar(snackBar);
                              } catch (e) {
                                print(e);
                              }
                            },
                            label: Text("Favorite"),
                            icon: Icon(Icons.favorite),
                          ),
                  ),
                  //     !isFromSavedScreen ? ElevatedButton(
                  //       onPressed: () async {
                  //         try {
                  //           await DatabaseHelper.instance.insert(
                  //             book,
                  //           );
                  //           SnackBar snackBar = const SnackBar(
                  //             content: Text("Book Saved"),
                  //           );
                  //           ScaffoldMessenger.of(
                  //             context,
                  //           ).showSnackBar(snackBar);
                  //         } catch (e) {
                  //           print("Error: $e");
                  //         }
                  //       },
                  //       child: Text("Save"),
                  //     ) : const SizedBox(),
                  //     ElevatedButton.icon(
                  //       onPressed: () async {
                  //         try{
                  //           await DatabaseHelper.instance.toggleFavoriteStatus(book.id, book.isFavorite);
                  //           SnackBar snackBar = const SnackBar(content: Text("Added to Favorite"),);
                  //           ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  //         }catch (e){
                  //           print(e);
                  //         }
                  //       },
                  //       label: Text("Favorite"),
                  //       icon: Icon(Icons.favorite),
                  //     ),
                  //   ],
                  const SizedBox(height: 10),
                  Text("Description", style: theme.titleMedium),
                  const SizedBox(height: 10),
                  Container(
                    margin: EdgeInsets.all(8.0),
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Theme.of(
                        context,
                      ).colorScheme.secondary.withOpacity(0.1),
                      border: Border.all(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Text(book.description, textAlign: TextAlign.justify),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
