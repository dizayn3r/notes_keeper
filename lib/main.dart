import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes_keeper/database/database.dart';
import 'package:notes_keeper/ui/screen/note_list_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => AppDatabase(),
      child:MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.deepOrange,
          textTheme: TextTheme(
            headline5: GoogleFonts.quicksand(
              fontWeight:FontWeight.bold,
              color:Colors.black,
              fontSize: 24,
            ),
            bodyText2: GoogleFonts.quicksand(
              fontWeight:FontWeight.bold,
              color:Colors.black,
              fontSize: 20,
            ),
            bodyText1: GoogleFonts.quicksand(
              fontWeight:FontWeight.normal,
              color:Colors.black,
              fontSize: 18,
            ),
            subtitle2: GoogleFonts.quicksand(
              fontWeight:FontWeight.normal,
              color:Colors.black,
              fontSize: 14,
            ),
          ),
        ),
        home: const NoteListPage(),
      ),
    );

  }
}