import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class camScanner extends StatefulWidget {
  const camScanner({Key? key}) : super(key: key);

  @override
  State<camScanner> createState() => _camScannerState();
}

class _camScannerState extends State<camScanner> {
  File? file;
  ImagePicker image = ImagePicker();
  getImage() async {
    var img = await image.pickImage(source: ImageSource.gallery);

    setState(() {
      file = File(img!.path);
    });
  }

  getImagecam() async {
    var img = await image.pickImage(source: ImageSource.camera);

    setState(() {
      file = File(img!.path);
    });
  }

  Future<Uint8List> _generatePdf(PdfPageFormat format, file) async {
    final pdf = pw.Document(
      version: PdfVersion.pdf_1_5,
      compress: true,
    );
    final showimage = pw.MemoryImage(file.readAsBytesSync());

    pdf.addPage(
      pw.Page(
        pageFormat: format,
        build: (context) {
          return pw.Center(
            child: pw.Image(showimage, fit: pw.BoxFit.contain),
          );
        },
      ),
    );

    return pdf.save();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            (imageSelected)
                ? Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: file == null
                        ? Container()
                        : PdfPreview(
                            build: (format) => _generatePdf(format, file),
                          ))
                : SizedBox(
                    height: 0,
                    width: 0,
                  ),
            RaisedButton(
              child: Text('Select picture from Camera'),
              shape: StadiumBorder(),
              onPressed: () {
                getImage();
                setState(() {
                  imageSelected = true;
                });
              },
            ),
            const SizedBox(height: 12),
            RaisedButton(
              child: Text('Select picture from Gallery'),
              shape: StadiumBorder(),
              onPressed: () {
                getImagecam();
                setState(() {
                  imageSelected = true;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  bool imageSelected = false;
}
