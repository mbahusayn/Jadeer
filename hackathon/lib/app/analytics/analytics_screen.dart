import 'package:d_chart/d_chart.dart';
import 'package:flutter/material.dart';
import 'package:hackathon/app/common_widget.dart/text_label.dart';
import 'package:hackathon/constants/constants.dart';
import 'package:hackathon/constants/data.dart';
import 'package:hackathon/style/colors.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  String dropdownValue = duration.first;

  final _tabs = [
    const Tab(icon: Icon(Icons.pie_chart_rounded)),
    const Tab(icon: Icon(Icons.bar_chart_rounded)),
    const Tab(icon: Icon(Icons.show_chart_rounded)),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "التقرير المالي",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //---------- duraction
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          color: ColorsApp.greyColor,
                          borderRadius: BorderRadius.circular(16)),
                      child: DropdownButton<String>(
                        value: dropdownValue,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        elevation: 8,
                        style: const TextStyle(
                            color: Colors.black, fontFamily: "IBMPlexSans"),
                        onChanged: (String? value) {
                          setState(() {
                            dropdownValue = value!;
                          });
                        },
                        items: duration
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                    //---------- tab bar
                    Container(
                      height: 45,
                      width: getWidth(context) * 0.6,
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: TabBar(
                        indicatorPadding:
                            const EdgeInsets.symmetric(horizontal: 0),
                        indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: ColorsApp.secondaryColor,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.shade300,
                                  blurRadius: 2,
                                  spreadRadius: 0.5)
                            ]),
                        labelColor: Colors.white,
                        unselectedLabelColor: Colors.black,
                        tabs: _tabs,
                      ),
                    ),
                  ],
                ),
                height16,
                //---------- charts
                const TextLabel(text: "الفئات"),
                height16,
                SizedBox(
                  width: getWidth(context),
                  height: 300,
                  child: Container(
                    width: getWidth(context),
                    height: getHeight(context) * 0.3,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(16)),
                    child: TabBarView(
                      //----------- Pie Chart
                      children: [
                        AspectRatio(
                          aspectRatio: 16 / 9,
                          child: DChartPieO(
                              animate: true,
                              data: ordinalDataList,
                              customLabel: (ordinalData, index) {
                                return ordinalData.domain;
                              },
                              configRenderPie: ConfigRenderPie(
                                arcLabelDecorator: ArcLabelDecorator(
                                  labelPosition: ArcLabelPosition.inside,
                                  insideLabelStyle: LabelStyle(
                                    color: Colors.grey.shade700,
                                    fontSize: 16,
                                  ),
                                  labelPadding: 10,
                                  leaderLineStyle:
                                      const ArcLabelLeaderLineStyle(
                                    color: Colors.blue,
                                    length: 30,
                                    thickness: 2,
                                  ),
                                  showLeaderLines: true,
                                ),
                              )),
                        ),
                        //----------- Bar Chart
                        AspectRatio(
                          aspectRatio: 16 / 9,
                          child: DChartBarT(
                            animate: true,
                            groupList: timeGroup,
                          ),
                        ),
                        //----------- Line Chart
                        AspectRatio(
                          aspectRatio: 16 / 9,
                          child: DChartLineT(
                            animate: true,
                            groupList: timeGroupList,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                height16,
                //-------------- total
                const TextLabel(text: "الإنفاق الشهري"),
                const Divider(),
                height16,
                const Row(
                  children: [
                    Icon(Icons.calendar_month_rounded),
                    width8,
                    TextLabel(text: "هذا الشهر"),
                    Spacer(),
                    TextLabel(text: "5730 ريال")
                  ],
                ),
                height8,
                LinearProgressIndicator(
                  backgroundColor: ColorsApp.greyColor,
                  color: ColorsApp.primaryColor,
                  value: 0.7,
                  minHeight: 12,
                  borderRadius: BorderRadius.circular(16),
                ),
                height16,
                const Divider(),
                height8,
                const Row(
                  children: [
                    Icon(Icons.calendar_month_rounded),
                    width8,
                    TextLabel(text: "Jan 2024"),
                    Spacer(),
                    TextLabel(text: "3500 ريال")
                  ],
                ),
                height8,
                LinearProgressIndicator(
                  backgroundColor: ColorsApp.greyColor,
                  color: ColorsApp.primaryColor,
                  value: 0.4,
                  minHeight: 12,
                  borderRadius: BorderRadius.circular(16),
                ),

                height16,
                const Divider(),
                height8,
                const Row(
                  children: [
                    Icon(Icons.calendar_month_rounded),
                    width8,
                    TextLabel(text: "Des 2023"),
                    Spacer(),
                    TextLabel(text: "9300 ريال")
                  ],
                ),
                height8,
                LinearProgressIndicator(
                  backgroundColor: ColorsApp.greyColor,
                  color: ColorsApp.primaryColor,
                  value: 0.9,
                  minHeight: 12,
                  borderRadius: BorderRadius.circular(16),
                ),
                height24
              ],
            ),
          ),
        ),
      ),
    );
  }
}

List<OrdinalData> ordinalDataList = [
  OrdinalData(domain: 'تسوق', measure: 3, color: ColorsApp.secondaryColor),
  OrdinalData(domain: 'مطعم', measure: 5, color: ColorsApp.primaryColor),
  OrdinalData(domain: 'مقهى', measure: 9, color: Colors.orange[300]),
  OrdinalData(domain: 'فاتورة', measure: 6.5, color: Colors.red[300]),
];

List<TimeData> timeList = [
  TimeData(domain: DateTime(2024, 2, 26), measure: 3),
  TimeData(domain: DateTime(2024, 2, 27), measure: 5),
  TimeData(domain: DateTime(2024, 2, 28), measure: 9),
  TimeData(domain: DateTime(2024, 2, 29), measure: 6.5),
];

final timeGroup = [
  TimeGroup(id: '1', data: timeList, color: Colors.orange[300]),
];

List<TimeData> timeDataList = [
  TimeData(domain: DateTime(2023, 8, 26), measure: 3),
  TimeData(domain: DateTime(2023, 8, 27), measure: 5),
  TimeData(domain: DateTime(2023, 8, 29), measure: 9),
  TimeData(domain: DateTime(2023, 9, 1), measure: 6.5),
];

final timeGroupList = [
  TimeGroup(id: '1', data: timeDataList, color: Colors.red[300]),
];
