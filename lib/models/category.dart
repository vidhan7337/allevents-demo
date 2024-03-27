class Category {
  String? category;
  String? data;

  Category({this.category, this.data});

  Category.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category'] = this.category;
    data['data'] = this.data;
    return data;
  }
}