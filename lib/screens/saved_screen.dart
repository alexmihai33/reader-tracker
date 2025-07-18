import 'package:flutter/material.dart';
import 'package:reader_tracker/db/database_helper.dart';
import 'package:reader_tracker/models/book.dart';
import 'package:reader_tracker/utils/book_details_arguments.dart';

class SavedScreen extends StatefulWidget {
  const SavedScreen({super.key});

  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Book>>(
        future: DatabaseHelper.instance.readAllBooks(),
        builder: (context, snapshot) => snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  Book book = snapshot.data![index];
                  return InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/details',
                        arguments: BookDetailsArguments(
                          itemBook: book,
                          isFromSavedScreen: true,
                        ),
                      );
                    },
                    child: Card(
                      child: ListTile(
                        title: Text(book.title),
                        trailing: IconButton(
                          onPressed: () async {
                            await DatabaseHelper.instance.deleteBook(book.id);
                            setState(() {});
                          },
                          icon: Icon(Icons.delete),
                        ),
                        leading: Image.network(
                          book.imageLinks['thumbnail'] ?? '',
                          fit: BoxFit.cover,
                        ),
                        subtitle: Column(
                          children: [
                            Text(book.authors.join(", & ")),
                            ElevatedButton.icon(
                              onPressed: () async {
                                book.isFavorite = !book.isFavorite;
                                await DatabaseHelper.instance
                                    .toggleFavoriteStatus(
                                      book.id,
                                      book.isFavorite,
                                    );
                                    setState(() {
                                      
                                    });
                                SnackBar snackBar = const SnackBar(
                                  content: Text("Added to Favorite"),
                                );
                                ScaffoldMessenger.of(
                                  context,
                                ).showSnackBar(snackBar);
                              },
                              icon: Icon(
                                book.isFavorite
                                    ? Icons.favorite
                                    : Icons.favorite_outline,
                                color: book.isFavorite ? Colors.red : null,
                              ),
                              label: Text(book.isFavorite ? "Favorite" : "Add to Favorites"),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              )
            : Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
