import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_complete_guide/models/http_exception.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;
  final token;
  final user_id;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFavorite = false,
    @required this.token,
    @required this.user_id
  
  });

  void toggleFavoriteStatus()async{

    final url = Uri.parse('https://flutter-update-9de56-default-rtdb.firebaseio.com/${this.user_id}/${this.id}.json?auth=$token');
        isFavorite = !isFavorite;
    notifyListeners();
    
    final response = await http.put(url,body: json.encode(
      this.isFavorite
    ));
    
    if(response.statusCode >=400){
      print(response.statusCode);
       isFavorite = !isFavorite;
    notifyListeners();
      throw HttpException("Could not add as favorite");
    }
   
  

  }
}
