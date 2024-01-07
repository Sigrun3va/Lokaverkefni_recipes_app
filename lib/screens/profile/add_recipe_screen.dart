import 'package:flutter/material.dart';
import 'package:recipes_app/database/recipe_database.dart';

class AddRecipeScreen extends StatefulWidget {
  final List<String> categories;

  const AddRecipeScreen({Key? key, required this.categories}) : super(key: key);

  @override
  _AddRecipeScreenState createState() => _AddRecipeScreenState();
}

class _AddRecipeScreenState extends State<AddRecipeScreen> {
  List<String> ingredients = [];
  final ingredientController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final ingredientsController = TextEditingController();
  final instructionsController = TextEditingController();
  String? selectedCategory;

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    ingredientsController.dispose();
    instructionsController.dispose();
    super.dispose();
  }

  void _submitRecipe() async {
    if (_formKey.currentState!.validate()) {

      RecipeModel newRecipe = RecipeModel(
        name: nameController.text,
        description: descriptionController.text,
        ingredients: ingredients,
        instructions: instructionsController.text,
        category: selectedCategory ?? '',
        imagePath: 'assets/images/comingsoon.jpg',
      );

      await writeRecipe(newRecipe);

      Navigator.pop(context);
    }
  }

  InputDecoration _buildInputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.grey),
      fillColor: Colors.black,
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.grey),
      ),
    );
  }

  Widget _buildIngredientInput() {
    return Row(
      children: <Widget>[
        Expanded(
          child: TextFormField(
            controller: ingredientController,
            decoration: _buildInputDecoration('Ingredients'),
            style: const TextStyle(color: Colors.grey),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.add, color: Colors.white),
          onPressed: _addIngredient,
        ),
      ],
    );
  }

  void _addIngredient() {
    if (ingredientController.text.isNotEmpty) {
      setState(() {
        ingredients.add(ingredientController.text);
        ingredientController.clear();
      });
    }
  }

  Widget _buildAddPhotoButton() {
    return InkWell(
      onTap: () {},
      child: Container(
        height: 150,
        decoration: BoxDecoration(
          color: Colors.grey[800],
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Center(
          child: Icon(
            Icons.add_a_photo,
            color: Colors.white,
            size: 50,
          ),
        ),
      ),
    );
  }

  void _addPhoto() {
    // TODO: image_picker??
  }

  Widget _buildIngredientList() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: ingredients.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(ingredients[index],
              style: const TextStyle(color: Colors.white)),
          trailing: IconButton(
            icon: const Icon(Icons.delete, color: Colors.deepOrange),
            onPressed: () => _removeIngredient(index),
          ),
        );
      },
    );
  }

  void _removeIngredient(int index) {
    setState(() {
      ingredients.removeAt(index);
    });
  }

  Widget _buildTextField(TextEditingController controller, String label,
      {int maxLines = 1}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        style: const TextStyle(color: Colors.grey),
        decoration: _buildInputDecoration(label),
        validator: (value) => value!.isEmpty ? 'Please enter $label' : null,
      ),
    );
  }

  Widget _buildCategoryDropdown() {
    return DropdownButtonFormField<String>(
      decoration: _buildInputDecoration('Category'),
      value: selectedCategory,
      onChanged: (String? newValue) {
        setState(() {
          selectedCategory = newValue;
        });
      },
      items: widget.categories.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value, style: const TextStyle(color: Colors.grey)),
        );
      }).toList(),
      validator: (value) => value == null ? 'Please select a category' : null,
    );
  }

  Widget _buildSubmitButton() {
    return ElevatedButton(
      onPressed: () {
        _submitRecipe();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF181818),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      child: const Text('Upload Recipe'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create A New Recipe',
            style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 30.0, 16.0, 16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                _buildAddPhotoButton(),
                const SizedBox(height: 20),
                _buildTextField(nameController, 'Title'),
                _buildTextField(descriptionController, 'Description',
                    maxLines: 7),
                _buildIngredientInput(),
                _buildIngredientList(),
                const SizedBox(height: 20),
                _buildTextField(instructionsController, 'Instructions',
                    maxLines: 15),
                _buildCategoryDropdown(),
                const SizedBox(height: 30),
                _buildSubmitButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}