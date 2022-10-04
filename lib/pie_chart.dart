import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PieChart extends StatefulWidget {
  const PieChart({Key? key}) : super(key: key);

  @override
  State<PieChart> createState() => _PieChartState();
}

class _PieChartState extends State<PieChart> {
  final List<ChartData> chartData = [
    ChartData('David', 25),
    ChartData('Steve', 38),
    ChartData('Jack', 34),
    ChartData('Others', 52)
  ];

  late TooltipBehavior tooltipBehavior;
  int? selectedIndex;

  @override
  void initState() {
    tooltipBehavior =
        TooltipBehavior(enable: true, format: 'point.x : point.y%');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
            child: Padding(
          padding: const EdgeInsets.only(top: 58.0),
          child: Column(
            children: [
              SfCircularChart(
                  legend: Legend(
                      isVisible: true,
                      overflowMode: LegendItemOverflowMode.wrap),
                  tooltipBehavior: tooltipBehavior,
                  series: <CircularSeries>[
                    DoughnutSeries<ChartData, String>(
                        dataSource: chartData,
                        xValueMapper: (ChartData data, _) => data.x,
                        yValueMapper: (ChartData data, _) => data.y,
                        dataLabelSettings:
                            const DataLabelSettings(isVisible: true),
                        innerRadius: '65%',
                        explode: true,
                        strokeColor: Colors.yellow,
                        selectionBehavior: SelectionBehavior(
                            selectedBorderColor: Colors.purple),
                        onPointTap: (pointInteractionDetails) {
                          print(
                              chartData[pointInteractionDetails.pointIndex!].x);

                          setState(() {
                            selectedIndex = pointInteractionDetails.pointIndex;
                          });
                        },
                        explodeOffset: "10",
                        enableTooltip: true,
                        radius: '100',
                        cornerStyle: CornerStyle.bothFlat)
                  ]),
              if (selectedIndex != null) Text(chartData[selectedIndex!].x),
            ],
          ),
        )),
      ),
    );
  }
}

class ChartData {
  ChartData(
    this.x,
    this.y, [
    this.color,
    this.onTap,
  ]);
  final String x;
  final double y;
  final Color? color;
  GestureTapCallback? onTap;
}
