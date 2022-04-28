import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hakathon/source.dart';
import 'package:hakathon/source_Page.dart';
import 'package:hakathon/video_Widget.dart';

class homeScreen extends StatefulWidget {
  const homeScreen({Key? key}) : super(key: key);

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: fileMedia == null
                    ? Icon(Icons.photo, size: 120)
                    : (source == MediaSource.image
                        ? Image.file(fileMedia!)
                        : VideoWidget(fileMedia!)),
              ),
              const SizedBox(height: 24),
              RaisedButton(
                child: Text('Capture Image'),
                shape: StadiumBorder(),
                onPressed: () => capture(MediaSource.image),
                textColor: Colors.white,
              ),
              const SizedBox(height: 12),
              RaisedButton(
                child: Text(' Record Video '),
                shape: StadiumBorder(),
                onPressed: () => capture(MediaSource.video),
                textColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }

  File? fileMedia;
  MediaSource? source;

  Future capture(MediaSource source) async {
    setState(() {
      this.source = source;
      this.fileMedia = null;
    });

    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SourcePage(),
        settings: RouteSettings(
          arguments: source,
        ),
      ),
    );

    if (result == null) {
      return;
    } else {
      setState(() {
        fileMedia = result;
      });
    }
  }
}
