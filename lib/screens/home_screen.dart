import 'package:dictionary/db/db_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  final textController = TextEditingController();

  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  List<Map<String, dynamic>> _words = [];
  bool _isLoading = true;

  void _refreshWords() async {
    final data = await SQLHelper.getItems();
    setState(() {
      _words = data;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshWords();
    print("..number of items ${_words.length}");
  }

  Future<void> _addItem() async {
    await SQLHelper.createItem(
        _nameController.text, _descriptionController.text);
    _refreshWords();
    print("..number of items ${_words.length}");
  }

  Future<void> _updateItem(int id) async {
    await SQLHelper.updateItem(
        id, _nameController.text, _descriptionController.text);
    _refreshWords();
  }

  Future<void> _deleteItem(int id) async {
    await SQLHelper.deleteItem(id);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Successfully deleted a word!'),
    ));
    _refreshWords();
  }

  void _showForm(int? id) async {
    if (id != null) {
      final existingWord = _words.firstWhere((element) => element['id'] == id);
      _nameController.text = existingWord['wordName'];
      _descriptionController.text = existingWord['wordDescription'];
    }

    showModalBottomSheet(
        context: context,
        elevation: 5,
        isScrollControlled: true,
        builder: (_) => Container(
              padding: EdgeInsets.only(
                top: 15,
                left: 15,
                right: 15,
                bottom: MediaQuery.of(context).viewInsets.bottom + 120,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(hintText: "Name"),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(hintText: "Description"),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (id == null) {
                        await _addItem();
                      } else {
                        await _updateItem(id);
                      }
                      _nameController.text = '';
                      _descriptionController.text = '';

                      Navigator.of(context).pop();
                    },
                    child: Text(id == null ? 'Create New' : 'Update'),
                  )
                ],
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SQL')),
      body: ListView.builder(
          itemCount: _words.length,
          itemBuilder: (context, index) => Card(
                color: Colors.grey,
                margin: const EdgeInsets.all(10),
                child: ListTile(
                  title: Text(_words[index]['wordName']),
                  subtitle: Text(_words[index]['wordDescription']),
                  trailing: SizedBox(
                    width: 100,
                    child: Row(
                      children: [
                        IconButton(
                            onPressed: () => _showForm(_words[index]['id']),
                            icon: const Icon(Icons.edit)),
                        IconButton(
                            onPressed: () => _deleteItem(_words[index]['id']),
                            icon: const Icon(Icons.delete))
                      ],
                    ),
                  ),
                ),
              )),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save),
        onPressed: () {
          _showForm(null);
        },
      ),
    );
  }
}
