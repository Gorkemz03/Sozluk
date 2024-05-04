import 'package:sozluk/VeritabaniYardimcisi.dart';
import 'package:sozluk/kelimeler.dart';

class Kelimelerdao{

  Future<List<kelimeler>> tumKelimeler() async{
    var db = await VeritabaniYardimcisi.veritabaniErisim();

    List<Map<String,dynamic>> maps = await db.rawQuery("SELECT * FROM kelimeler");

    return List.generate(maps.length, (index) {
      var satir = maps[index];
      return kelimeler(satir["kelime_id"], satir["ingilizce"], satir["turkce"]);

    }) ;
  }

  Future<List<kelimeler>> searchKelime(String aramaKelimesi) async {
    try {
      var db = await VeritabaniYardimcisi.veritabaniErisim();

      List<Map<String,dynamic>> maps = await db.rawQuery("SELECT * FROM kelimeler WHERE ingilizce like '%$aramaKelimesi%'");

      return List.generate(maps.length, (index) {
        var satir = maps[index];
        return kelimeler(satir["kelime_id"], satir["ingilizce"], satir["turkce"]);
      });
    } catch (e) {
      print("Hata oluştu: $e");
      return []; // Return an empty list in case of an error
    }
  }



}