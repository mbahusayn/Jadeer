import 'package:flutter/material.dart';
import 'package:hackathon/app/auth/screens/loading_screen.dart';
import 'package:hackathon/app/common_widget.dart/add_button.dart';
import 'package:hackathon/app/common_widget.dart/button.dart';
import 'package:hackathon/app/common_widget.dart/text_field.dart';
import 'package:hackathon/app/common_widget.dart/text_label.dart';
import 'package:hackathon/app/split/model/split.dart';
import 'package:hackathon/app/split/widgets/split_widget.dart';
import 'package:hackathon/constants/constants.dart';
import 'package:hackathon/services/supabase_functions.dart';
import 'package:hackathon/style/colors.dart';

class SplitScreen extends StatefulWidget {
  const SplitScreen({super.key});

  @override
  State<SplitScreen> createState() => _SplitScreenState();
}

class _SplitScreenState extends State<SplitScreen> {
  TextEditingController title = TextEditingController(),
      spiltId = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "تقسيم النفقات",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  shape: const RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(16))),
                  builder: (context) => Padding(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom),
                        child: SizedBox(
                          height: 300,
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Center(
                                  child: Text(
                                    "إنضم إلى تقسيمة موجودة",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                height32,
                                const TextLabel(
                                    text: "الرمز التعريفي للتقسيمة"),
                                TextFieldWidget(hint: "", controller: spiltId),
                                height48,
                                ElevatedButtonWidget(
                                    onPressed: () async {
                                      //----
                                      bool result = await SupabaseFunctions()
                                          .joinToSplit(int.parse(spiltId.text));
                                      if (!mounted) return;
                                      if (!result) {
                                        Navigator.pop(context);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content: Row(
                                          children: [
                                            Icon(
                                              Icons.error_outline,
                                              color: Colors.white,
                                            ),
                                            Text(
                                                " أنت مسجل بالفعل في هذه التقسيمة "),
                                          ],
                                        )));
                                      }
                                      Navigator.pop(context);
                                    },
                                    text: "إنضمام")
                              ],
                            ),
                          ),
                        ),
                      )).then((value) {
                setState(() {});
              });
            },
            child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                    color: ColorsApp.primaryColor, shape: BoxShape.circle),
                child: const Icon(
                  Icons.open_in_browser_outlined,
                  color: Colors.white,
                )),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            clipBehavior: Clip.hardEdge,
            width: getWidth(context),
            height: 150,
            decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(16)),
            child: Image.asset(
              "assets/images/split.png",
              fit: BoxFit.cover,
            ),
          ),
          height8,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const TextLabel(text: "التقسيمات الحالية"),
              AddIconButton(
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(16))),
                      builder: (context) => Padding(
                            padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom),
                            child: SizedBox(
                              height: 400,
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Center(
                                      child: Text(
                                        "إنشاء تقسيم النفقات",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    height32,
                                    const TextLabel(text: "العنوان"),
                                    TextFieldWidget(
                                        hint: "", controller: title),
                                    const TextLabel(text: "الوصف"),
                                    TextFieldWidget(
                                        hint: "",
                                        controller: TextEditingController()),
                                    height48,
                                    ElevatedButtonWidget(
                                        onPressed: () async {
                                          await SupabaseFunctions().addSplit({
                                            "title": title.text,
                                            "total_balance": 0,
                                            "members_ids": [currentUser.id],
                                            "owner_id": currentUser.id
                                          });
                                          if (!mounted) return;
                                          Navigator.pop(context);
                                        },
                                        text: "إضافة")
                                  ],
                                ),
                              ),
                            ),
                          )).then((value) {
                    setState(() {});
                  });
                },
              ),
            ],
          ),
          const Divider(),
          FutureBuilder(
              future: SupabaseFunctions().getAllSplits(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Split> list = snapshot.data!;
                  return ListView.separated(
                    shrinkWrap: true,
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      return SplitWidget(split: list[index]);
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
        ]),
      ),
    );
  }
}
