import 'package:flutter/material.dart';

import 'products.dart';

class Shop extends ChangeNotifier{
  //products for sale
  final List<Product> _shop = [
    // 2 5 7 11 13 17 18 19 21
    //product1
    Product(
      name: "چادر", 
      price: 2500, 
      description: "عرضه کننده بهترین چادر های گاچ و جهیزیه عروسی و جهیزیه بافت در جهان", 
      imagePath: 'lib/assets/images/4.jpeg',
    ),
    //product2
    Product(
      name: "جهیزیه عروسی", 
      price: 9500, 
      description: "عرضه کننده بهترین چادر های گاچ و جهیزیه عروسی و جهیزیه بافت در جهان",  
      imagePath: 'lib/assets/images/28.jpeg',
    ),
    //product3
    Product(
      name: "جهیزیه بافت", 
      price: 7500, 
      description: "عرضه کننده بهترین چادر های گاچ و جهیزیه عروسی و جهیزیه بافت در جهان",  
      imagePath: 'lib/assets/images/26.jpeg',
    ),
    //product4
    Product(
      name: "چادر", 
      price: 2500, 
      description: "عرضه کننده بهترین چادر های گاچ و جهیزیه عروسی و جهیزیه بافت در جهان", 
      imagePath: 'lib/assets/images/12.jpeg',
    ),
    //product5
    Product(
      name: "چادر", 
      price: 2500, 
      description: "عرضه کننده بهترین چادر های گاچ و جهیزیه عروسی و جهیزیه بافت در جهان",  
      imagePath: 'lib/assets/images/6.jpeg',
    ),
    //product6
    Product(
      name: "چادر", 
      price: 2500, 
      description: "عرضه کننده بهترین چادر های گاچ و جهیزیه عروسی و جهیزیه بافت در جهان",  
      imagePath: 'lib/assets/images/15.jpeg',
    ),
    //product11
    Product(
      name: "یخن", 
      price: 8500, 
      description: "عرضه کننده بهترین چادر های گاچ و جهیزیه عروسی و جهیزیه بافت در جهان", 
      imagePath: 'lib/assets/images/22.jpeg',
    ),
    //product7
    Product(
      name: "چادر", 
      price: 2500, 
      description: "عرضه کننده بهترین چادر های گاچ و جهیزیه عروسی و جهیزیه بافت در جهان", 
      imagePath: 'lib/assets/images/8.jpeg',
    ),
    //product8
    Product(
      name: "چادر", 
      price: 2500, 
      description: "عرضه کننده بهترین چادر های گاچ و جهیزیه عروسی و جهیزیه بافت در جهان", 
      imagePath: 'lib/assets/images/9.jpeg',
    ),
    //product13
    Product(
      name: "جهیزیه بافت",  
      price: 7500, 
      description: "عرضه کننده بهترین چادر های گاچ و جهیزیه عروسی و جهیزیه بافت در جهان",  
      imagePath: 'lib/assets/images/24.jpeg',
    ),
    //product9
    Product(
      name: "چادر", 
      price: 2500, 
      description: "عرضه کننده بهترین چادر های گاچ و جهیزیه عروسی و جهیزیه بافت در جهان",  
      imagePath: 'lib/assets/images/10.jpeg',
    ),
    //product20
    Product(
      name: "جهیزیه بافت", 
      price: 7500, 
      description: "عرضه کننده بهترین چادر های گاچ و جهیزیه عروسی و جهیزیه بافت در جهان",  
      imagePath: 'lib/assets/images/30.jpeg',
    ),
    //product10
    Product(
      name: "چادر", 
      price: 2500, 
      description: "عرضه کننده بهترین چادر های گاچ و جهیزیه عروسی و جهیزیه بافت در جهان", 
      imagePath: 'lib/assets/images/16.jpeg',
    ),
    //product12
    Product(
      name: "یخن", 
      price: 8500, 
      description: "عرضه کننده بهترین چادر های گاچ و جهیزیه عروسی و جهیزیه بافت در جهان", 
      imagePath: 'lib/assets/images/23.jpeg',
    ),
    //product19
    Product(
      name: "جهیزیه عروسی", 
      price: 9500, 
      description: "عرضه کننده بهترین چادر های گاچ و جهیزیه عروسی و جهیزیه بافت در جهان", 
      imagePath: 'lib/assets/images/29.jpeg',
    ),
    //product14
    Product(
      name: "چادر", 
      price: 2500, 
      description: "عرضه کننده بهترین چادر های گاچ و جهیزیه عروسی و جهیزیه بافت در جهان", 
      imagePath: 'lib/assets/images/20.jpeg',
    ),
    //product15
    Product(
      name: "جهیزیه بافت",  
      price: 7500, 
      description: "عرضه کننده بهترین چادر های گاچ و جهیزیه عروسی و جهیزیه بافت در جهان",  
      imagePath: 'lib/assets/images/25.jpeg',
    ),
    //product16
    Product(
      name: "چادر", 
      price: 2500, 
      description: "عرضه کننده بهترین چادر های گاچ و جهیزیه عروسی و جهیزیه بافت در جهان",  
      imagePath: 'lib/assets/images/1.jpeg',
    ),
    //product17
    Product(
      name: "جهیزیه بافت",  
      price: 7500, 
      description: "عرضه کننده بهترین چادر های گاچ و جهیزیه عروسی و جهیزیه بافت در جهان", 
      imagePath: 'lib/assets/images/27.jpeg',
    ),
    //product18
    Product(
      name: "چادر", 
      price: 2500, 
      description: "عرضه کننده بهترین چادر های گاچ و جهیزیه عروسی و جهیزیه بافت در جهان", 
      imagePath: 'lib/assets/images/3.jpeg',
    ),
    
    
  ];


  //user cart
  final List<Product> _cart = [];


  //get product list
  List<Product> get shop => _shop;


  //get user cart
  List<Product> get cart => _cart;


  //add item to cart
  void addToCart(Product item){
    _cart.add(item);
    notifyListeners();
  }


  //remove item from cart  
  void removeFromCart(Product item){
    _cart.remove(item);
    notifyListeners();
  }
}