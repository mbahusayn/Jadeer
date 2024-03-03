import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:hackathon/app/common_widget.dart/add_button.dart';
import 'package:hackathon/app/common_widget.dart/text_label.dart';
import 'package:hackathon/app/profile/model/user.dart';
import 'package:hackathon/app/split/model/split.dart';
import 'package:hackathon/constants/constants.dart';
import 'package:hackathon/services/supabase_functions.dart';
import 'package:hackathon/style/colors.dart';

class MembersScreen extends StatelessWidget {
  const MembersScreen({super.key, required this.split});
  final Split split;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(split.title),
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const TextTitle(text: "الأعضاء"),
                AddIconButton(onPressed: () async {
                  await FlutterClipboard.copy("${split.id}").then((value) {
                    showDialog(
                      context: context,
                      builder: (context) => Dialog(
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.check),
                              TextTitle(
                                  text: " تم نسخ الرمز التعريفي للتقسيمة"),
                            ],
                          ),
                        ),
                      ),
                    );
                  });
                }),
              ],
            ),
            const Divider(),
            FutureBuilder(
                future: SupabaseFunctions().getSplitMembers(split.id),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<User> list = snapshot.data!;
                    return ListView.separated(
                      shrinkWrap: true,
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        return MemberWidget(
                          user: list[index],
                        );
                      },
                      separatorBuilder: (context, index) => const Divider(),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(
                          color: ColorsApp.primaryColor),
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }
}

class MemberWidget extends StatelessWidget {
  const MemberWidget({
    super.key,
    required this.user,
  });
  final User user;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration:
                const BoxDecoration(color: Colors.grey, shape: BoxShape.circle),
            child: const Icon(
              Icons.person,
              color: Colors.white,
            ),
          ),
          width8,
          Text(user.name),
        ],
      ),
    );
  }
}
