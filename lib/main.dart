import 'package:flutter/material.dart';
import 'package:photo_view/photo_view_gallery.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Galeria de Fotos',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Galeria(title: 'Galeria'),
    );
  }
}

class Galeria extends StatefulWidget {
  const Galeria({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<Galeria> createState() => _GaleriaState();
}

class _GaleriaState extends State<Galeria> {
  final imgList = [
    'assets/img1.jpg',
    'assets/img2.jpg',
    'assets/img3.jpg',
    'assets/img4.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: 0,
          mainAxisSpacing: 0,
          crossAxisCount: 3,
        ),
        itemCount: imgList.length,
        itemBuilder: (context, index) {
          return new GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ImageView(
                      index: index,
                      imgList: imgList,
                    ),
                  ));
            },
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(imgList[index]),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class ImageView extends StatefulWidget {
  final int index;
  final List<String> imgList;
  final PageController pageController;

  ImageView({Key? key, required this.index, required this.imgList})
      : pageController = PageController(initialPage: index);

  @override
  State<StatefulWidget> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  late int index = widget.index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Row(
          children: [Text('Imagen '), Text((index + 1).toString())],
        )),
        body: PhotoViewGallery.builder(
          pageController: widget.pageController,
          itemCount: widget.imgList.length,
          builder: (context, index) {
            final imageDirectory = widget.imgList[index];

            return PhotoViewGalleryPageOptions(
                imageProvider: AssetImage(imageDirectory));
          },
          onPageChanged: (index) => setState(() => this.index = index),
        ));
  }
}
