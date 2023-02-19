import 'package:covid_tracker/Service/stats_services.dart';
import 'package:covid_tracker/Widgets/RowCard.dart';
import 'package:covid_tracker/view/countries_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

import '../Model/WorldStatsModel.dart';
class WorldStatsScreen extends StatefulWidget {
  const WorldStatsScreen({Key? key}) : super(key: key);

  @override
  _WorldStatsScreenState createState() => _WorldStatsScreenState();
}

class _WorldStatsScreenState extends State<WorldStatsScreen> with TickerProviderStateMixin{
  final colorList = [
    const Color(0xff4285F4),
    const Color(0xff1aa260),
    const Color(0xffde5246)
  ];
  late final AnimationController _controller = AnimationController(duration: const Duration(seconds: 3),vsync: this)..repeat();
  @override
  Widget build(BuildContext context) {
    StatsServices statsServices = StatsServices();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                FutureBuilder(
                    future: statsServices.getWorldStats(),
                    builder: (context,AsyncSnapshot<WorldStatsModel> snapshot){
                      if(!snapshot.hasData){
                        return Expanded(
                          flex: 1,
                          child: SpinKitFadingCircle(
                            color: Colors.white,
                            size: 50,
                            controller: _controller,
                          ),
                        );
                      }else{
                        return Column(
                         children: [
                           PieChart(dataMap:  {
                             "Total" : double.parse(snapshot.data!.cases.toString()),
                             "Recovered" : double.parse(snapshot.data!.recovered.toString()),
                             "Death" : double.parse(snapshot.data!.deaths.toString())
                           },
                               chartValuesOptions: const ChartValuesOptions(
                                 showChartValuesInPercentage: true
                               ),
                               animationDuration: const Duration(milliseconds: 1200),
                               chartType: ChartType.ring,
                               colorList: colorList,
                               legendOptions: const LegendOptions(
                                   legendPosition: LegendPosition.left
                               )
                           ),
                           Padding(
                             padding:  EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * .06),
                             child: Card(
                               child: Column(
                                 children: [
                                   RowCard(title: "Total", value: snapshot.data!.cases.toString()),
                                   RowCard(title: "Recovered", value: snapshot.data!.recovered.toString()),
                                   RowCard(title: "Deaths", value: snapshot.data!.deaths.toString()),
                                   RowCard(title: "Active", value: snapshot.data!.active.toString()),
                                   RowCard(title: "Critical", value: snapshot.data!.critical.toString()),
                                   RowCard(title: "Today Cases", value: snapshot.data!.todayCases.toString()),
                                   RowCard(title: "Today Deaths", value: snapshot.data!.todayDeaths.toString()),
                                   RowCard(title: "Today Recovered", value: snapshot.data!.todayRecovered.toString()),

                                 ],
                               ),
                             ),
                           ),
                           GestureDetector(
                             onTap:(){
                               Navigator.push(context, MaterialPageRoute(builder: (context)=>const CountriesRecordsScreen()));
                             },
                             child: Container(
                               height: 50,
                               decoration: BoxDecoration(
                                   color: const Color(0xff1aa260),
                                   borderRadius: BorderRadius.circular(15)
                               ),
                               child: const Center(child: Text("Track Countries"),),
                             ),
                           ),
                         ],
                        );
                      }
                    }),

              ],
            ),

          ),
        ),
      ),
    );
  }
}
