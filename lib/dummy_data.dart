class CategoryList {
  final String categoryName;

  CategoryList({required this.categoryName});
}

class ItemModel {
  final String itemName;

  ItemModel(this.itemName);
}

final categoryList = List.generate(100, (index) => CategoryList(categoryName: "Category $index"));

final dummyItems = List.generate(1000, (index) => ItemModel("Item $index"));
