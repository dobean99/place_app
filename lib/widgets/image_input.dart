import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart' as syspaths;

class ImageInput extends StatefulWidget {
  final Function selectImage;
  const ImageInput(this.selectImage);

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File _storedImage;

  Future<void> _takePicture() async {
    final imageFile = await ImagePicker.platform
        .pickImage(source: ImageSource.camera, maxWidth: 600);
    if(imageFile==null)
      return;
    setState(() {
      _storedImage = File(imageFile.path);
    });
    //final appDir= await syspaths.getApplicationDocumentsDirectory();
    // final filename=p.basename(_storedImage.path);
    // _storedImage.copy('$appDir/$filename');
    widget.selectImage(_storedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
              width: 1,
            ),
          ),
          child: _storedImage != null
              ? Image.file(
                  _storedImage,
                  fit: BoxFit.cover,
                )
              : Text(
                  'No Image Taken!',
                  textAlign: TextAlign.center,
                ),
          alignment: Alignment.center,
        ),
        Expanded(
          child: TextButton.icon(
            icon: Icon(Icons.camera),
            label: Text('Take a photo'),
            onPressed: _takePicture,
          ),
        )
      ],
    );
  }
}
