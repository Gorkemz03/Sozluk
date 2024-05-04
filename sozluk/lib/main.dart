import 'package:flutter/material.dart';
import 'package:sozluk/Kelimelerdao.dart';
import 'package:sozluk/detaySayfa.dart';
import 'kelimeler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home:  AnaSayfa(),
    );
  }
}

class AnaSayfa extends StatefulWidget {
  @override
  State<AnaSayfa> createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {

  bool aramaYapiliyorMu = false;
  String aramaKelimesi = "";

  Future<List<kelimeler>> tumKelimelerGoster() async{
    var kelimelerListesi = await Kelimelerdao().tumKelimeler();

    return kelimelerListesi;
  }

  Future<List<kelimeler>> aramaYap(String aramaKelimesi) async{
    var kelimelerListesi = await Kelimelerdao().searchKelime(aramaKelimesi);

    return kelimelerListesi;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black38,
        title: aramaYapiliyorMu
            ? TextField(
          decoration: const InputDecoration(
            hintText: "Arama İçin Birşey Yazın.",
          ),
          onChanged: (aramaSonucu) {
            print("Arama Sonucu: $aramaSonucu");
            setState(() {
              aramaKelimesi = aramaSonucu;
            });
          },
        )
            : Text("Ana Sayfa"),
        actions: [
          aramaYapiliyorMu ? IconButton(
            onPressed: () {
              setState(() {
                aramaYapiliyorMu = false;
                aramaKelimesi = "";
              });
            },
                icon: Icon(Icons.cancel),
          ) : IconButton(
            onPressed: () {
              setState(() {
                aramaYapiliyorMu = true;
              });
            },
                icon: Icon(Icons.search),
          ),
        ],
      ),

      body: FutureBuilder<List<kelimeler>>(
        future: aramaYapiliyorMu ? aramaYap(aramaKelimesi) :tumKelimelerGoster(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            var kelimelerListesi = snapshot.data;
            return ListView.builder(
                itemCount: kelimelerListesi!.length,
                itemBuilder: (context,index){
                  var kelime = kelimelerListesi[index];
                  return GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => detaySayfa()));
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20.0,right: 15.0,left: 15.0),
                      child: SizedBox(
                        height: 75,
                        child: Card(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(kelime.ingilizce,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
                              Text(kelime.turkce,style: TextStyle(fontSize: 23),),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }
            );

          }else{
            return Center();
          }
        },
      ),


    );
  }
}
