import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../model/cate.dart';


   List<Cate> getCate() {
     List<Cate> cate = [];
    cate.add(Cate(
        cateTitle: "BASIC",
        cateItem: [CateItem(icon: FontAwesomeIcons.chartArea, itemTitle: "Area"),
        CateItem(icon: Icons.straighten_outlined, itemTitle: "length"),CateItem(icon: Icons.scale_outlined, itemTitle: "mass"),CateItem(icon: Icons.thermostat, itemTitle: "temperature")]),
    );
    cate.add(Cate(
        cateTitle: "Currency",
        cateItem: [CateItem(icon: Icons.attach_money, itemTitle: "US Dollar"),
          CateItem(icon: Icons.currency_pound, itemTitle: "British Pound"),CateItem(icon: FontAwesomeIcons.nairaSign, itemTitle: "Nigerian Naira"),CateItem(icon: Icons.euro, itemTitle: "Euro")]),
    );
    cate.add(Cate(
        cateTitle: "Crypto-Currency",
        cateItem: [CateItem(icon: Icons.currency_bitcoin, itemTitle: "Bitcoin"),
          CateItem(icon: FontAwesomeIcons.ethereum, itemTitle: "Ethereum"),CateItem(icon: FontAwesomeIcons.t, itemTitle: "Tether"),CateItem(icon: FontAwesomeIcons.diamond, itemTitle: "Binance Coin")]),
    );
    cate.add(Cate(
        cateTitle: "Science",
        cateItem: [CateItem(icon: FontAwesomeIcons.gauge, itemTitle: "pressure"),
          CateItem(icon: Icons.login_outlined, itemTitle: "force"),CateItem(icon: FontAwesomeIcons.faucetDrip, itemTitle: "volumeFlowRate"),CateItem(icon: Icons.architecture_outlined, itemTitle: "angle")]),
    );
    cate.add(Cate(
        cateTitle: "Electricity",
        cateItem: [CateItem(icon: Icons.offline_bolt_outlined, itemTitle: "energy"),
          CateItem(icon: Icons.electric_bolt, itemTitle: "current"),CateItem(icon: FontAwesomeIcons.chargingStation, itemTitle: "power"),CateItem(icon: Icons.lightbulb ,itemTitle: "illuminance")]),
    );
    return cate;
  }

  final basicTiles=<Cate>[
    Cate(cateTitle: "Unit", cateItem: [CateItem(icon: FontAwesomeIcons.gauge, itemTitle: "Pressure"),
      CateItem(icon: Icons.login_outlined, itemTitle: "Force"),CateItem(icon: FontAwesomeIcons.faucetDrip, itemTitle: "flow"),CateItem(icon: Icons.architecture_outlined, itemTitle: "Angle")]),
    Cate(cateTitle: "Currency/Cypto", cateItem: [CateItem(icon: Icons.currency_bitcoin, itemTitle: "Bitcoin"),
      CateItem(icon: FontAwesomeIcons.ethereum, itemTitle: "Ethereum"),CateItem(icon: FontAwesomeIcons.t, itemTitle: "Tether"),CateItem(icon: FontAwesomeIcons.diamond, itemTitle: "Binance COIN")])
  ];

