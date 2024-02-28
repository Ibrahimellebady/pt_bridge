import 'package:elag/Models/user_model.dart';
import 'package:elag/controller/cubit/layout_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Therapist_Home/show_patient_profile_screen.dart';

// class PatientChatScreen extends StatelessWidget {
//   final UserModel userModel;
//   final messageController = TextEditingController();
//
//   PatientChatScreen({
//     Key? key,
//     required this.userModel,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final cubit = BlocProvider.of<LayoutCubit>(context)
//       ..getMessages(receiverID: userModel.id!);
//
//     return Scaffold(
//       appBar: AppBar(
//           title: Text(userModel.name!),
//           leading:
//               CircleAvatar(backgroundImage: NetworkImage(userModel.image!)),
//           elevation: 0,
//           automaticallyImplyLeading: false),
//       body: BlocConsumer<LayoutCubit, LayoutState>(
//         listener: (context, state) {
//           if (state is SuccessPatientSendMessageState) {
//             messageController.clear();
//           }
//         },
//         builder: (context, state) {
//           return Container(
//             padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
//             decoration: const BoxDecoration(
//                 image: DecorationImage(
//                     image: AssetImage("assets/images/whatsapp_Back.png"),
//                     fit: BoxFit.cover)),
//             child: Column(
//               children: [
//                 Expanded(
//                   child: state is GetMessagesLoadingState
//                       ? const Center(child: CircularProgressIndicator())
//                       : cubit.messages.isNotEmpty
//                           ? ListView.builder(
//                               itemCount: cubit.messages.length,
//                               itemBuilder: (context, index) {
//                                 return GestureDetector(
//                                   onTap: () {
//                                     if (index >= 0 &&
//                                         index < cubit.messages.length) {
//                                       cubit.messages.removeAt(0);
//                                       print('masseges is deleated ');
//
//                                       // Emit a new state with the updated list
//                                     }
//                                   },
//                                   child: Container(
//                                       color: Colors.blueGrey,
//                                       margin: const EdgeInsets.only(bottom: 15),
//                                       padding: const EdgeInsets.symmetric(
//                                           vertical: 10, horizontal: 12),
//                                       child: Text(cubit.messages[index].title!,
//                                           style: const TextStyle(
//                                               color: Colors.white,
//                                               fontSize: 18))),
//                                 );
//                               })
//                           : const Center(
//                               child: Text("No Messages yet......"),
//                             ),
//                 ),
//                 const SizedBox(height: 12),
//                 TextField(
//                   controller: messageController,
//                   decoration: InputDecoration(
//                     suffixIcon: GestureDetector(
//                         child: const Icon(Icons.send),
//                         onTap: () {
//                           cubit.sendMessage(
//                               message: messageController.text,
//                               receiverID: userModel.id!);
//                         }),
//                     border: const OutlineInputBorder(),
//                   ),
//                 )
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

class PatientChatScreen extends StatefulWidget {
  final UserModel userModel;

  const PatientChatScreen({super.key, required this.userModel});

  @override
  State<PatientChatScreen> createState() => _PatientChatScreen();
}

class _PatientChatScreen extends State<PatientChatScreen> {
  final messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<LayoutCubit>(context)
      ..getPatient()
      ..getUsers()
      ..getUsersData()
      ..getMessages(receiverID: widget.userModel.id!);
    return Scaffold(
      body: BlocConsumer<LayoutCubit, LayoutState>(
        listener: (context, state) {
          if (state is SuccessPatientSendMessageState) {
            messageController.clear();
          }
        },
        builder: (context, state) {
          return Container(
            child: Stack(
              children: [
                Expanded(
                    child: Container(
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, top: 160, bottom: 16),
                  child: Stack(
                    children: [
                      ListView.builder(
                          itemCount: cubit.messages.length,
                          itemBuilder: (context, index) {
                            final message = cubit.messages[index];
                            final isSentByCurrentUser =
                                message.senderID == widget.userModel.id;
                            return Align(
                              alignment: isSentByCurrentUser
                                  ? Alignment.centerLeft
                                  : Alignment.centerRight,
                              child: Container(
                                margin: const EdgeInsets.only(top: 8),
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: isSentByCurrentUser
                                      ? Color(0xffbaa6ec)
                                      : Color(0xff54078c).withOpacity(0.9),
                                  borderRadius: isSentByCurrentUser
                                      ? const BorderRadius.only(
                                          topLeft: Radius.circular(15),
                                          topRight: Radius.circular(15),
                                          bottomRight: Radius.circular(15))
                                      : const BorderRadius.only(
                                          topLeft: Radius.circular(15),
                                          bottomLeft: Radius.circular(15),
                                          topRight: Radius.circular(15),
                                        ),
                                ),
                                child: Text(
                                  message.title!,
                                  style: TextStyle(
                                    color: isSentByCurrentUser
                                        ? Colors.black.withOpacity(0.8)
                                        : Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            );
                          }),
                    ],
                  ),
                )),
                Positioned(
                  left: 15,
                  bottom: 16,
                  child: Container(
                    width: MediaQuery.of(context).size.width - 30,
                    height: 42,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.black45),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: ClipRRect(
                      // Clip the TextField with rounded corners
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      child: Container(
                        child: TextField(
                          controller: messageController,
                          decoration: InputDecoration(
                            suffixIcon: GestureDetector(
                              child: const Icon(Icons.send,
                                  color: Color(0xff54078c)),
                              onTap: () {
                                cubit.sendMessage(
                                  message: messageController.text,
                                  receiverID: widget.userModel.id!,
                                );
                                setState(() {
                                  messageController.clear();
                                });
                              },
                            ),
                            border: InputBorder.none, // Remove default border
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10), // Optional: Adjust padding
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 170,
                  decoration: BoxDecoration(
                      color: Color(0xff54078c),
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(30),
                        bottomLeft: Radius.circular(30),
                      )),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 24),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: IconButton(
                                icon: const Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                            Visibility(
                              visible:
                                  widget.userModel.chooseStatus == 'Patient',
                              child: Container(
                                margin: EdgeInsets.only(top: 4),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(16)),
                                child: IconButton(
                                  icon: const Icon(Icons.person),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return ShowPatientProfileScreen(
                                              user: widget.userModel);
                                        },
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 4),
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                color: Colors.white, // Set a background color
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                              ),
                              child: ClipRRect(
                                // Clip the image with the rounded corners
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8),
                                ),
                                child: Image.network(
                                  widget.userModel.image!,
                                  fit: BoxFit
                                      .cover, // Use BoxFit.cover or BoxFit.contain
                                ),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Text(
                                    '${widget.userModel.name}',
                                    style: TextStyle(
                                        fontSize: 24,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${widget.userModel.patientAge ?? ''}',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400,
                                          fontStyle: FontStyle.italic),
                                    ),
                                    Text(
                                      '${widget.userModel.sex ?? ''}',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400,
                                          fontStyle: FontStyle.italic),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
