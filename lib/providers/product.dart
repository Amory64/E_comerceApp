import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import "package:http/http.dart" as http;


class Product with ChangeNotifier{
    final String id;
    final String title;
    final String description;
    final double price;
    final String avatar ;
    bool isFavourite;

    Product({
        @required this.id,
        @required this.title,
        @required this.description,
        @required this.price,
        @required this.avatar,
        this.isFavourite = false,
    });

    void _setFavValue(bool newValue){
        isFavourite = newValue;
        notifyListeners();
    }

    Future<void> toggleFavouriteStatus(String token,String userId)async{
        final oldStatus = isFavourite;
        isFavourite = !isFavourite;
        notifyListeners();

        final url="https://shop-bdcea-default-rtdb.firebaseio.com/userFavorites/$userId/$id.json?auth=$token";
        try{
            final res = await http.put(url,body: json.encode(isFavourite));
            if(res.statusCode >=400){
                _setFavValue(oldStatus);
            }

        }catch(e){
            _setFavValue(oldStatus);

        }
    }

}