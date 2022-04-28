import 'package:flutter/material.dart';
import 'package:hakathon/gallery_Button_Widget.dart';
import 'camera_Button_Widget.dart';

class SourcePage extends StatefulWidget {
  const SourcePage({Key? key}) : super(key: key);

  @override
  State<SourcePage> createState() => _SourcePageState();
}

class _SourcePageState extends State<SourcePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        centerTitle: true,
        title: Text('Select Source'),
      ),
      body: ListView(
        children: [
          CameraButtonWidget(),
          GalleryButtonWidget(),
        ],
      ),
    );
  }
}
