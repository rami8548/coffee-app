import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food/FeaturesStore/Presentation/AddProduct/add_product_cubit.dart';

class AddProductScreen extends StatefulWidget {
  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final _idController = TextEditingController();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _imageUrlController = TextEditingController();
  final _reviewController = TextEditingController();
  final _priceController = TextEditingController();
  final _flavorNotesController = TextEditingController();
  final _originController = TextEditingController();
  final _ingredientsController = TextEditingController();
  final _caffeineContentController = TextEditingController();
  final _containsController = TextEditingController();
  final _quantityController = TextEditingController();
  List<TextEditingController> _sizeControllers = [];

  @override
  void dispose() {
    _idController.dispose();
    _nameController.dispose();
    _descriptionController.dispose();
    _imageUrlController.dispose();
    _reviewController.dispose();
    _priceController.dispose();
    _flavorNotesController.dispose();
    _originController.dispose();
    _ingredientsController.dispose();
    _caffeineContentController.dispose();
    _containsController.dispose();
    _quantityController.dispose();
    for (var controller in _sizeControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final sizes = _sizeControllers.map((controller) => controller.text).toList();

      String imageUrl = _imageUrlController.text;
      if (context.read<AddProductCubit>().imageFile != null) {
        imageUrl = await context.read<AddProductCubit>().uploadImageToFirebase();
      }

      context.read<AddProductCubit>().addProduct(
        imageUrl: imageUrl,
        name: _nameController.text,
        flavorNotes: _flavorNotesController.text,
        price: num.parse(_priceController.text),
        review: num.parse(_reviewController.text),
        description: _descriptionController.text,
        caffeineContent: _caffeineContentController.text,
        contains: _containsController.text.split(',').map((e) => e.trim()).toList(),
        ingredients: _ingredientsController.text.split(',').map((e) => e.trim()).toList(),
        sizes: sizes,
        origin: _originController.text.split(',').map((e) => e.trim()).toList(),
      );
    }
  }

  void _addSizeField() {
    setState(() {
      _sizeControllers.add(TextEditingController());
    });
  }

  void _removeSizeField(int index) {
    setState(() {
      _sizeControllers.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddProductCubit(),
      child: BlocListener<AddProductCubit, AddProductState>(
        listener: (context, state) {
          if (state is SuccessAddProduct) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Product added successfully!'),
              backgroundColor: Colors.green,
            ));
          } else if (state is ErrorAddProduct) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Failed to add product: ${state.error}'),
              backgroundColor: Colors.red,
            ));
          } else if (state is SuccessSelectImageProduct) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Image selected successfully!'),
              backgroundColor: Colors.blue,
            ));
            // Update image URL field with the file path
            _imageUrlController.text = context.read<AddProductCubit>().imageFile!.path;
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Add Product'),
            backgroundColor: Colors.teal,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildTextField(_idController, 'ID'),
                    _buildTextField(_nameController, 'Name'),
                    _buildTextField(_descriptionController, 'Description', maxLines: 3),
                    _buildTextField(_imageUrlController, 'Image URL'),
                    _buildTextField(_reviewController, 'Review', inputType: TextInputType.number),
                    _buildTextField(_priceController, 'Price', inputType: TextInputType.number),
                    _buildTextField(_flavorNotesController, 'Flavor Notes'),
                    _buildTextField(_originController, 'Origin (comma separated)'),
                    _buildTextField(_ingredientsController, 'Ingredients (comma separated)'),
                    _buildTextField(_caffeineContentController, 'Caffeine Content'),
                    _buildTextField(_containsController, 'Contains (comma separated)'),
                    _buildTextField(_quantityController, 'Quantity', inputType: TextInputType.number),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Sizes',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: _addSizeField,
                        ),
                      ],
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: _sizeControllers.length,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            Expanded(
                              child: _buildTextField(_sizeControllers[index], 'Size ${index + 1}'),
                            ),
                            IconButton(
                              icon: const Icon(Icons.remove),
                              onPressed: () => _removeSizeField(index),
                            ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: context.read<AddProductCubit>().selectImage,
                      child: const Text('Select Image'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                        textStyle: TextStyle(fontSize: 18),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _submitForm,
                      child: const Text('Add Product'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                        textStyle: TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, {TextInputType inputType = TextInputType.text, int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        keyboardType: inputType,
        maxLines: maxLines,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter $label';
          }
          if (inputType == TextInputType.number && num.tryParse(value) == null) {
            return 'Please enter a valid number';
          }
          return null;
        },
      ),
    );
  }
}
