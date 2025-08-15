import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'components/card.dart';
import 'components/my_data.dart';

class Showcase extends StatefulWidget {
  const Showcase({super.key});

  @override
  State<Showcase> createState() => _ShowcaseState();
}

class _ShowcaseState extends State<Showcase> {
  final List<DummyData> _demoCards = DemoData().dummyData;
  final Color _backgroundColor = Color(0xFFf0f0f0);
  final ScrollController _scrollController = ScrollController();
  final List<int> _openCards = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: _buildAppBar(),
      body: Flex(
        direction: Axis.vertical,
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              physics: BouncingScrollPhysics(),
              itemCount: _demoCards.length,
              itemBuilder: (context, index) {
                return MyCard(
                  dummyData: _demoCards.elementAt(index),
                  onClick: () => _handleClickedCard(index),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  bool _handleClickedCard(int clickedTicket) {
    _openCards.contains(clickedTicket)
        ? _openCards.remove(clickedTicket)
        : _openCards.add(clickedTicket);

    double openTicketsOffset =
        MyCard.nominalOpenHeight * _getOpenCardsBefore(clickedTicket);
    double closedTicketsOffset =
        MyCard.nominalClosedHeight *
        (clickedTicket - _getOpenCardsBefore(clickedTicket));

    double offset =
        openTicketsOffset +
        closedTicketsOffset -
        (MyCard.nominalClosedHeight * .5);
    _scrollController.animateTo(
      max(0, offset),
      duration: Duration(seconds: 1),
      curve: Interval(.25, 1, curve: Curves.easeOutQuad),
    );
    return true;
  }

  _getOpenCardsBefore(int ticketIndex) {
    return _openCards.where((int index) => index < ticketIndex).length;
  }

  PreferredSizeWidget _buildAppBar() {
    Color appBarIconsColor = Color(0xFF212121);
    return AppBar(
      backgroundColor: _backgroundColor,
      elevation: 0,
      title: Container(
        width: double.infinity,
        alignment: Alignment.center,
        child: Text(
          'Zain Ul Abideen'.toUpperCase(),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 19,
            letterSpacing: 0.6,
            color: appBarIconsColor,
            fontFamily: 'OpenSans',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
