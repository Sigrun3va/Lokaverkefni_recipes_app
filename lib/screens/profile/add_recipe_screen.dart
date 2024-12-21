import 'package:flutter/material.dart';
import 'package:recipes_app/model/recipe_model.dart';
import 'package:recipes_app/services/recipe_service.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AddRecipeScreen extends StatefulWidget {
  final List<String> categories;
  final RecipeModel? recipe;

  const AddRecipeScreen({
    Key? key,
    required this.categories,
    this.recipe,
  }) : super(key: key);

  @override
  _AddRecipeScreenState createState() => _AddRecipeScreenState();
}

class _AddRecipeScreenState extends State<AddRecipeScreen> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final instructionsController = TextEditingController();
  final ingredientController = TextEditingController();
  List<String> ingredients = [];
  List<String> selectedCategories = [];
  String? imagePath;

  @override
  void initState() {
    super.initState();
    if (widget.recipe != null) {
      _initializeForEdit();
    }
  }

  void _initializeForEdit() {
    final recipe = widget.recipe!;
    nameController.text = recipe.name;
    descriptionController.text = recipe.description;
    ingredients = recipe.ingredients;
    instructionsController.text = recipe.instructions;
    selectedCategories = recipe.category;
    imagePath = recipe.imagePath;
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    ingredientController.dispose();
    instructionsController.dispose();
    super.dispose();
  }

  Future<void> _submitRecipe() async {
    if (_formKey.currentState!.validate() && ingredients.isNotEmpty) {
      try {
        final recipeService = RecipeService();

        RecipeModel newRecipe = RecipeModel(
          id: widget.recipe?.id ?? DateTime.now().millisecondsSinceEpoch,
          name: nameController.text,
          description: descriptionController.text,
          ingredients: ingredients,
          instructions: instructionsController.text,
          category: selectedCategories,
          imagePath: imagePath ?? 'assets/images/comingsoon.jpg',
          isUserAdded: true,
        );

        if (widget.recipe != null) {
          await recipeService.updateRecipe(newRecipe);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Recipe updated successfully!')),
          );
        } else {
          await recipeService.writeRecipe(newRecipe);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Recipe added successfully!')),
          );
        }

        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error submitting recipe: $e')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields and add at least one ingredient')),
      );
    }
  }

  void _addIngredient() {
    if (ingredientController.text.isNotEmpty) {
      final ingredient = ingredientController.text.trim();
      if (!ingredients.contains(ingredient)) {
        setState(() {
          ingredients.add(ingredient);
          ingredientController.clear();
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Ingredient already added')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter an ingredient')),
      );
    }
  }

  Widget _buildIngredientList() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: ingredients.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            ingredients[index],
            style: const TextStyle(color: Colors.white),
          ),
          trailing: IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () {
              setState(() {
                ingredients.removeAt(index);
              });
            },
          ),
        );
      },
    );
  }

  Future<void> _addPhoto() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        setState(() {
          imagePath = image.path;
        });
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  Widget _buildAddPhotoButton() {
    return InkWell(
      onTap: _addPhoto,
      child: Container(
        height: 150,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey[800],
          borderRadius: BorderRadius.circular(10),
        ),
        child: imagePath == null
            ? const Center(
                child: Icon(Icons.add_a_photo, color: Colors.white, size: 50),
              )
            : ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.file(File(imagePath!), fit: BoxFit.cover),
              ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Recipe', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildAddPhotoButton(),
              const SizedBox(height: 20),
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Title',
                  fillColor: Colors.black,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                style: const TextStyle(color: Colors.grey),
                validator: (value) => value == null || value.isEmpty ? 'Please enter a title' : null,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: descriptionController,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: 'Description',
                  fillColor: Colors.black,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                style: const TextStyle(color: Colors.grey),
                validator: (value) => value == null || value.isEmpty ? 'Please enter a description' : null,
              ),
              const SizedBox(height: 20),
              _buildIngredientInput(),
              const SizedBox(height: 10),
              _buildIngredientList(),
              const SizedBox(height: 20),
              TextFormField(
                controller: instructionsController,
                maxLines: 6,
                decoration: InputDecoration(
                  labelText: 'Instructions',
                  fillColor: Colors.black,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                style: const TextStyle(color: Colors.grey),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Please enter instructions' : null,
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Category',
                  fillColor: Colors.black,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                value: selectedCategories.isNotEmpty ? selectedCategories.first : null,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedCategories = [newValue ?? ''];
                  });
                },
                items: widget.categories
                    .map((category) => DropdownMenuItem<String>(
                          value: category,
                          child: Text(category),
                        ))
                    .toList(),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitRecipe,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text('Upload Recipe'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIngredientInput() {
    return Row(
      children: <Widget>[
        Expanded(
          child: TextFormField(
            controller: ingredientController,
            decoration: InputDecoration(
              labelText: 'Ingredient',
              fillColor: Colors.black,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
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
}
