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
  getImagegallery() async {
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
      body: file == null
          ? Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: getImagecam,
                    icon: Icon(
                      Icons.camera_alt,
                      size: 40,
                    ),
                  ),
                  IconButton(
                    onPressed: getImagegallery,
                    icon: Icon(
                      Icons.photo,
                      size: 40,
                    ),
                  ),
                ],
              ),
            )
          : Center(
              child: PdfPreview(
                build: (format) => _generatePdf(format, file),
              ),
            ),
    );
  }
}
