import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_catalog/models/catalog.dart';
import 'package:flutter_catalog/widget/item_widgets.dart';
import 'package:flutter_catalog/widget/themes.dart';
import 'dart:convert';
import '../widget/drawer.dart';
import 'package:velocity_x/velocity_x.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    await Future.delayed(Duration(seconds: 2));
    var catalogJson = await rootBundle.loadString("assets/files/catalog.json");
    var decodedJson = jsonDecode(catalogJson);
    var productsData = decodedJson["products"];
    CatalogModel.items = List.from(productsData)
        .map<Item>((item) => Item.fromMap(item))
        .toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
            padding: Vx.m32,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                catalogHead(),
                if (CatalogModel.items != null && CatalogModel.items.isNotEmpty)
                  catalogList().expand()
                else
                  Center(
                    child: CircularProgressIndicator(),
                  )
              ],
            )),
      ),
    );
  }
}

class catalogHead extends StatelessWidget {
  const catalogHead({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        "Catalog App".text.xl5.bold.color(MyThemes.bluishColor).make(),
        "Trending products".text.xl2.make(),
      ],
    );
  }
}

class catalogList extends StatelessWidget {
  const catalogList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: CatalogModel.items.count(),
      itemBuilder: (context, index) {
        final item = CatalogModel.items[index];

        return CatalogItem(catalogItem: item);
      },
    );
  }
}

class CatalogItem extends StatelessWidget {
  final Item catalogItem;
  const CatalogItem({super.key, required this.catalogItem})
      : assert(catalogItem != null);

  @override
  Widget build(BuildContext context) {
    return VxBox(
        child: Row(
      children: [
        Image.network(catalogItem.image)
            .box
            .rounded
            .p8
            .color(MyThemes.creamishColor)
            .make()
            .p8()
            .w40(context),
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            catalogItem.name.text.bold.make(),
            catalogItem.desc.text.textStyle(context.captionStyle).make(),
            ButtonBar(
              alignment: MainAxisAlignment.spaceBetween,
              buttonPadding: Vx.mH8,
              children: [
                "\$${catalogItem.price}".text.bold.xl.make(),
                ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(MyThemes.bluishColor),
                      shape: MaterialStateProperty.all(
                        StadiumBorder(),
                      )),
                  child: "buy".text.make(),
                ),
              ],
            ).pOnly(right: 8),
          ],
        ))
      ],
    )).white.roundedLg.square(150).make().py16();
  }
}
