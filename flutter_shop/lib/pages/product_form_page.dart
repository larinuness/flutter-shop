import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({Key? key}) : super(key: key);

  @override
  _ProductFormPageState createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  @override
  Widget build(BuildContext context) {
    final _priceFocus = FocusNode();
    final _descriptionFocus = FocusNode();
    final _imageUrlFocus = FocusNode();
    final _imageUrlController = TextEditingController();

    @override
    void dispose() {
      super.dispose();
      _priceFocus.dispose();
      _descriptionFocus.dispose();
      _imageUrlFocus.dispose();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulário de Produto'),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Nome'),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  //vai focar no field de preço
                  FocusScope.of(context).requestFocus(_priceFocus);
                },
              ),
              TextFormField(
                focusNode: _priceFocus,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: const InputDecoration(labelText: 'Preço'),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  //vai focar no field de descrição
                  FocusScope.of(context).requestFocus(_descriptionFocus);
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Descrição'),
                textInputAction: TextInputAction.next,
                focusNode: _descriptionFocus,
                maxLines: 3,
                onFieldSubmitted: (_) {
                  //vai focar no field de descrição
                  FocusScope.of(context).requestFocus(_imageUrlFocus);
                },
              ),
              Row(
                //alinha os dois items
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _imageUrlController,
                      keyboardType: TextInputType.url,
                      decoration:
                          const InputDecoration(labelText: 'Url da imagem'),
                      textInputAction: TextInputAction.next,
                      focusNode: _imageUrlFocus,
                      maxLines: 3,
                    ),
                  ),
                  Container(
                    height: 100,
                    width: 100,
                    margin: const EdgeInsets.only(top: 10, left: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.teal, width: 1),
                    ),
                    alignment: Alignment.center,
                    child: _imageUrlController.text.isEmpty
                        ? const Text('Informe a url')
                        : FittedBox(
                            child: Image.network(_imageUrlController.text),
                            fit: BoxFit.cover),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
