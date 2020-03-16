import 'package:flutter/material.dart';

class FloatButton extends StatefulWidget {
  @override
  _FloatButtonState createState() => _FloatButtonState();
}

class _FloatButtonState extends State<FloatButton> with SingleTickerProviderStateMixin {

  Animation<double> _animation;
  AnimationController _controller;

  bool _isActivated = false;

  Animation<Offset> _searchButton;
  Animation<Offset> _contactButton; 
  Animation<Offset> _addButton;
  

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    _searchButton = Tween<Offset>(begin: Offset(0.0, 0.0), end: Offset(-1.0, 0.2)).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOutBack));
    _contactButton = Tween<Offset>(begin: Offset(0.0, 0.0), end: Offset(-0.9, -1.2)).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOutBack));
    _addButton = Tween<Offset>(begin: Offset(0.0, 0.0), end: Offset(-0.6, -2.6)).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOutBack));
  }


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  _initAnimation() {
    _controller.forward();
    setState(() {
      _isActivated = true;
    });
  }

  _revertAnimation() {
    _controller.reverse();
    setState(() {
      _isActivated = false;
    });
  }

  _renderSubIcon(Icon icon, Animation animation, String label) {
    return Positioned(
      bottom: 40.0,
      right: -25.0,
      child: FadeTransition(
        opacity: _animation,
        child: SlideTransition(
          position: animation,
          child: Container(
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                SizedBox(
                  height: 70.0,
                  width: 120.0,
                ),
                Positioned(
                  top: 0,
                  child: Container(
                    height: 50.0,
                    width: 50.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: icon,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: Text(label, style: TextStyle(color: Colors.white),),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _handleTouch(double bottom, double right, Function onTap) {
    return Positioned(
      width: 120.0,
      height: 70.0,
      bottom: bottom,
      right: right,
      child: GestureDetector(
        onTap: () {
          _revertAnimation();
          onTap();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        IgnorePointer(
          ignoring: !_isActivated,
          child: FadeTransition(
            opacity: _animation,
            child: Container(
              color: Colors.black54,
            ),
          ),
        ),
        _renderSubIcon(Icon(Icons.search, color: Colors.blueAccent,), _searchButton, 'Verificar Autenticidade'),
        _renderSubIcon(Icon(Icons.contacts, color: Colors.green,), _contactButton, 'Adicionar Organização'),
        _renderSubIcon(Icon(Icons.plus_one, color: Colors.orange,), _addButton, 'Registrar Documento'),
        Positioned(
          bottom: 60.0,
          right: 10.0,
          child: Container(
            width: 50.0,
            height: 50.0,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(30.0)
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                customBorder: CircleBorder(),
                onTap: () {
                  if(_isActivated) {
                    _revertAnimation();
                  } else {
                    _initAnimation();
                  }
                },
                child: AnimatedBuilder(
                  animation: _animation,
                    child: Icon(
                      Icons.menu, color: Colors.white,
                    ),
                  builder: (BuildContext context, Widget child) {
                    return Transform.rotate(
                      angle: _animation.value * 0.9,
                      child: child,
                    );
                  },
                ),
              ),
            ),
          ),
        ),
        (_isActivated ? _handleTouch(28.0, 97.0, () {print('botao transferencia tocado');}) : Container()),
        (_isActivated ? _handleTouch(110.0, 120.0, () {print('botao receita tocado');}) : Container()),
        (_isActivated ? _handleTouch(215.0, 97.0, () {print('botao despesa cartao tocado');}) : Container()),
      ],
    );
  }
}