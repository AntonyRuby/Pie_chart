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
    tooltipBehavior = TooltipBehavior(
      enable: true,
      format: 'point.x : point.y%',
      animationDuration: 200,
      canShowMarker: true,
      shouldAlwaysShow: true,
      tooltipPosition: TooltipPosition.pointer,
      borderWidth: 10,
    );
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
                    overflowMode: LegendItemOverflowMode.wrap,
                  ),
                  tooltipBehavior: tooltipBehavior,
                  series: <CircularSeries>[
                    DoughnutSeries<ChartData, String>(
                        dataSource: chartData,
                        animationDuration: 200,
                        explodeIndex: selectedIndex,
                        animationDelay: 200,
                        xValueMapper: (ChartData data, _) => data.x,
                        yValueMapper: (ChartData data, _) => data.y,
                        dataLabelSettings:
                            const DataLabelSettings(isVisible: true),
                        innerRadius: '60%',
                        explode: true,
                        strokeWidth: 3,
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
                        emptyPointSettings: EmptyPointSettings(
                            mode: EmptyPointMode.drop,
                            color: Colors.red,
                            borderColor: Colors.black,
                            borderWidth: 9),
                        explodeOffset: "10",
                        radius: '100',
                        pointRadiusMapper: (datum, index) {
                          10;
                        },

                        // pointRenderMode: PointRenderMode.gradient,
                        // animationDuration: 20,
                        // animationDelay: 10000,
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
