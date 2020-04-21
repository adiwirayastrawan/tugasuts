import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:app_1/index.dart';
import './index.dart';

class TambahData extends StatefulWidget {
  @override
  _TambahDataState createState() => _TambahDataState();
}

class _TambahDataState extends State<TambahData> {
  TextEditingController controllerNama = new TextEditingController();
  TextEditingController controllerProduk = new TextEditingController();
  TextEditingController controllerHarga = new TextEditingController();
  TextEditingController controllerTanggal = new TextEditingController();
  final format = DateFormat('yyyy-MM-dd');

  void tambahData() {
    var url = "http://192.168.6.157/cipenjualan/index.php/cipenjualan/save";

    http.post(url, body: {
      "nama": controllerNama.text,
      "produk": controllerProduk.text,
      "harga": controllerHarga.text,
      "tanggal": controllerTanggal.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.blue,
          title: new Text("TAMBAH DATA"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            children: <Widget>[
              new Column(
                children: <Widget>[
                  new TextField(
                      controller: controllerNama,
                      decoration: new InputDecoration(
                          hintText: "Nama", labelText: "Nama Pembeli")),
                  new TextField(
                      controller: controllerProduk,
                      decoration: new InputDecoration(
                          hintText: "Produk", labelText: "Produk")),
                  new TextField(
                      controller: controllerHarga,
                      decoration: new InputDecoration(
                          hintText: "Harga", labelText: "Harga")),
                  new DateTimeField(
                    controller: controllerTanggal,
                    format: format,
                    onShowPicker: (context, currentValue) {
                      return showDatePicker(
                          context: context,
                          initialDate: currentValue ?? DateTime.now(),
                          firstDate: DateTime(2020),
                          lastDate: DateTime(2045));
                    },
                    decoration: new InputDecoration(
                        hintText: "Tanggal", labelText: "Tanggal Pembelian"),
                  ),
                  new Padding(
                    padding: const EdgeInsets.all(10.0),
                  ),
                  new RaisedButton(
                      child: new Text("TAMBAH DATA"),
                      color: Colors.blue,
                      onPressed: () {
                        tambahData();
                        Navigator.of(context).push(new MaterialPageRoute(
                            builder: (BuildContext context) => new Index()));
                      })
                ],
              )
            ],
          ),
        ));
  }
}
