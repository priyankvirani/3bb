import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PdfViewerScreen extends StatefulWidget {

  String path;

  PdfViewerScreen({required this.path});

  @override
  _PdfViewerScreenState createState() => _PdfViewerScreenState();
}

class _PdfViewerScreenState extends State<PdfViewerScreen> {

  final Completer<PDFViewController> _controller =
  Completer<PDFViewController>();

  int pages = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.path.split('/').last,style: const TextStyle(fontSize: 15,fontWeight: FontWeight.w400),),
      ),
      body: SizedBox(
        width: 200,
        height: 300,
        child:PDFView(
          filePath: widget.path,
          enableSwipe: true,
          swipeHorizontal: true,
          autoSpacing: false,
          pageFling: false,
          onRender: (_pages) {
            setState(() {
              pages = _pages!;
            });
          },
          onError: (error) {
            print(error.toString());
          },
          onPageError: (page, error) {
            print('$page: ${error.toString()}');
          },
          onViewCreated: (PDFViewController pdfViewController) {
            _controller.complete(pdfViewController);
          },
          onPageChanged: (page,total) {
            print('$page/$total');
          },
        ),
      ),

    );
  }
}
