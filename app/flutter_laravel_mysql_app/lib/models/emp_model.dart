class EmpModel {
  int? id;
  String? firstname;
  String? lastname;
  EmpModel({
    this.id,
    this.firstname,
    this.lastname,
  });

  factory EmpModel.fromJson(Map<String, dynamic> json) {
    return EmpModel(
      id: json['id'] as int,
      firstname: json['firstname'] as String,
      lastname: json['lastname'] as String,
    );
  }
}
