class ProductModel {
   String productId;
  final String productname;
  final String productprice;
  final int productQuantity;
  final String productRating;
  // ignore: prefer_typing_uninitialized_variables
  final productImage;

  ProductModel(this.productname, this.productprice, this.productQuantity,
      this.productImage, this.productId,this.productRating);

  Map<String, dynamic> toJson() => {
        'producId': productId,
        'productname': productname,
        'productprice': productprice,
        'productquantity': productQuantity,
        'productImage': productImage,
        'productRating':productRating
      };

  Map<String, dynamic> fromJson() => {
        'producId': productId,
        'productname': productname,
        'productprice': productprice,
        'productquantity': productQuantity,
        'productImage': productImage,
        'productRating':productRating
      };
}
