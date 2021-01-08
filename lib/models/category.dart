class Categories {
  final List<Category> categories;

  Categories({
    this.categories,
  });

  factory Categories.fromJson(List<dynamic> parsedJson) {

    List<Category> categories = new List<Category>();
    categories = parsedJson.map((i)=>Category.fromJson(i)).toList();

    return new Categories(
        categories: categories
    );
  }
}


class Category {
  int id;
  String name;
  String image;
  List<Meals> meals;

  Category({this.id, this.name, this.image, this.meals});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    if (json['meals'] != null) {
      meals = new List<Meals>();
      json['meals'].forEach((v) {
        meals.add(new Meals.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    if (this.meals != null) {
      data['meals'] = this.meals.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Meals {
  int id;
  String name;
  String image;
  double price;
  bool favorite;
  Meals({this.id, this.name, this.image, this.price, this.favorite});

  Meals.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['price'] = this.price;
    return data;
  }
}
