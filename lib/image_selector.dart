library image_selector;

import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageSelector extends StatefulWidget {
  final String? cameraDescription;
  final String? galleryText;
  final String? cameraText;
  final Color? themeColor;
  final double containerWidth;
  final double containerHeight;
  final Function(String e) onError;
  final List<File> imageList;

  const ImageSelector(
      {Key? key,
      this.containerWidth = 300,
      this.containerHeight = 100,
      required this.onError,
      this.cameraDescription = "Tap inside the box in order to upload photos",
      this.themeColor = Colors.white,
      this.galleryText = "Gallery",
      this.cameraText = "Camera", required this.imageList})
      : super(key: key);

  @override
  _ImageSelectorState createState() => _ImageSelectorState();
}

class _ImageSelectorState extends State<ImageSelector> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
          onTap: () {
            if (widget.imageList.isEmpty) {
              _showPicker(context);
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: DottedBorder(
              color: widget.themeColor!,
              strokeWidth: 1.5,
              radius: const Radius.circular(15.0),
              borderType: BorderType.RRect,
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Container(
                  constraints: const BoxConstraints(
                    minWidth: 300,
                    minHeight: 100,
                  ),
                  child: Builder(builder: (_) {
                    if (widget.imageList.isEmpty) {
                      return Column(
                        children: [
                          Icon(
                            Icons.camera_alt,
                            color: widget.themeColor!,
                            size: 30.0,
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          Text(
                            widget.cameraDescription!,
                            style: Theme.of(context).textTheme.bodyText1,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      );
                    } else {
                      return SizedBox(
                        height: 150,
                        child: ListView.builder(
                          itemCount: widget.imageList.length + 1,
                          itemBuilder: (context, index) {
                            if (index == widget.imageList.length) {
                              return Padding(
                                padding: EdgeInsets.all(5.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Container(
                                    width: 120.0,
                                    height: 120.0,
                                    color: Colors.black26,
                                    child: IconButton(
                                      icon: const Icon(
                                        Icons.add,
                                        size: 40.0,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {
                                        _showPicker(context);
                                      },
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              return Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.file(
                                        widget.imageList[index],
                                        fit: BoxFit.cover,
                                        height: 120.0,
                                        width: 120.0,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(5.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white.withOpacity(0.8),
                                        ),
                                        child: IconButton(
                                          padding: EdgeInsets.zero,
                                          constraints: BoxConstraints(
                                            minWidth: 35,
                                            minHeight: 35,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              widget.imageList.removeAt(index);
                                            });
                                          },
                                          icon: Icon(
                                            Icons.delete,
                                            size: 25.0,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                  alignment: AlignmentDirectional.topEnd,
                                ),
                              );
                            }
                          },
                          scrollDirection: Axis.horizontal,
                        ),
                      );
                    }
                  }),
                ),
              ),
            ),
          )),
    );
  }

  // general methods:-----------------------------------------------------------

  Future<void> _openCamera() async {
    try {
      PickedFile? picture = await ImagePicker()
          .getImage(source: ImageSource.camera, imageQuality: 50);

      if (picture != null) {
        setState(() {
          widget.imageList.add(File(picture.path));
        });
      }
    } catch (e) {
      widget.onError(e.toString());
    }
  }

  Future<void> _openGallery() async {
    try {
      var picture = await ImagePicker()
          .getImage(source: ImageSource.gallery, imageQuality: 50);

      if (picture != null) {
        if (picture != null) {
          setState(() {
            widget.imageList.add(File(picture.path));
          });
        }
      }
    } catch (e) {
      widget.onError(e.toString());
    }
  }

  void _showPicker(BuildContext context) {
    showModalBottomSheet<dynamic>(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            color: Colors.white,
            child: SafeArea(
                child: Wrap(
              children: [
                ListTile(
                  leading: const Icon(
                    Icons.photo_library,
                    size: 20,
                    color: Colors.black,
                  ),
                  title: Text(
                    widget.galleryText!,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(color: Colors.black),
                  ),
                  onTap: () {
                    _openGallery();
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.camera_alt,
                    size: 20,
                    color: Colors.black,
                  ),
                  title: Text(
                    widget.cameraText!,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(color: Colors.black),
                  ),
                  onTap: () {
                    _openCamera();
                    Navigator.of(context).pop();
                  },
                )
              ],
            )),
          );
        });
  }
}
