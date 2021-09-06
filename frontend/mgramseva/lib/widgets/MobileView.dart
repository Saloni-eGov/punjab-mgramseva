import 'package:flutter/material.dart';
import 'package:mgramseva/widgets/Back.dart';
import 'package:mgramseva/widgets/BackgroundContainer.dart';
import 'package:mgramseva/widgets/footerBanner.dart';

class MobileView extends StatelessWidget {
  final Widget widget;
  MobileView(this.widget);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
          SafeArea(child: Container(child: Center(child: LayoutBuilder(builder:
              (BuildContext context, BoxConstraints viewportConstraints) {
            return ConstrainedBox(
                constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height),
                child: IntrinsicHeight(
                    child: Column(children: <Widget>[
                  Expanded(
                      // A flexible child that will grow to fit the viewport but
                      // still be at least as big as necessary to fit its contents.
                      child: Container(
                          color: Colors.blue,
                          //height: 120.0,
                          child: BackgroundContainer(new Container(
                              child: new Stack(
                                  // // fit: StackFit.expand,
                                  // clipBehavior: Clip.antiAlias,
                                  children: <Widget>[
                                Back(),
                                (new Positioned(
                                    bottom: 30.0,
                                    child: new Container(
                                        margin: EdgeInsets.only(bottom: 5),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        // height: MediaQuery.of(context).size.height + 20,
                                        padding: EdgeInsets.all(8),
                                        child: widget))),
                                (new Positioned(
                                    bottom: 0.0,
                                    left: MediaQuery.of(context).size.width / 4,
                                    child: FooterBanner()))
                              ])))))
                ])));
          }))))
        ]));
  }
}
