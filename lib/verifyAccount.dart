import 'package:flutter/material.dart';

import 'main.dart';

class VerifyAccount extends State<MyHomePage> {

  get confirm => null;


  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
          backgroundColor: Colors.white,
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: const Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                width: double.infinity,
                height: 70,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                      size: 24.0,
                      semanticLabel: 'Text to announce in accessibility modes',
                    ),
                    Align(
                      alignment: AlignmentDirectional(-1, 0),
                      child: Text(
                        'Xác nhận tài khoản',
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              ),
            ],
            // Text(widget.title),
          )),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 520,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    width: double.infinity,
                    height: 50,
                    child: const Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Align(
                          alignment: AlignmentDirectional(0, 0),
                          child: Padding(
                            padding:
                            EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Chúng tôi đã gửi SMS kèm tới mã tới ',
                                  style: TextStyle(fontSize: 10),
                                ),
                                Text(
                                  '0394939339',
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                      width: double.infinity,
                      height: 50,
                      alignment: const AlignmentDirectional(0.00, 0.00),
                      child: const Text(
                        'Nhập mã gồm 5 chữ số từ SMS của bạn.',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      )),
                  Container(
                      width: 180,
                      height: 100,
                      child: const Align(
                        alignment: AlignmentDirectional(0.00, 0.00),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              'FB- ',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                            Expanded(
                                child: Align(
                                    alignment: AlignmentDirectional(0.00, 0.00),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          8, 0, 8, 0),
                                      child: TextField(
                                        decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.black,
                                              width: 2,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.black,
                                              width: 2,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )))
                          ],
                        ),
                      )),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(30, 0, 30, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 250,
                          height: 50,
                          margin: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                          child: ElevatedButton(
                            style: const ButtonStyle(
                              backgroundColor:
                              MaterialStatePropertyAll<Color>(Colors.blue),
                            ),
                            onPressed: () {},
                            child: const Text(
                              'Xác nhận',
                              style: TextStyle(
                                  fontSize: 12.0, color: Colors.white),
                            ),
                          ),
                        ),
                        Container(
                          width: 250,
                          height: 50,
                          margin: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                          child: ElevatedButton(
                            style: const ButtonStyle(
                              backgroundColor:
                              MaterialStatePropertyAll<Color>(Colors.blue),
                            ),
                            onPressed: () {},
                            child: const Text(
                              'Tôi không nhận được mã',
                              style: TextStyle(
                                  fontSize: 12.0, color: Colors.white),
                            ),
                          ),
                        ),
                        Container(
                          width: 250,
                          height: 50,
                          margin: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                          child: TextButton(
                              onPressed: () {}, child: const Text('Đăng xuất')),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
