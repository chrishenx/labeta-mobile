import 'dart:io';
import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:labeta/utils/logger.dart';
import 'package:labeta/utils/validators.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

class NewSector extends StatefulWidget {
  const NewSector({super.key});

  @override
  State<NewSector> createState() => _NewSectorState();
}

// Dart isolate ref: https://medium.com/@varmavetukuri1234/image-picker-using-dart-isolate-f9451c024e1d
class _NewSectorState extends State<NewSector> {
  final formKey = GlobalKey<FormState>(debugLabel: 'Login Form');
  final ImagePicker imagePicker = ImagePicker();
  File? currentImageFile;
  String name = '';
  String description = '';

  @override
  void initState() {
    super.initState();
    // Only run if on Android
    if (Platform.isAndroid) {
      getLostData();
    }
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
          title: const Text('Registrar un nuevo sector'),
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
                        icon: const Icon(FontAwesomeIcons.folderOpen),
                        onPressed: () {
                          spanFilePicker(context);
                        },
                      ),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                          foregroundColor: themData.colorScheme.background),
                      onPressed: () {
                        spanFilePicker(context);
                      },
                      child: Text(
                          currentImageFile == null
                              ? 'Selecciona la foto principal del sector :)'
                              : 'Reemplaza la foto ;)',
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
                  buildSectorNameInput(),
                  buildSectorDescriptionInput(),
                  buildSubmitButton(),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> getLostData() async {
    final LostDataResponse response = await imagePicker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      handleFile(File(response.file!.path));
    } else {
      handleError(response.exception);
    }
  }

  void handleFile(File file) {
    setState(() {
      currentImageFile = file;
    });
  }

  void handleError(dynamic exception) {
    Logger.log(
          'NewSector - exception $exception');
  }

  void handleSubmit() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
    }
  }

  bool areAllFieldsCompleted() {
    return name.isNotEmpty && description.isNotEmpty && currentImageFile != null;
  }

  bool isAnyFieldFilled() {
    return name.isNotEmpty || description.isNotEmpty || currentImageFile != null;
  }

  Widget buildSectorNameInput() {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: TextFormField(
        onChanged: (value) {
          setState(() {
            name = value;
          });
        },
        validator: Validators.validatePrintable,
        decoration: const InputDecoration(
            hintText: 'Escribe el nombre del sector aqui',
            labelText: 'Nombre del sector'),
      ),
    );
  }

  Widget buildSectorDescriptionInput() {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: TextFormField(
        minLines: 1,
        maxLines: 6,
        onChanged: (value) {
          setState(() {
            description = value;
          });
        },
        validator: Validators.validatePrintable,
        keyboardType: TextInputType.multiline, // Don't know if this is needed
        decoration: const InputDecoration(
            hintText:
                'Escribe una descripción cool de este sector, esto sera lo que verán los demás escaladores.',
            labelText: 'Descripción'),
      ),
    );
  }

  Widget buildSubmitButton() {
    return Row(
      children: [
        const Spacer(),
        Padding(
            padding: const EdgeInsets.only(top: 8),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 40)),
                onPressed: areAllFieldsCompleted() ? () => {} : null,
                child: const Text('Crear'))),
      ],
    );
  }

  // TODO: Figure out how to move this to a reusable widget
  Future<bool?> handleOnCancel(BuildContext context) {
    // Don't show the dialog if the user hasnt filled any field
    if (!isAnyFieldFilled()) {
      Navigator.pop(context);
      return Future.value(true);
    }
    return showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Cancel'),
            content:
                const Text('¿De verdad quieres dejar tu sector a la mitad?'),
            actions: [
              TextButton(
                  child: const Text('No'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
              TextButton(
                  child: const Text('Si'),
                  onPressed: () {
                    Navigator.pop(context); // Close the dialog
                    Navigator.pop(context); // Close the screen
                  })
            ],
          );
        });
  }

  Future<void> spanFilePicker(BuildContext context) async {
    final ReceivePort receivePort = ReceivePort();
    RootIsolateToken isolateToken = RootIsolateToken.instance!;
    await Isolate.spawn(pickImage, [isolateToken, receivePort.sendPort]);
    receivePort.listen((message) {
      if (message is String) {
        handleFile(File(message));
      }
    });
  }
}

Future<void> pickImage(List args) async {
    BackgroundIsolateBinaryMessenger.ensureInitialized(args[0]);
    final ImagePicker imagePicker = ImagePicker();
    imagePicker.pickImage(source: ImageSource.gallery).then((value) {
      final SendPort sendPort = args[1];
      sendPort.send(value?.path);
    });
  }