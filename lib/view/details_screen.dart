import 'package:covid_tracker/Widgets/RowCard.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatefulWidget {
  Map<String, dynamic> data;
  DetailsScreen({Key? key, required this.data}) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.data['country']),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.067),
                child: Card(
                  child: Column(
                    children: [
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.06),
                      RowCard(
                          title: "Total Cases",
                          value: widget.data['cases'].toString()),
                      RowCard(
                          title: "Total Recovered",
                          value: widget.data['recovered'].toString()),
                      RowCard(
                          title: "Total Deaths",
                          value: widget.data['deaths'].toString()),
                      RowCard(
                          title: "Total Critical",
                          value: widget.data['critical'].toString()),
                      RowCard(
                          title: "Today Cases",
                          value: widget.data['todayCases'].toString()),
                      RowCard(
                          title: "Today Recovered",
                          value: widget.data['todayRecovered'].toString()),
                      RowCard(
                          title: "Today Deaths",
                          value: widget.data['todayDeaths'].toString()),
                      RowCard(
                          title: "Population",
                          value: widget.data['population'].toString()),
                    ],
                  ),
                ),
              ),
              CircleAvatar(
                radius: 50,
                backgroundImage:
                    NetworkImage(widget.data['countryInfo']['flag']),
              )
            ],
          )
        ],
      ),
    );
  }
}
