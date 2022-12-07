import 'package:flutter/material.dart';



import 'package:flutter_svg/flutter_svg.dart';


import 'package:slideshow/widgets/slideshow.dart';


class SlideshowScreen extends StatelessWidget {
  const SlideshowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      body: Column(
        children: [
          Expanded(child: miSlideShow()),
          Expanded(child: miSlideShow()),
        ],
      )
      
    );
  }

  SlideShow miSlideShow() {
    return SlideShow(
      bulletPrimario: 16,
      bulletSecundario: 12,
      puntosArriba: false,
      colorPrimario: Color(0xffF9A826),
      colorSecundario: Colors.grey,
      slides: <Widget>[
         SvgPicture.asset('assets/svg/slide-1.svg'),
         SvgPicture.asset('assets/svg/slide-2.svg'),
         SvgPicture.asset('assets/svg/slide-3.svg'),
         SvgPicture.asset('assets/svg/slide-4.svg'),
         SvgPicture.asset('assets/svg/slide-5.svg'),
      ],
    );
  }
}