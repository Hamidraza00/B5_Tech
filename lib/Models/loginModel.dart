class Users{
  final String user_id;
  final String password;

  Users({
    required this.user_id,
    required this.password
});
  factory
      Users.fromMap(Map<dynamic,dynamic>json){
    return Users(
      user_id: json['user_id'],
      password: json['password']
    );
  }
  Map<String,dynamic>toMap(){
    return{
      'userId':user_id,
      'userPassword':password
    };
  }
}