import 'dart:io';

import 'package:camera_camera/camera_camera.dart';
import 'package:labeta/utils/generators.dart';
import 'package:labeta/utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NewBoulderBasicInput extends StatefulWidget {
  final Function onCancel;

  const NewBoulderBasicInput({super.key, required this.onCancel});

  @override
  State<NewBoulderBasicInput> createState() => _NewBoulderBasicInputState();
}

class _NewBoulderBasicInputState extends State<NewBoulderBasicInput> {
  final formKey = GlobalKey<FormState>(debugLabel: 'Login Form');
  File? currentImageFile;
  String? grade;
  String name = '';

  void handleSubmit() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
    }
  }

  bool areFieldsCompleted() {
    return name.isNotEmpty;
  }

  Widget buildBoulderNameInput() {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: TextFormField(
        onChanged: (value) {
          setState(() {
            name = value;
          });
        },
        validator: Validators.validatePrintable,
        decoration:
            const InputDecoration(hintText: 'Amazing boulder', labelText: 'Name'),
      ),
    );
  }

  Widget buildBoulderGradeInput() {
    return Padding(
        padding: const EdgeInsets.only(top: 8),
        child: DropdownButtonFormField(
          decoration: const InputDecoration(labelText: 'Grade'),
          items: generateNaturals(16).map((int integer) {
            final grade = 'V$integer';
            return DropdownMenuItem(child: Text(grade), value: grade);
          }).toList(),
          onChanged: (String? newGrade) {
            // call set state shortly only if the value is not null and different
            if (newGrade != null && newGrade != grade) {
              setState(() {
                grade = newGrade;
              });
            }
          },
        ));
  }

  Widget buildNextButton() {
    // TODO Implement transition to next page
    return Row(
      children: [
        const Spacer(),
        Padding(
            padding: const EdgeInsets.only(top: 8),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 40)),
                onPressed: areFieldsCompleted() ? () => {} : null,
                child: const Text('Next'))),
      ],
    );
  }

  Future<bool?> handleOnCancel(BuildContext context) {
    return showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Cancel'),
            content: const Text('Are you sure to leave your boulder?'),
            actions: [
              TextButton(
                  child: const Text('No'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
              TextButton(
                  child: const Text('Yes'),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                    widget.onCancel();
                  })
            ],
          );
        });
  }

  void spawnCamera(context) async {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => CameraCamera(onFile: (file) {
                  Navigator.pop(context);
                  setState(() {
                    currentImageFile = file;
                  });
                })));
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themData = Theme.of(context);

    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) async {
        if (didPop) {
          return;
        }
        await handleOnCancel(context);
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: const Text('Register a new boulder'),
        ),
        body: Form(
          child: Column(
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.bottomCenter,
                  decoration: BoxDecoration(
                      color: Colors.grey[400],
                      image: currentImageFile == null
                          ? null
                          : DecorationImage(
                              image: FileImage(currentImageFile!),
                              fit: BoxFit.cover)),
                  child: Column(children: [
                    const Spacer(),
                    Container(
                      decoration: BoxDecoration(
                        color: themData.canvasColor,
                        shape: BoxShape.circle,
                      ),
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.all(8),
                      child: IconButton(
                        iconSize: 40,
                        icon: const Icon(FontAwesomeIcons.camera),
                        onPressed: () {
                          spawnCamera(context);
                        },
                      ),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                          foregroundColor: themData.colorScheme.background),
                      onPressed: () {
                        spawnCamera(context);
                      },
                      child: Text(
                          currentImageFile == null
                              ? 'Take a pic of the boulder'
                              : 'Replace the pic',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18)),
                    ),
                    const Spacer(),
                  ]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                child: Column(children: [
                  buildBoulderNameInput(),
                  buildBoulderGradeInput(),
                  buildNextButton(),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
