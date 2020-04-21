import 'package:flutter/material.dart';
import './editdetail.dart';
import 'package:http/http.dart' as http;
import 'index.dart';

class DetailPenjualan extends StatefulWidget {
  List list;
  int index;
  DetailPenjualan({this.index, this.list});
  @override
  _DetailPenjualanState createState() => _DetailPenjualanState();
}

class _DetailPenjualanState extends State<DetailPenjualan> {
  void confirm(id) {
    AlertDialog alertDialog = new AlertDialog(
      content: new Text(
          "Are you sure want to delete '${widget.list[widget.index]['nama']}' with '${widget.list[widget.index]['merk']}'"),
      actions: <Widget>[
        new RaisedButton(
          child: new Text("OK Delete!"),
          color: Colors.red[400],
          onPressed: () {
            deletePenjualan(id);
            Navigator.of(context).push(new MaterialPageRoute(
              builder: (BuildContext context) => new Index(),
            ));
          },
        ),
        new RaisedButton(
          child: new Text("Cancel!"),
          color: Colors.lightBlueAccent,
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );

    showDialog(context: context, child: alertDialog);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.blue,
        title: new Text("${widget.list[widget.index]['nama']}"),
      ),
      body: new Container(
          height: 250.0,
          padding: const EdgeInsets.all(20.0),
          child: new Card(
            child: new Center(
                child: new Column(
              children: <Widget>[
                new Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                ),
                new Text(
                  widget.list[widget.index]['nama'],
                  style: new TextStyle(fontSize: 20.0),
                ),
                new Text(
                  "Produk : ${widget.list[widget.index]['produk']}",
                  style: new TextStyle(fontSize: 18.0),
                ),
                new Text(
                  "Harga : ${widget.list[widget.index]['harga']}",
                  style: new TextStyle(fontSize: 18.0),
                ),
                new Text(
                  "Tanggal : ${widget.list[widget.index]['tanggal']}",
                  style: new TextStyle(fontSize: 18.0),
                ),
                new Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                ),
                new Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    new RaisedButton(
                      child: new Text("Edit"),
                      color: Colors.blue,
                      onPressed: () =>
                          Navigator.of(context).push(new MaterialPageRoute(
                        builder: (BuildContext context) => new EditDetail(
                          list: widget.list,
                          index: widget.index,
                        ),
                      )),
                    ),
                    Padding(padding: const EdgeInsets.all(10.0)),
                    new RaisedButton(
                      child: new Text("Delete"),
                      color: Colors.blue,
                      onPressed: () => confirm(widget.list[widget.index]['id']),
                    ),
                  ],
                )
              ],
            )),
          )),
    );
  }

  Future<http.Response> deletePenjualan(id) async {
    final http.Response response = await http.delete(
        "http://192.168.6.157/cipenjualan/index.php/cipenjualan/delete/$id");

    return response;
  }
}
