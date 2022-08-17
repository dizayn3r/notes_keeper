import 'package:drift/drift.dart' as dr;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../database/database.dart';
import '../../utlis/color_picker.dart';
import '../../utlis/priority_picker.dart';

class NoteDetailPage extends StatefulWidget {
  final String title;
  final NoteCompanion noteCompanion;
  const NoteDetailPage(
      {Key? key, required this.title, required this.noteCompanion})
      : super(key: key);

  @override
  _NoteDetailPageState createState() => _NoteDetailPageState();
}

class _NoteDetailPageState extends State<NoteDetailPage> {
  late AppDatabase appDatabase;
  late TextEditingController titleEditingController;
  late TextEditingController descriptionEditingController;
  int priorityLevel = 0;
  int colorLevel = 0;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    titleEditingController = TextEditingController();
    descriptionEditingController = TextEditingController();
    titleEditingController.text = widget.noteCompanion.title.value;
    descriptionEditingController.text = widget.noteCompanion.description.value;
    priorityLevel = widget.noteCompanion.priority.value!;
    colorLevel = widget.noteCompanion.color.value!;
    super.initState();
  }

  @override
  void dispose() {
    titleEditingController.dispose();
    descriptionEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    appDatabase = Provider.of<AppDatabase>(context);

    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        double w = (sizingInformation.screenSize.width / 100).roundToDouble();
        return Scaffold(
          backgroundColor: colors[colorLevel],
          appBar: _getDetailAppBar(),
          body: Padding(
            padding: EdgeInsets.all(w * 2),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  PriorityPicker(
                    index: priorityLevel,
                    onTap: (selectedIndex) {
                      priorityLevel = selectedIndex;
                    },
                  ),
                  SizedBox(height: w * 2),
                  ColorPicker(
                    index: colorLevel,
                    onTap: (selectedColor) {
                      colorLevel = selectedColor;
                      setState(() {});
                    },
                  ),
                  SizedBox(height: w * 4),
                  TextFormField(
                    controller: titleEditingController,
                    minLines: 1,
                    keyboardType: TextInputType.text,
                    style: Theme.of(context).textTheme.bodyText2,
                    decoration: InputDecoration(
                      hintText: "Note Title",
                      hintStyle: Theme.of(context).textTheme.bodyText2,
                      alignLabelWithHint: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(w * 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(w * 2),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter some data...";
                      }
                      return titleEditingController.text = value.trim();
                    },
                    onSaved: (value) {
                      titleEditingController.text = value!.trim();
                    },
                  ),
                  SizedBox(height: w * 3),
                  TextFormField(
                    controller: descriptionEditingController,
                    minLines: 1,
                    maxLines: 10,
                    maxLength: 500,
                    keyboardType: TextInputType.text,
                    style: Theme.of(context).textTheme.bodyText2,
                    decoration: InputDecoration(
                      hintText: "Description",
                      hintStyle: Theme.of(context).textTheme.bodyText2,
                      alignLabelWithHint: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(w * 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(w * 2),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter some data...";
                      }
                      return descriptionEditingController.text = value.trim();
                    },
                    onSaved: (value) {
                      descriptionEditingController.text = value!.trim();
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  _getDetailAppBar() {
    return AppBar(
      backgroundColor: colors[colorLevel],
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(
          Icons.chevron_left_outlined,
          color: Colors.black,
        ),
      ),
      title: Text(
        widget.title,
        style: const TextStyle(color: Colors.black),
      ),
      actions: [
        IconButton(
          onPressed: () {
            _saveToDb();
          },
          icon: const Icon(
            Icons.save,
            color: Colors.black,
          ),
        ),
        IconButton(
          onPressed: () {
            _deleteNotes();
          },
          icon: const Icon(
            Icons.delete,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  void _saveToDb() {
    final isValid = _formKey.currentState!.validate();
    if (isValid != null) {
      if (widget.noteCompanion.id.present) {
        appDatabase
            .updateNote(NoteData(
                id: widget.noteCompanion.id.value,
                title: titleEditingController.text,
                description: descriptionEditingController.text,
                color: colorLevel,
                priority: priorityLevel,
                date: DateFormat.yMMMd().format(DateTime.now())))
            .then((value) {
          Navigator.pop(context, true);
        });
      } else {
        appDatabase
            .insertNote(NoteCompanion(
                title: dr.Value(titleEditingController.text),
                description: dr.Value(descriptionEditingController.text),
                color: dr.Value(colorLevel),
                priority: dr.Value(priorityLevel),
                date: dr.Value(DateFormat.yMMMd().format(DateTime.now()))))
            .then((value) {
          Navigator.pop(context, true);
        });
      }
    }
  }

  void _deleteNotes() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Note?'),
          content: const Text('Do you really want to delete this note'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                appDatabase
                    .deleteNote(
                  NoteData(
                    id: widget.noteCompanion.id.value,
                    title: widget.noteCompanion.title.value,
                    description: widget.noteCompanion.description.value,
                    date: DateFormat.yMMMd().format(
                      DateTime.now(),
                    ),
                  ),
                )
                    .then((value) {
                  Navigator.pop(context, true);
                });
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
