import 'package:flutter/material.dart';
import 'package:drift/drift.dart' as drift;
import 'package:responsive_builder/responsive_builder.dart';

import '../../../../database/database.dart';
import '../../../../utlis/color_picker.dart';
import '../../note_detail_page.dart';

enum TileType {
  square,
  verRect,
  horRect,
}

class NoteGridTile extends StatefulWidget {
  final NoteData noteData;
  final TileType tileType;

  const NoteGridTile({
    Key? key,
    required this.noteData,
    required this.tileType,
  }) : super(key: key);

  @override
  State<NoteGridTile> createState() => _NoteGridTileState();
}

class _NoteGridTileState extends State<NoteGridTile> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (context, sizingInformation) {
      double w = (sizingInformation.screenSize.width / 100).roundToDouble();
      return GestureDetector(
        onTap: () {
          _navigateToDetail(
            'Edit Note',
            NoteCompanion(
              id: drift.Value(widget.noteData.id),
              title: drift.Value(widget.noteData.title),
              description: drift.Value(widget.noteData.description),
              priority: drift.Value(widget.noteData.priority),
              color: drift.Value(widget.noteData.color),
            ),
          );
        },
        child: Card(
          elevation: 2.0,
          color: colors[widget.noteData.color!],
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
                        widget.noteData.title,
                        maxLines: _getMaxLines(widget.tileType),
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            color: Colors.grey.shade900,
                            fontSize: _getTxtSize(widget.tileType)),
                      ),
                    ),
                    Text(
                      _getPriority(widget.noteData.priority!),
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
                    widget.noteData.description,
                    maxLines: _getMaxLines(widget.tileType),
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: _getTxtSize(widget.tileType),
                          overflow: TextOverflow.ellipsis,
                        ),
                  ),
                ),
                SizedBox(height: w*2),
                Container(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    widget.noteData.date,
                    textAlign: TextAlign.end,
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
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

  _getTxtSize(TileType tileType) {
    switch (tileType) {
      case TileType.square:
        return 20.0;
      case TileType.verRect:
        return 24.0;
      case TileType.horRect:
        return 24.0;
    }
  }

  _getMaxLines(TileType tileType) {
    switch (tileType) {
      case TileType.square:
        return 4;
      case TileType.verRect:
        return 6;
      case TileType.horRect:
        return 3;
    }
  }
}
