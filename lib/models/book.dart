class Book {
  final int coffeeId;
  final String coffeeName;
  final String coffeeDescription;
  final int coffeePrice;
  final String coffeePicture;

//Book Constructor
  Book(
    {required this.coffeeId, 
    required this.coffeeName, 
    required this.coffeeDescription, 
    required this.coffeePrice, 
    required this.coffeePicture, 
});

  //using factory for book constructor
  factory Book.fromJson(dynamic json){
    return Book(
       coffeeId: json['coffeeId'] as int,
        coffeeName: json['coffeeName'] as String,
        coffeeDescription: json['coffeeDescription'] as String,
        coffeePrice: json['coffeePrice'] as int,
        coffeePicture: json['coffeePicture'] as String,
        );
  }

  @override
  String toString() {
    return '{ $coffeeId, $coffeeName,$coffeeDescription,$coffeePrice,$coffeePicture  }';
  }
}
