import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_book_store/base/base_widget.dart';
import 'package:flutter_app_book_store/data/remote/order_service.dart';
import 'package:flutter_app_book_store/data/remote/product_service.dart';
import 'package:flutter_app_book_store/data/remote/user_service.dart';
import 'package:flutter_app_book_store/data/repo/order_repo.dart';
import 'package:flutter_app_book_store/data/repo/product_repo.dart';
import 'package:flutter_app_book_store/data/repo/user_repo.dart';
import 'package:flutter_app_book_store/event/add_to_cart_event.dart';
import 'package:flutter_app_book_store/module/home/home_bloc.dart';
import 'package:flutter_app_book_store/shared/app_color.dart';
import 'package:flutter_app_book_store/shared/model/shopping_cart.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageContainer(
      title: 'Home',
      di: [
        Provider.value(
          value: ProductService(),
        ),
        Provider.value(
          value: OrderService(),
        ),
        ProxyProvider<ProductService, ProductRepo>(
          builder: (context, productService, previous) =>
              ProductRepo(productService: productService),
        ),
        ProxyProvider<OrderService, OrderRepo>(
          builder: (context, orderService, previous) =>
              OrderRepo(orderService: orderService),
        ),
      ],
      bloc: [],
      actions: <Widget>[
        ShoppingCartWidget(),
      ],
      child: ProductListWidget(),
    );
  }
}

class ShoppingCartWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<HomeBloc>.value(
      value: HomeBloc.getInstance(
        productRepo: Provider.of(context),
        orderRepo: Provider.of(context),
      ),
      child: Consumer<HomeBloc>(
        builder: (context, bloc, child) => StreamProvider<AddToCartEvent>.value(
          value: bloc.shoppingCartStream,
          initialData: AddToCartEvent(0),
          child: Consumer<AddToCartEvent>(
            builder: (context, cart, child) {
              return Container(
                margin: EdgeInsets.only(top: 15, right: 20),
                child: Badge(
                  badgeContent: Text(
                    '${cart.count}',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: Icon(Icons.shopping_cart),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class ProductListWidget extends StatelessWidget {
  final images = [
    'https://cdn0.fahasa.com/media/catalog/product/cache/1/image/9df78eab33525d08d6e5fb8d27136e95/i/m/image_176880.jpg',
    'https://cdn0.fahasa.com/media/catalog/product/cache/1/image/9df78eab33525d08d6e5fb8d27136e95/9/7/9786047732524-1.jpg',
    'https://cdn0.fahasa.com/media/catalog/product/cache/1/image/9df78eab33525d08d6e5fb8d27136e95/9/7/9786047732555.jpg',
    'https://cdn0.fahasa.com/media/catalog/product/cache/1/image/9df78eab33525d08d6e5fb8d27136e95/8/9/8936037710327.jpg',
  ];
  @override
  Widget build(BuildContext context) {
    return Provider<HomeBloc>.value(
      value: HomeBloc.getInstance(
        productRepo: Provider.of(context),
        orderRepo: Provider.of(context),
      ),
      child: Consumer<HomeBloc>(
        builder: (context, bloc, child) => Container(
          color: AppColor.white,
          child: ListView.builder(
              itemCount: images.length,
              itemBuilder: (context, index) {
                return _buildRow(bloc, images[index]);
              }),
        ),
      ),
    );
  }

  Widget _buildRow(HomeBloc bloc, String imageUrl) {
    return Container(
      height: 180,
      child: Card(
        elevation: 3.0,
        child: Container(
          padding: EdgeInsets.only(left: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  imageUrl,
                  width: 100,
                  height: 150,
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 15, left: 15),
                      child: Text(
                        'Học tiếng anh cùng Pokémon',
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5, left: 15),
                      child: Text(
                        '30 quấn',
                        style: TextStyle(color: AppColor.blue, fontSize: 17),
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: 5, left: 15),
                            child: Text(
                              '100.000 vnđ',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 15),
                            child: FlatButton(
                              padding: EdgeInsets.all(10),
                              color: AppColor.yellow,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(4),
                                  topRight: Radius.circular(20),
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20),
                                ),
                              ),
                              onPressed: () {
                                bloc.event.add(AddToCartEvent(0));
                              },
                              child: Text(
                                ' Buy now ',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
