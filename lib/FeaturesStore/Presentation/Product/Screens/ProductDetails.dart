import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food/Core/Helper.dart';
import 'package:food/Core/Services/LoaclServices.dart';
import 'package:food/FeaturesStore/Data/ProductCofee/product_coffee_cubit.dart';
import 'package:food/FeaturesStore/Model/ProductModelCoffee.dart';
import 'package:food/FeaturesStore/Presentation/Product/Widget/DetailsProduct.dart';
import 'package:food/FeaturesStore/Presentation/Product/Widget/Ingredients.dart';
import 'package:food/FeaturesStore/Presentation/Product/Widget/comment.dart';
import 'package:food/FeaturesStore/Presentation/Product/Widget/comment1.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductDetails extends StatelessWidget {
  ProductDetails({super.key, required this.productModel});

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    final cubit = ProductCoffeeCubit.get(context);
    cubit.getComment(productModel.id);
    cubit.getCommentReciver(productModel.id, cubit.userModel!.id);

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(),
        body: BlocConsumer<ProductCoffeeCubit, ProductCoffeeState>(
          listener: (context, state) {},
          builder: (context, state) {
            return ListView(
              children: [
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * .3,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(100),
                          bottomLeft: Radius.circular(100),
                        ),
                        image: DecorationImage(
                          image: NetworkImage(productModel.imageUrl),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 10,
                      child: CircleAvatar(
                        backgroundColor: Colors.grey,
                        child: IconButton(
                          onPressed: () {
                            cubit.addAndRemoveFavorite(
                              idUser: CacheHelper.getData(key: "idUser"),
                              id: productModel.id,
                              imageUrl: productModel.imageUrl,
                              name: productModel.name,
                              flavorNotes: productModel.flavorNotes,
                              price: productModel.price,
                              review: productModel.review,
                              description: productModel.description,
                              caffeineContent: productModel.caffeineContent,
                              contains: productModel.contains,
                              ingredients: productModel.ingredients,
                              sizes: productModel.sizes,
                              origin: productModel.origin,
                            );
                          },
                          icon: Icon(
                            Icons.favorite,
                            color: cubit.idFavoriteProduct
                                    .contains(productModel.id)
                                ? Colors.red
                                : Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      productModel.name,
                      style: GoogleFonts.aladin(fontSize: 20),
                    ),
                    Text(
                      "\$${productModel.price}",
                      style: GoogleFonts.aladin(fontSize: 20),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Divider(),
                const SizedBox(height: 10),
                const TabBar(
                  tabs: [
                    Tab(text: 'Details'),
                    Tab(text: 'Ingredients'),
                    Tab(text: 'Reviews'),
                  ],
                  indicatorColor: Colors.white,
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.grey,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .38,
                  child: TabBarView(
                    children: [
                      DetailsProduct(
                        productModel: productModel,
                        color: cubit.idSets.contains(productModel.id)
                            ? Colors.brown
                            : Colors.blueGrey,
                        onPress: () {
                          cubit.addAndRemoveCart(
                            iduser: CacheHelper.getData(key: "idUser"),
                            id: productModel.id,
                            imageUrl: productModel.imageUrl,
                            name: productModel.name,
                            flavorNotes: productModel.flavorNotes,
                            price: productModel.price,
                            review: productModel.review,
                            description: productModel.description,
                            iddoc: productModel.id,
                            caffeineContent: productModel.id,
                            contains: productModel.contains,
                            ingredients: productModel.ingredients,
                            sizes: productModel.sizes,
                            origin: productModel.origin,
                          );
                        },
                      ),
                      Ingredients(
                        productModel: productModel,
                      ),
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: TextField(
                                controller: cubit.controller,
                                decoration: InputDecoration(
                                  hintText: 'Send Message',
                                  suffixIcon: IconButton(
                                    icon: const Icon(Icons.send),
                                    onPressed: () async {
                                      cubit.addComment(
                                        senderId:
                                            CacheHelper.getData(key: "idUser"),
                                        image: cubit.userModel?.url ??
                                            "https://th.bing.com/th?id=OIP.a_C9v1H7RBbVyFjU4udThgHaKX&w=211&h=295&c=8&rs=1&qlt=90&o=6&dpr=1.3&pid=3.1&rm=2",
                                        id: productModel.id,
                                        name: cubit.userModel?.name ?? "",
                                        age: "27",
                                        content: cubit.controller.text,
                                      );
                                      cubit.controller.clear();
                                    },
                                    color: Colors.blue,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide:
                                        const BorderSide(color: Colors.blue),
                                  ),
                                ),
                              ),
                            ),
                            if (cubit.commentsList.isEmpty)
                              const Center(child: Text('No comments yet'))
                            else
                              ListView.builder(
                                itemCount: cubit.commentsList.length,
                                shrinkWrap: true,
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return Comment(
                                    onPress: () {
                                      showBottomSheet(
                                        context: context,
                                        builder: (context) {
                                          return Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                .8,
                                            decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(30),
                                                  topLeft: Radius.circular(30)),
                                              color: Colors.black26,
                                            ),
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(16),
                                                  child: TextField(
                                                    controller:
                                                        cubit.controller1,
                                                    decoration: InputDecoration(
                                                      hintText: 'Send Message',
                                                      suffixIcon: IconButton(
                                                        icon: const Icon(
                                                            Icons.send),
                                                        onPressed: () {
                                                          cubit
                                                              .addCommentReciver(
                                                            reciverId: cubit
                                                                .userModel!.id,
                                                            senderId: cubit
                                                                .userModel!.id,
                                                            image: cubit
                                                                    .userModel
                                                                    ?.url ??
                                                                "",
                                                            id: productModel.id,
                                                            name: cubit
                                                                    .userModel
                                                                    ?.name ??
                                                                "",
                                                            age: "27",
                                                            content: cubit
                                                                .controller1
                                                                .text,
                                                          );
                                                          cubit.controller1
                                                              .clear();
                                                        },
                                                        color: Colors.blue,
                                                      ),
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30),
                                                      ),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30),
                                                        borderSide:
                                                            const BorderSide(
                                                                color: Colors
                                                                    .blue),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                cubit.commentsListReciver
                                                        .isEmpty
                                                    ? Text("No data Result")
                                                    : ListView.builder(
                                                        itemCount: cubit
                                                            .commentsListReciver
                                                            .length,
                                                        shrinkWrap: true,
                                                        itemBuilder:
                                                            (context, index) {
                                                          return comment1(
                                                            onPress: () {},
                                                            messageModel: cubit
                                                                    .commentsListReciver[
                                                                index],
                                                          );
                                                        },
                                                      ),
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    text: cubit.commentsList[index].name,
                                    date: cubit.commentsList[index].imageUrl,
                                    message: cubit.commentsList[index].content,
                                    date1: cubit.commentsList[index].date,
                                  );
                                },
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
