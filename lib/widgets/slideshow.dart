import 'package:flutter/material.dart';
import 'package:provider/provider.dart';






class SlideShow extends StatelessWidget {
 
  final List<Widget> slides;
  final bool puntosArriba;
  final Color colorPrimario;
  final Color colorSecundario;

  SlideShow({
   required this.slides,
   this.puntosArriba = false,
   required this.colorPrimario,
   required this.colorSecundario
  });


  

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _SlideShowModel(),
      child: SafeArea(
        child: Builder(
          builder: (BuildContext context) {

              WidgetsBinding.instance.addPostFrameCallback(( _ ) {
                
                  Provider.of<_SlideShowModel>(context,listen: false).colorPrimario = this.colorPrimario;
                  Provider.of<_SlideShowModel>(context,listen: false).colorPrimario = this.colorSecundario;
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



    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: 12,
      height: 12,
      margin: const EdgeInsets.symmetric(horizontal: 7),
      decoration: BoxDecoration(
      
        color: (ssModel.currentPage >= index -0.5 && ssModel.currentPage < index + 0.5)
                ? ssModel.colorPrimario : ssModel.colorSecundario,
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

  double _currentPage = 0;
  Color  _colorPrimario = Colors.red;
  Color  _colorSecundario = Colors.grey;




  double get currentPage => _currentPage;
  set currentPage(double screen){
    _currentPage = screen;
    notifyListeners();
  }



  Color get colorPrimario => _colorPrimario;
  set colorPrimario(Color color){
   this._colorPrimario = color;
   notifyListeners();
  }

  
  Color get colorSecundario => _colorSecundario;
  set colorSecundario(Color color){
   this. _colorSecundario = color;
   notifyListeners();
  }


}