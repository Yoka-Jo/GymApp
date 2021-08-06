class UserModel {
   String name;
   int weight;
   int height;


  UserModel.fromJson(Map<String , dynamic> json){
    name = json["userName"];
    weight = json["weight"];
    height = json["height"];
  }
  
}