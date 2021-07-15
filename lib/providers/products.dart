import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:http/http.dart'as http;
import '../models/http_exception.dart';
import '../providers/product.dart';


class Products with ChangeNotifier {
  List<Product> _items = [
    Product(
      id: "1",
      title: "Man White T-Shirt",
      description: "Man White Regular Fit Polo Neck Polo T-Shirt",
      price: 200,
      avatar:
      "https://retail.amit-learning.com/images/products/mFXrS9i3y07IT9ic7jgcfq90GtMhf91WdlydLsnt.jpg",
    ),
    Product(
      id: "2",
      title: "Shirt Dress Short Sleeves And Tie Ups - MULTISHADE BLACK",
      description: "Strike a modern and smart look wearing this shirt dress this season. Printed all over, it will enhance the look of your attire and the tie-up at the waist lends a better fit. It has short sleeves and is made from superior quality material.",
      price:  290,
      avatar:
      "https://retail.amit-learning.com/images/products/ZvQcRNN9570Lw927SOmOI02xgasfysuT616SBdlp.jpg",
    ),
    Product(
      id: "3",
      title: "Three Men Socks Ankle",
      description: "Solo Bundle OF Three Men Socks Ankle",
      price: 80,
      avatar:
      "https://retail.amit-learning.com/images/products/5dw5Lk0m8hloh8wBdsqL20JD602qKmXEVo4KyR9v.jpg",

    ),
    Product(
      id: "4",
      title: "Activ Round Toe",
      description: "Activ Round Toe Casual Sneakers - Navy Blue",
      price: 600,
      avatar:
      "https://retail.amit-learning.com/images/products/QZMwBjevtyPcIicsSCoQyercnimEzQrmOVSbaFCq.jpg",
    ),
    Product(
      id: "5",
      title: "LG TV - 32-inch",
      description: "An HD screen delivers accurate images in stunning resolution and vivid color, The advanced image processor adjusts color for richer, more natural images. Enjoy the beauty of nature’s true colors on your TV screen.",
      price: 4000,
      avatar:
      "https://retail.amit-learning.com/images/products/G7LX8TpZzABsoYRCwVTOL4pF9o3Kf32BsGrQ1U9n.jpg",
    ),
    Product(
      id: "6",
      title: "Smart Display - 55-inch",
      description: "4K provides much more detailed and less pixel visible images than 1080p. 4K delivers better-looking image for larger screen sizes.",
      price: 6500,
      avatar:
      "https://retail.amit-learning.com/images/products/qaFVExb7Anh4liJKPLbElah2SasrC8TWUA3iaAGh.jpg",
    ),
    Product(
        id: "7",
        title: "Anti Hot Feeding Bottle - 250ml",
        description: "Mother's love is the greatest and selfless, mumlove brand presented this kind of love in good quality products. In the 90’s, Mrs Lou celebrated the birth of little baby in the period of running business. Combined with dedication working and the love of a mother, she builds the \"mumlove\" bottle and nipple brand. It always insists on the brand idea of “safety, eco-friendly”. Adhere to the conception of mother's love greatness and insist to give the best products to customer.",
        price: 80,
        avatar:
        "https://retail.amit-learning.com/images/products/NnXVKMewKJMs0tXYsaUFDy31bnpsM8Tjs18Jbzgq.jpg",
    ),
    Product(
      id: "8",
      title: "Cerelac – 125g",
      description: "Cerelac Iron+ With Wheat Wtht & Milk – 125g",
      price: 26,
      avatar:
      "https://retail.amit-learning.com/images/products/x5JCYgATZL5kH7aHFMdnJi95tpAnJXqCA8fl7LUc.jpg",
    ),
    Product(
      id: "9",
      title: "White Braun Hair Remover",
      description: "The Braun SE 1170 Silk Epil features a contoured body to provide a firm, yet comfortable grip. It has been designed to provide a no slip hold. This epilator is extremely easy to use. It features a single large on/off switch. All you have to do is plug the epilator in the socket and press the switch to see it work its magic!",
      price: 450,
      avatar:
      "https://retail.amit-learning.com/images/products/QZMwBjevtyPcIicsSCoQyercnimEzQrmOVSbaFCq.jpg",
    ),
    Product(
      id: "10",
      title: "Nivea Cocoa - 200ml",
      description: "NIVEA Cocoa Butter Body cream intensively hydrates skin and provides long lasting moisture. The nourishing formula absorbs quickly and instantly moisturizes, leaving skin soft, smooth, and healthy looking.",
      price: 35,
      avatar:
      "https://retail.amit-learning.com/images/products/zELiT69pmRSpLaBCmdH5Ygmez4MaCoRU13rMcwM0.jpg",
    ),
    Product(
      id: "11",
      title: "Eva Shampoo 400ml + 1 Free",
      description: "Aloe Eva shampoo with Aloe Vera & Yoghurt Proteins improves hair volume, thickness and shine for thin hair - for dry & damaged hair",
      price: 90,
      avatar:
      "https://retail.amit-learning.com/images/products/Nc69KravsXuhUrg9PlXLEtBg9fBnzr0Atrtyqrtv.jpg",
    ),
    Product(
      id: "12",
      title: "Samsung Galaxy M11 - 32GB",
      description:" Samsung Galaxy M11 - 6.4-inch 32GB/3GB Dual SIM Mobile Phone - Black",
      price: 2500,
      avatar:
      "https://retail.amit-learning.com/images/products/zELiT69pmRSpLaBCmdH5Ygmez4MaCoRU13rMcwM0.jpg",
    ),
    Product(
      id: "13",
      title: "XIAOMI Redmi 8A",
      description: "XIAOMI Redmi 8A - 6.2-inch 32GB/2GB Dual SIM 4G Mobile Phone - Midnight Black",
      price: 1800,
      avatar:
      "https://retail.amit-learning.com/images/products/z5ZoadcxRtYPN9wEQb1YtxrIoCWTMHc3hwDEze07.jpg",
    ),
    Product(
      id: "14",
      title: "Hedya Vermicelli Pasta",
      description: "If you’re too busy to get to the grocery store, there are many ways for the grocery store to come to you! We are offering different food & care bundles providing all your everyday basics & essentials to be shipped right to you. We are Saving your time, stress, gas money, and exposing you to new types of products and brands that you can’t get at your local grocery store.",
      price: 4,
      avatar:
      "https://retail.amit-learning.com/images/products/1TSggeBV5GFZSGJu3NPk61hhMcuvo1FOuKI8Rv9V.jpg",
    ),
    Product(
      id: "15",
      title: "Star Pasta - 400gm",
      description: "If you’re too busy to get to the grocery store, there are many ways for the grocery store to come to you! We are offering different food & care bundles providing all your everyday basics & esse",
      price: 5,
      avatar:
      "https://retail.amit-learning.com/images/products/YwehN2Cv2DAROxwE7urA9dxazZmT9ULts1yUjyvS.jpg",
    ),
  ];

