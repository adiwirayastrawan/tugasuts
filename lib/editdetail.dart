import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import './index.dart';

class EditDetail extends StatefulWidget {
  final List list;
  final int index;

  EditDetail({this.list, this.index});

  @override
  _EditDetailState createState() => _EditDetailState();
}

class _EditDetailState extends State<EditDetail> {
  TextEditingController controllerNama;
  TextEditingController controllerProduk;
  TextEditingController controllerHarga;
  TextEditingController controllerTanggal;
  final format = DateFormat('yyyy-MM-dd');

  void editdetail() {
    var url =
        "http://192.168.6.157/cipenjualan/index.php/cipenjualan/save_update";
    http.post(url, body: {
      "id": widget.list[widget.index]['id'],
      "nama": controllerNama.text,
      "produk": controllerProduk.text,
      "harga": controllerHarga.text,
      "tanggal": controllerTanggal.text,
    });
  }

  @override
  void initState() {
    controllerNama =
        new TextEditingController(text: widget.list[widget.index]['nama']);
    controllerProduk =
        new TextEditingController(text: widget.list[widget.index]['produk']);
    controllerHarga =
        new TextEditingController(text: widget.list[widget.index]['harga']);
    controllerTanggal =
        new TextEditingController(text: widget.list[widget.index]['tanggal']);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: new Text("EDIT DATA"),
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
                        hintText: "Produk", labelText: "Nama Produk")),
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
                        hintText: "Tanggal", labelText: "Tanggal pembelian")),
                new Padding(
                  padding: const EdgeInsets.all(10.0),
                ),
                new RaisedButton(
                  child: new Text("Ok"),
                  color: Colors.blue,
                  onPressed: () {
                    editdetail();
                    Navigator.of(context).push(new MaterialPageRoute(
                        builder: (BuildContext context) => new Index()));
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
