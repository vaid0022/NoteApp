

class addModel{
  String Title;
  String Description;

  addModel({required this.Title,required this.Description});

  Map<String,dynamic> map()
  {
    return
        {
          "titlenote":Title,
          "noteDescription":Description
        };
  }
}

class updateModel{
  int Note_no;
  String Note_title;
  String note_description;

  updateModel({required this.Note_no,required this.Note_title,required this.note_description});

  Map<String,dynamic>map()
  {
    return {
      "noteno":Note_no,
      "titlenote":Note_title,
      "noteDescription":note_description
  };

}
}

class DeleteModel{
  int Note_no;


  DeleteModel({required this.Note_no});

  Map<String,dynamic>map()
  {
    return {
      "noteno":Note_no,

  };

}




}
