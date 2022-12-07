

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';






class SlideShow extends StatelessWidget {
 
  final List<Widget> slides;
  final bool puntosArriba;
  final Color colorPrimario;
  final Color colorSecundario;
  final double  bulletPrimario;
  final double  bulletSecundario;

  SlideShow({

    required this.slides,
    this.puntosArriba      = false,
    this.colorPrimario     = Colors.blue,
    this.colorSecundario   = Colors.grey, 
    this.bulletPrimario    = 12.0,
    this.bulletSecundario  = 12.0 
  });


  

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _SlideShowModel(),
      child: SafeArea(
        child: Builder(
          builder: (BuildContext context) {

              WidgetsBinding.instance.addPostFrameCallback(( _ ) {


                  Provider.of<_SlideShowModel>(context,listen: false).colorPrimario = colorPrimario;
                  Provider.of<_SlideShowModel>(context,listen: false).colorSecundario = colorSecundario;

                  Provider.of<_SlideShowModel>(context,listen: false).bulletPrimario = bulletPrimario;
                  Provider.of<_SlideShowModel>(context,listen: false).bulletSecundario = bulletSecundario;

              });
          
              return _CrearEstructuraSlideshow(puntosArriba: puntosArriba, slides: slides);

            },
          ),
      ),
    );
  }
}

class _CrearEstructuraSlideshow extends StatelessWidget {
  const _CrearEstructuraSlideshow({
    required this.puntosArriba,
    required this.slides,
  });

  final bool puntosArriba;
  final List<Widget> slides;

  @override
  Widget build(BuildContext context) {
    return Column(
     children: [
      if(puntosArriba) 
       _Dots(slides.length),

       Expanded(
         child: _Sliders( this.slides)
       ),
       if(!puntosArriba) 
        _Dots(slides.length),
          
     ],
    );
  }
}



class _Dots extends StatelessWidget {
  

  final int totalSlides;


  const _Dots(this.totalSlides);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(totalSlides, (i) => _Dot(i)),
       /* children: [
          _Dot(0),
          _Dot(1),
          _Dot(2)
        ],*/
      ),
    );
  }
}

class _Dot extends StatelessWidget {

   final int index;
   _Dot(this.index);
 
  @override
  Widget build(BuildContext context) {

    final ssModel = Provider.of<_SlideShowModel>(context);
    double bulletSize = 0;
    Color  color;

    if(ssModel.currentPage >= index -0.5 && ssModel.currentPage < index + 0.5){

        bulletSize = ssModel.bulletPrimario;
        color = ssModel.colorPrimario;
    }
    else{

        bulletSize = ssModel.bulletSecundario;
        color = ssModel.colorSecundario;
    }

    

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
 
      width:  bulletSize,
      height: bulletSize,
      margin: const EdgeInsets.symmetric(horizontal: 7),
      decoration: BoxDecoration(
      color: color,
        shape: BoxShape.circle
      ), 
    );
  }
}


class _Sliders extends StatefulWidget {

  final List<Widget> slides;

  _Sliders(this.slides);

  @override
  State<_Sliders> createState() => _SlidersState();
}

class _SlidersState extends State<_Sliders> {

  final pageviewController = PageController();

  @override
  void initState() {
    super.initState();
    pageviewController.addListener(() {
      Provider.of<_SlideShowModel>(context, listen: false).currentPage = pageviewController.page!;
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
        children: widget.slides.map((slide) => _Slide(slide)).toList(),
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  
  final Widget slide;
  _Slide(this.slide);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.all(30),
      child: slide,
    );
  }
}




class _SlideShowModel with ChangeNotifier{

  double _currentPage      = 0;
  Color  _colorPrimario    = Colors.red;
  Color  _colorSecundario  = Colors.grey;
  double _bulletPrimario   = 12;
  double _bulletSecundario = 12;




  double get currentPage => _currentPage;
  set currentPage(double screen){
    _currentPage = screen;
    notifyListeners();
  }



  Color get colorPrimario => _colorPrimario;
  set colorPrimario(Color color){
   _colorPrimario = color;
  
  }
  
  Color get colorSecundario => _colorSecundario;
  set colorSecundario(Color color){
   _colorSecundario = color;
  }

  double get bulletPrimario => _bulletPrimario;
    set bulletPrimario(double bullet){
    _bulletPrimario = bullet;
  }

   double get bulletSecundario => _bulletSecundario;
    set bulletSecundario(double bullet){
    _bulletSecundario = bullet;
   
  }


}