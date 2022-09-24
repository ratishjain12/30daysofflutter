import 'package:flutter/material.dart';
import 'package:flutter_catalog/models/catalog.dart';
import 'package:flutter_catalog/widget/themes.dart';
import 'package:velocity_x/velocity_x.dart';

class pageDetails extends StatelessWidget {
  final Item catalog;
  const pageDetails({super.key, required this.catalog})
      : assert(catalog != null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(catalog.name),
        backgroundColor: Colors.white,
        elevation: 0.0,
        foregroundColor: Colors.black,
      ),
      backgroundColor: MyThemes.creamishColor,
      body: SafeArea(
        child: Column(
          children: [
            Hero(
              tag: Key(catalog.id.toString()),
              child: Image.network(catalog.image).box.make(),
            ).centered().h32(context),
            Expanded(
                child: VxArc(
              height: 40,
              arcType: VxArcType.CONVEY,
              edge: VxEdge.TOP,
              child: Container(
                  width: context.screenWidth,
                  color: Colors.white,
                  child: Column(
                    children: [
                      "${catalog.name}"
                          .text
                          .xl4
                          .color(MyThemes.bluishColor)
                          .make(),
                      "${catalog.desc}".text.xl.make()
                    ],
                  ).py64()),
            ).pOnly(top: 16)),
          ],
        ).pOnly(top: 20),
      ),
    );
  }
}
