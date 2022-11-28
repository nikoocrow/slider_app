import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:slideshow/models/slider_model.dart';


class SlideShowScreen extends StatelessWidget {
  const SlideShowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  ChangeNotifierProvider(
      create: (_) => SliderModel(),
      child: Scaffold(
        body: Center(
         child: Column(
          children: [
            Expanded(
              child: _Sliders()
            ),
            _Dots(),
          ],
         )
        ),
      ),
    );
  }
}


class _Dots extends StatelessWidget {
  const _Dots({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _Dot(0),
          _Dot(1),
          _Dot(2)
        ],
      ),
    );
  }
}

class _Dot extends StatelessWidget {

   final int index;

   _Dot(this.index);
 
  @override
  Widget build(BuildContext context) {

    final pageViewIndex = Provider.of<SliderModel>(context).currentPage;

    print('pageIndex: ${pageViewIndex}');

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: 12,
      height: 12,
      margin: const EdgeInsets.symmetric(horizontal: 7),
      decoration: BoxDecoration(
      
        color: (pageViewIndex >= index -0.5 && pageViewIndex < index + 0.5)
                ? const Color(0xffF9A826) : Colors.grey,
        shape: BoxShape.circle
      ), 
    );
  }
}


class _Sliders extends StatefulWidget {

  @override
  State<_Sliders> createState() => _SlidersState();
}

class _SlidersState extends State<_Sliders> {

  final pageviewController = PageController();

  @override
  void initState() {
    super.initState();
    pageviewController.addListener(() {

      // Actualiza el Provider

      Provider.of<SliderModel>(context, listen: false).currentPage = pageviewController.page!;

    });


  }

  @override
  void dispose(){
    pageviewController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Container(
      child: PageView(
        controller: pageviewController,
        children: [
           _Slide('assets/svg/slide-1.svg'),
           _Slide('assets/svg/slide-2.svg'),
           _Slide('assets/svg/slide-3.svg'),
           
        ],
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  
  final String svg;
  _Slide(this.svg);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.all(30),
      child: SvgPicture.asset(svg),
    );
  }
}