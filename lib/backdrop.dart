library oth_backdrop;

import 'package:flutter/material.dart';

class BackDrop extends StatefulWidget {
  Function callback;
  Widget title;
  AnimatedIconData animatedIcon;
  Widget base;
  Widget content;
  double height;
  Key backdropKey;

  BackDrop(this.callback, this.title, this.animatedIcon, this.base,
      this.content, this.height,
      [this.backdropKey]);

  @override
  State<StatefulWidget> createState() {
    return _BackdropPageState();
  }
}

class _BackdropPageState extends State<BackDrop>
    with SingleTickerProviderStateMixin {
  BackDrop _backDrop;
  AnimationController _controller;
  bool panelIsOut;

  @override
  void initState() {
    super.initState();
    panelIsOut = false;
    _controller = AnimationController(
        duration: Duration(milliseconds: 500), value: 1.0, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    _backDrop = context.widget;
    return Scaffold(
      appBar: AppBar(
        elevation: 10.0,
        title: _backDrop.title,
        leading: IconButton(
          onPressed: changePanelState,
          key: _backDrop.backdropKey,
          icon: AnimatedIcon(
            icon: _backDrop.animatedIcon,
            progress: _controller.view,
          ),
        ),
      ),
      body: LayoutBuilder(
        builder: _buildStack,
      ),
    );
  }

  void changePanelState() {
    setState(() {
      panelIsOut = !panelIsOut;
    });
    _backDrop.callback(panelIsOut);
    _controller.animateTo(panelIsOut ? 1.0 : -1.0);
  }

  Widget _buildStack(BuildContext context, BoxConstraints constraints) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: Stack(
        children: <Widget>[
          _backDrop.base,
          PositionedTransition(
            rect: RelativeRectTween(
              begin: RelativeRect.fromLTRB(
                  0.0, constraints.maxHeight - _backDrop.height, 0.0, 0.0),
              end: RelativeRect.fromLTRB(0.0, 0.0, 0.0, 0.0),
            ).animate(
                CurvedAnimation(parent: _controller, curve: Curves.easeInOut)),
            child: Material(
              borderRadius: const BorderRadius.only(
                  topLeft: const Radius.circular(16.0),
                  topRight: const Radius.circular(16.0)),
              elevation: 12.0,
              child: _backDrop.content,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
