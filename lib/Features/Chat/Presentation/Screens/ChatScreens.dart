import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food/Core/Services/LoaclServices.dart';
import 'package:food/Features/Chat/Data/chat_model_cubit.dart';
import 'package:food/Features/Register/Model/UserModel.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:audioplayers/audioplayers.dart'; // Import audioplayers

class ChatScreens extends StatelessWidget {
  ChatScreens({super.key, required this.userModel});

  final UserModel userModel;
  final TextEditingController controller = TextEditingController();
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    ChatModelCubit.get(context).getMessageAll(userModel.id.toString());

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Message"),
        actions: [
          Text(userModel.name),
SizedBox(width: 25,),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: CircleAvatar(
              backgroundImage: NetworkImage(userModel.url),
            ),
          ),
        ],
      ),
      body: BlocConsumer<ChatModelCubit, ChatModelState>(
        listener: (context, state) {
          if (state is SuccessUpload) {
            controller.clear();
          }
          if (state is SuccessGetMessage) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (scrollController.hasClients) {
                scrollController.jumpTo(scrollController.position.maxScrollExtent);
              }
            });
          }
        },
        builder: (context, state) {
          var cubitChat = ChatModelCubit.get(context);

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: cubitChat.getmessage.length,
                  itemBuilder: (context, index) {
                    var message = cubitChat.getmessage[index];
                    bool isMe = message.senderId == CacheHelper.getData(key: "idUser");
                    return isMe
                        ? ChatBuble(message: message.content, time: message.time)
                        : ChatBubleForFriend(message: message.content, time: message.time);
                  },
                ),
              ),
              sendMessage(() {
                ChatModelCubit.get(context).sendMessage(
                  message: controller.text,
                  senderId: userModel.id.toString(),
                );
                controller.clear();
              }, controller),
            ],
          );
        },
      ),
    );
  }

  Widget sendMessage(void Function()? onTap, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: "SendMessage..",
          suffixIcon: GestureDetector(onTap: onTap, child: const Icon(Icons.send)),
          labelStyle: GoogleFonts.aladin(),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.indigo),
            borderRadius: BorderRadius.circular(20),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.indigo),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}

class ChatBuble extends StatelessWidget {
  const ChatBuble({Key? key, required this.message, required this.time}) : super(key: key);

  final String message;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
            bottomLeft: Radius.circular(32),
          ),
          color: Colors.black26,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              message,
              style: GoogleFonts.aladin(
                color: Colors.white,
                fontSize: 18

              )
            ),
            const SizedBox(height: 5),
            Text(
              time,
              style: TextStyle(
                color: Colors.white.withOpacity(0.4),
                fontSize: 12,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatBubleForFriend extends StatelessWidget {
  const ChatBubleForFriend({Key? key, required this.message, required this.time}) : super(key: key);

  final String message;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
            bottomRight: Radius.circular(32),
          ),
          color: Colors.teal,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message,
              style:  GoogleFonts.aladin(
                  color: Colors.white,
                  fontSize: 18

              ),
            ),
            const SizedBox(height: 5),
            Text(
              time,
              style: TextStyle(
                color: Colors.white70,
                fontSize: 12,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
