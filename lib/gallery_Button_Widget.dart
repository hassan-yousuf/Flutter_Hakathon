import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hakathon/list_Tile_Widget.dart';
import 'package:hakathon/source.dart';
import 'package:image_picker/image_picker.dart';

class GalleryButtonWidget extends StatelessWidget {
  const GalleryButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ListTileWidget(
        text: 'From Gallery',
        icon: Icons.photo,
        onClicked: () => pickGalleryMedia(context),
      );
  Future pickGalleryMedia(BuildContext context) async {
    final Object? source = ModalRoute.of(context)!.settings.arguments;

    final getMedia = source == MediaSource.image
        ? ImagePicker().getImage
        : ImagePicker().getVideo;

    final media = await getMedia(source: ImageSource.gallery);
    final file = File(media!.path);

    Navigator.of(context).pop(file);
  }
}
