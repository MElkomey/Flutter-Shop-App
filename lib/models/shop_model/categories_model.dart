class CategoriesModel{
  bool? status;
  CategoriesDataModel? data;
  CategoriesModel.fromJson(Map<String,dynamic> json){
    status= json['status'];
    data=CategoriesDataModel.fromJson(json['data']);
  }

}

class CategoriesDataModel{
int? currentPage;
List<DataModel> data=[];

CategoriesDataModel.fromJson(Map<String,dynamic> json){
  currentPage= json['current_page'];
  json['data'].forEach((element){
    data.add(DataModel.formJson(element));
  });
  
}

}

class DataModel{
int? id;
String? name;
String? image;
DataModel.formJson(Map<String,dynamic> json){
  id= json['id'];
  name=json['name'];
  image=json['image'];
}
}


// "status": true,
// "message": null,
// "data": {
// "current_page": 1,
// "data": [
// {
// "id": 44,
// "name": "اجهزه الكترونيه",
// "image": "https://student.valuxapps.com/storage/uploads/categories/16301438353uCFh.29118.jpg"
// },