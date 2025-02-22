import 'dart:core';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:pdf_image_renderer/pdf_image_renderer.dart';

import 'package:frontend/src/theme/app_theme.dart';

class CvBrowsePage extends StatefulWidget {
  const CvBrowsePage({super.key});

  @override
  State<CvBrowsePage> createState() => _CvBrowsePageState();
}

class _CvBrowsePageState extends State<CvBrowsePage> {
  List<FileSystemEntity> _documents = [];
  final Map<String, Uint8List> _thumbnails = {};

  Future<void> _loadDocuments() async {
    final directory = await getApplicationDocumentsDirectory();
    final folder = Directory('${directory.path}/cvs');

    if (await folder.exists()) {
      final files = folder.listSync();
      setState(() {
        _documents = files;
      });
      // Generate thumbnails for pdf files
      for (var file in files) {
        if (file.path.endsWith('.pdf')) {
          final thumbnail = await _generatePdfThumbnails(file);
          if (thumbnail != null) {
            setState(() {
              _thumbnails[file.path] = thumbnail;
            });
          }
        }
      }
    }
  }

  Future<Uint8List?> _generatePdfThumbnails(FileSystemEntity file) async {
    try {
      final document = await PdfImageRenderer(path: file.path);
      final page = await document.renderPage(
        x: 0,
        y: 0,
        width: 100,
        height: 100,
      );
      if (page != null) {
        return page;
      }
    } catch (e) {
      print("Error generating thumbnails for $file:$e");
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    _loadDocuments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: _documents.isEmpty
            ? Center(
                child: CircularProgressIndicator(),
              )
            : GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: _documents.length,
                itemBuilder: (context, index) {
                  final file = _documents[index];
                  final fileName = file.uri.pathSegments.last;
                  if (file.path.endsWith('.pdf')) {
                    final thumnNail = _thumbnails[file.path];
                    return Card(
                      elevation: 5,
                      child: InkWell(
                        onTap: () {
                          print("tapping");
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            thumnNail != null
                                ? Image.memory(
                                    thumnNail,
                                    height: 80,
                                    width: 80,
                                    fit: BoxFit.cover,
                                  )
                                : CircularProgressIndicator(),
                            Text(
                              fileName,
                              style: AppTheme.darkTheme.textTheme.headlineSmall,
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
      ),
    );
  }
}
