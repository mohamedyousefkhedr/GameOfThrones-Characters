class Character {
  late int id;
  late String firstName;
  late String lastName;
  late String fullName;
  late String title;
  late String family;
  late String image;
  late String imageUrl;



  Character.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    fullName = json['fullName'];
    title = json['title'];
    family = json['family'];
    image = json['image'];
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['firstName'] = firstName;
    data['lastName'] =lastName;
    data['fullName'] = fullName;
    data['title'] = title;
    data['family'] = family;
    data['image'] = image;
    data['imageUrl'] = imageUrl;
    return data;
  }
}
