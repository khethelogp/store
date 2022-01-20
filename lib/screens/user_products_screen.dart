import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/product.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';
import '../widgets/user_product_item.dart';
import '../screens/edit_product_screen.dart';
import '../widgets/app_drawer.dart';

class UserProductsScreen extends StatelessWidget {

  static const routeName = '/user-products';

  Future<void> _refreshedProducts(BuildContext context) async{
    await Provider.of<Products>(context, listen: false).fetchAndSetProducts(true);
  }


  @override
  Widget build(BuildContext context) {
    // final productsData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your products'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
            }, 
          )
        ]
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: _refreshedProducts(context),
        builder: (ctx, snapshot) => snapshot.connectionState == ConnectionState.waiting 
        ? Center(child: CircularProgressIndicator(),) 
        : RefreshIndicator(
          onRefresh: () => _refreshedProducts(context),
          child: Consumer<Products>(
            builder: (ctx, productsData, _) => Padding(
              padding: EdgeInsets.all(8),
              child: ListView.builder(
                itemCount: productsData.items.length,
                itemBuilder: (_, i) => Column(
                  children: [
                    UserProductItem(
                      productsData.items[i].id,
                      productsData.items[i].title,
                      productsData.items[i].imageUrl
                    ),
                    Divider()
                  ],
                )
              ),
            ),
          ),
        ),
      ),
    );
  }
}