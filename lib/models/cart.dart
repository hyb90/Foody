import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
class CartItem {
  final String id;
  final String name;
  final String image;
  final int quantity;
  final double price;

  CartItem(
      {@required this.id,
        @required this.name,
        @required this.image,
        @required this.quantity,
        @required this.price});
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  void addItem(String itId, String name, String image,double price) {
    if (_items.containsKey(itId)) {
      _items.update(
          itId,
              (existingCartItem) => CartItem(
            id: itId,
            name: existingCartItem.name,
            quantity: existingCartItem.quantity + 1,
            image: existingCartItem.image,
            price: existingCartItem.price,));
      Fluttertoast.showToast(
          msg: "Item quantity in the cart has updated",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    } else {
      _items.putIfAbsent(
          itId,
              () => CartItem(
              name: name,
              id: itId,
              quantity: 1,
              image: image,
              price: price
          ));
      Fluttertoast.showToast(
          msg: "Item has added to cart",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }

    notifyListeners();
  }

  void removeItem(String id) {
    _items.remove(id);
    Fluttertoast.showToast(
        msg: "Item has removed from cart",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
    notifyListeners();
  }

  void removeSingleItem(String id) {
    if (!_items.containsKey(id)) {
      return;
    }
    if (_items[id].quantity > 1) {
      _items.update(
          id,
              (existingCartItem) => CartItem(
              id: id,
              name: existingCartItem.name,
              quantity: existingCartItem.quantity - 1,
              image: existingCartItem.image,
              price: existingCartItem.price));
      Fluttertoast.showToast(
          msg: "Item quantity has updated",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
      notifyListeners();
    }
    else{
      _items.remove(id);
      Fluttertoast.showToast(
          msg: "Item has removed from cart",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
      notifyListeners();
    }

  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void clear() {
    _items = {};
    Fluttertoast.showToast(
        msg: "Cart has cleared",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
    notifyListeners();
  }
}