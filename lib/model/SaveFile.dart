import 'dart:convert';

class SaveFile{
   String title;
   String value;

   SaveFile(this.title, this.value);

   factory SaveFile.fromJson(Map<String, dynamic> jsonData){
      return SaveFile(
          jsonData['title'],
          jsonData['value']
      );
   }

   static Map<String, dynamic> toMap(SaveFile saveFile) => {
      'title': saveFile.title,
      'value': saveFile.value,
   };

   static String encode(List<SaveFile> saveFiles) => json.encode(
      saveFiles
          .map<Map<String, dynamic>>((saveFile) => SaveFile.toMap(saveFile))
          .toList(),
   );

   static List<SaveFile> decode(String musics) =>
       (json.decode(musics) as List<dynamic>)
           .map<SaveFile>((item) => SaveFile.fromJson(item))
           .toList();

}