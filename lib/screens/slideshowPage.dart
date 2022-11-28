import 'package:flutter/material.dart';



import 'package:flutter_svg/flutter_svg.dart';


import 'package:slideshow/widgets/slideshow.dart';


class SlideshowScreen extends StatelessWidget {
  const SlideshowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SlideShow(
        puntosArriba: false,
        colorPrimario: Colors.black12,
        colorSecundario: Colors.grey,
        slides: <Widget>[
           SvgPicture.asset('assets/svg/slide-1.svg'),
           SvgPicture.asset('assets/svg/slide-2.svg'),
           SvgPicture.asset('assets/svg/slide-3.svg'),
           SvgPicture.asset('assets/svg/slide-4.svg'),
           SvgPicture.asset('assets/svg/slide-5.svg'),
        ],
      )
    );
  }
}