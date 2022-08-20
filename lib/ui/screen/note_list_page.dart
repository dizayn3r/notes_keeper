import 'package:flutter/material.dart';
import 'package:drift/drift.dart' as drift;
import 'package:grid_staggered_lite/grid_staggered_lite.dart';
import 'package:notes_keeper/ui/screen/setting_screen.dart';
import 'package:notes_keeper/utlis/color_picker.dart';
import 'package:notes_keeper/database/database.dart';
import 'package:notes_keeper/ui/screen/note_detail_page.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';


enum TileType{
  square,
  horRect,
  verRect,
}

class NoteListPage extends StatefulWidget {
  const NoteListPage({Key? key}) : super(key: key);

  @override
  _NoteListPageState createState() => _NoteListPageState();
}

class _NoteListPageState extends State<NoteListPage> {
  late AppDatabase database;
  late IconData view;
  late List viewType;
  late bool isList;

  final _gridCounts = [
    const StaggeredTile.count(4, 4),
    const StaggeredTile.count(4, 4),
    const StaggeredTile.count(8, 4),
    const StaggeredTile.count(4, 6),
    const StaggeredTile.count(4, 4),
    const StaggeredTile.count(4, 6),
    const StaggeredTile.count(4, 4),
  ];

  final _tileTypes = [
    TileType.square,
    TileType.square,
    TileType.horRect,
    TileType.verRect,
    TileType.square,
    TileType.verRect,
    TileType.square,
  ];

  void viewChange() {
    setState(() {
      isList = !isList;
      view = isList == true ? Icons.menu_rounded : Icons.grid_view_rounded;
    });
  }

  @override
  void initState() {
    isList = false;
    view = Icons.grid_view_rounded;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    database = Provider.of<AppDatabase>(context);
    return ResponsiveBuilder(builder: (context, sizingInformation) {
      double w = (sizingInformation.screenSize.width / 100).roundToDouble();
      return Scaffold(
        appBar: _appBar,
        body: _body(w),
        floatingActionButton: FloatingActionButton.extended(
          label: const Text('Add Note'),
          onPressed: () {
            _navigateToDetail(
              'Add Note',
              const NoteCompanion(
                title: drift.Value(''),
                description: drift.Value(''),
                color: drift.Value(0),
                priority: drift.Value(0),
              ),
            );
          },
          icon: const Icon(
            Icons.add_rounded,
          ),
        ),
      );
    });
  }

  Future<List<NoteData>> _getNoteFromDatabase() async {
    return await database.getNoteList();
  }

  //AppBar
  AppBar get _appBar {
    return AppBar(
      title: const Text('Notes'),
      actions: [
        IconButton(
          icon: Icon(view),
          onPressed: viewChange,
        ),
        IconButton(
          icon: const Icon(Icons.settings_rounded),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const SettingScreen(),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _body(double w) {
    return FutureBuilder<List<NoteData>>(
      future: _getNoteFromDatabase(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<NoteData>? noteList = snapshot.data;
          if (noteList != null) {
            if (noteList.isEmpty) {
              return Center(
                child: Text(
                  'No Notes Found, Click on add button to add new note',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              );
            } else {
              return StaggeredGridView.countBuilder(
                itemCount: noteList.length,
                padding: EdgeInsets.all(w * 3),
                crossAxisCount: 8,
                itemBuilder: (context, index) {
                  NoteData noteData = noteList[index];
                  TileType tileType = _tileTypes[index % 7];
                  return GestureDetector(
                    onTap: () {
                      _navigateToDetail(
                        'Edit Note',
                        NoteCompanion(
                          id: drift.Value(noteData.id),
                          title: drift.Value(noteData.title),
                          description: drift.Value(noteData.description),
                          priority: drift.Value(noteData.priority),
                          color: drift.Value(noteData.color),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 2.0,
                      color: colors[noteData.color!],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(w * 4),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(w * 2),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    noteData.title,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(color: Colors.grey.shade900),
                                  ),
                                ),
                                Text(
                                  _getPriority(noteData.priority!),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(color: Colors.grey.shade900),
                                )
                              ],
                            ),
                            Divider(height: w * 2, color: Colors.grey.shade900),
                            Expanded(
                              child: Text(
                                noteData.description,
                                maxLines: _getMaxLines(tileType),
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                      overflow: TextOverflow.ellipsis,
                                    ),
                              ),
                            ),
                            SizedBox(height: w * 2),
                            Container(
                              alignment: Alignment.bottomRight,
                              child: Text(
                                noteData.date,
                                textAlign: TextAlign.end,
                                style: Theme.of(context).textTheme.subtitle2,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                staggeredTileBuilder: (index) => isList == false
                    ? _gridCounts[index % 7]
                    : StaggeredTile.count(8, 4),
              );
            }
          }
        } else if (snapshot.hasError) {
          return Center(
            child: Text(
              snapshot.error.toString(),
              style: Theme.of(context).textTheme.bodyText2,
            ),
          );
        }
        return Center(
          child: Text(
            'Click on add button to add new note',
            style: Theme.of(context).textTheme.bodyText2,
          ),
        );
      },
    );
  }

  _navigateToDetail(String title, NoteCompanion noteCompanion) async {
    var res = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NoteDetailPage(
          title: title,
          noteCompanion: noteCompanion,
        ),
      ),
    );
    if (res != null && res == true) {
      setState(() {});
    }
  }

  String _getPriority(int p) {
    switch (p) {
      case 2:
        return '!!!';
      case 1:
        return '!!';
      default:
        return '!';
    }
  }

  _getMaxLines(TileType tileType) {
    switch (tileType) {
      case TileType.square:
        return 4;
      case TileType.verRect:
        return 8;
      case TileType.horRect:
        return 4;
    }
  }

  // _getColor(int priority) {
  //   switch (priority) {
  //     case 2:
  //       return Colors.red;
  //     case 1:
  //       return Colors.orange;
  //     default:
  //       return Colors.green;
  //   }
  // }
}
