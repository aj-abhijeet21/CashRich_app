import 'package:cashrich_app/models/sip_model.dart';
import 'package:cashrich_app/services/percent_provider.dart';
import 'package:cashrich_app/services/sip_service.dart';
import 'package:cashrich_app/widgets/circular_percent_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late Animation<Color?> animation;
  late AnimationController controller;

  late final _future;
  // String percentage = '';
  String description = '';
  @override
  void initState() {
    final provider = Provider.of<PercentProvider>(context, listen: false);

    super.initState();
    _future = getData();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    animation = ColorTween(
      begin: const Color(0xFF558acf),
      end: const Color(0xFFffd83a),
    ).animate(controller)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        backgroundColor: animation.value,
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Dynamic SIP',
                style: TextStyle(
                  fontSize: 35,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                'Earn more than normal SIP',
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: height * 0.1,
              ),
              CircularPercentWidget(),
              SizedBox(
                height: height * 0.15,
              ),
              FutureBuilder<List<SipModel>>(
                future: _future,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasData) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        buildYearButtons(snapshot.data!),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    );
                  } else {
                    return Center(
                      child: Text(
                        snapshot.error.toString(),
                      ),
                    );
                  }
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        description,
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildYearButtons(List<SipModel> sipList) {
    List<Widget> children = [];
    final provider = Provider.of<PercentProvider>(context, listen: false);

    sipList.forEach(
      (element) => children.add(
        TextButton(
          onPressed: () {
            provider.setEquity(int.parse(element.equity!));
            if (provider.fixedValue < 50) {
              controller.reverse();
            } else {
              controller.forward();
            }
            setState(() {
              description = element.description ?? 'No Description Found';
            });
          },
          child: Text(element.date!),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.white),
            foregroundColor: MaterialStateProperty.all(Colors.black),
            padding: MaterialStateProperty.all(
              const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
            ),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ),
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: children,
    );
  }
}
