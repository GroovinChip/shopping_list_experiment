import 'package:flutter/material.dart';

class StoreSettings extends StatefulWidget {
  const StoreSettings({
    Key? key,
    required this.storeName,
  }) : super(key: key);

  final String storeName;

  @override
  _StoreSettingsState createState() => _StoreSettingsState();
}

class _StoreSettingsState extends State<StoreSettings> {
  late TextEditingController storeController;

  @override
  void initState() {
    super.initState();
    storeController = TextEditingController(text: widget.storeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.storeName} Settings'),
        actions: [
          IconButton(
            tooltip: 'Save',
            icon: Icon(Icons.save),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: storeController,
                enabled: false,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.shade300,
                  labelText: 'Store name',
                ),
              ),
            ),
            /*Expanded(
              child: Container(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                  ),
                  icon: Icon(Icons.delete),
                  label: Text('Delete store'),
                  onPressed: () {},
                ),
              ),
            ),*/
          ],
        ),
      ),
    );
  }
}