  String authToken;
  String userId;

  getData(String authTok,String uId,List<Product>products){
    authToken=authTok;
    userId=uId;
    _items=products;
    notifyListeners();
  }
  List<Product>get items{
    return [..._items];
  }

  List<Product>get favouritesItem{
    return _items.where((prodItem) => prodItem.isFavourite).toList();
  }

  Product findById(String id){
    return _items.firstWhere((prod) => prod.id==id);
  }

  Future<void> fetchAndSetProducts([bool filterByUser = false])async{

    final filteredString=filterByUser?'orderBy="creatorId"&equalTo="$userId"':'';

    var url="https://shop-bdcea-default-rtdb.firebaseio.com/products.json?auth=$authToken&$filteredString";

    try{
      final res =await http.get(url);
      final extractedData = json.decode(res.body)as Map<String , dynamic>;
      if(extractedData == null){
        return;
      }
      url="https://shop-bdcea-default-rtdb.firebaseio.com/userFavorites/$userId.json?auth=$authToken";
      final favRes = await http.get(url);
      final favData= json.decode(favRes.body);
      final List<Product> loadedProducts=[];
      /*
      extractedData.forEach((prodId,prodData) {
        loadedProducts.add(
          Product(
              id: prodId,
              title: prodData['title'],
              description: prodData['description'],
              price: prodData['price'],
              isFavourite: favData==null?false:favData[prodId]??false,
             avatar: prodData['avatar'],
          ),
        );
      });
       */
      //_items = loadedProducts;
      notifyListeners();
    }catch(e){
      throw e;
    }
  }

  Future<void> addProduct (Product product)async{
    final url="https://shop-bdcea-default-rtdb.firebaseio.com/products.json?auth=$authToken";

    try{
      final res= await http.post(url,body:json.encode({
        'title':product.title,
        'description':product.description,
        'avatar':product.avatar,
        'price':product.price,
        'creatorId':userId,
      }));
      final newProduct=Product(
        id: jsonDecode(res.body)['name'] ,
        title:product.title,
        description:product.description,
        avatar:product.avatar,
        price:product.price,
      );
      _items.add(newProduct);
      notifyListeners();
    } catch (e){
      throw e;
    }
  }

  Future<void> updateProduct(String id,Product newProduct)async{
    final prodIndex = _items.indexWhere((prod)=>prod.id==id);
    if(prodIndex>=0) {
      final url="https://shop-bdcea-default-rtdb.firebaseio.com/products/$id.json?auth=$authToken";

      await http.patch(url,body: json.encode({
        'title':newProduct.title,
        'description':newProduct.description,
        'avatar':newProduct.avatar,
        'price':newProduct.price,
      }));
      _items[prodIndex]=newProduct;
      notifyListeners();
    }else{
      print("......");
    }
    }
  Future<void> deleteProduct(String id)async{
    final url="https://shop-bdcea-default-rtdb.firebaseio.com/products/$id.json?auth=$authToken";
    final existingproductIndex =_items.indexWhere((prod) => prod.id==id);
    var existingproduct=_items[existingproductIndex] ;
    _items.removeAt(existingproductIndex);
    notifyListeners();

    final res=await http .delete(url);
    if(res.statusCode>=400){
      _items.insert(existingproductIndex, existingproduct);
      notifyListeners();
      throw HttpException('Could not delete product.');
    }
    existingproduct=null;
  }

  }
