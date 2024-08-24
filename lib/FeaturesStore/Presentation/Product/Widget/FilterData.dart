import 'package:flutter/material.dart';
import 'package:food/FeaturesStore/Model/ProductModelCoffee.dart';
import 'package:food/FeaturesStore/Presentation/Product/Screens/ProductDetails.dart';

class ProductSearchDelegate extends SearchDelegate {
  final List<ProductModel> allProducts;
  List<String> recentSearches = []; // List to store recent searches

  ProductSearchDelegate(this.allProducts);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = allProducts.where((product) => product.name.toLowerCase().contains(query.toLowerCase())).toList();

    if (!recentSearches.contains(query)) {
      recentSearches.add(query); // Add search query to recent searches
    }

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        return ListTile(
          title:Container(
            height: 60,
            decoration: BoxDecoration(
              color: Colors.black26,
              borderRadius: BorderRadius.circular(20)
            ),
            child: Row(
              children: [
                 CircleAvatar(radius: 40,backgroundImage: NetworkImage(results[index].imageUrl),),
                const SizedBox(width: 50,),
                Text(results[index].name),
              ],
            ),
          ) ,

          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetails(productModel: results[index]),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = query.isEmpty
        ? recentSearches // Show recent searches when query is empty
        : allProducts.where((product) => product.name.toLowerCase().contains(query.toLowerCase())).map((product) => product.name).toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(suggestions[index]),
          onTap: () {
            query = suggestions[index];
            showResults(context);
          },
        );
      },
    );
  }
}
