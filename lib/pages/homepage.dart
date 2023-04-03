import 'package:flutter/material.dart';
import 'ProgrammeListeD.dart';
import 'ProgrammeListeI.dart';
import 'ProgrammeListeE.dart';

class TrainingApp extends StatefulWidget {
  @override
  _TrainingAppState createState() => _TrainingAppState();
}

class _TrainingAppState extends State<TrainingApp>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Tab> _tabs = [    Tab(      text: 'Débutant',    ),    Tab(      text: 'Intermédiaire',    ),    Tab(      text: 'Expert',    ),  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Training App',
      theme: ThemeData(
        primaryColor: Color(0xff92140C), // Couleur de la AppBar et la top bar
        accentColor: Colors.black, // Couleur noire
        appBarTheme: AppBarTheme(
          color: Color(0xff92140C), // Couleur de la AppBar
        ),
        tabBarTheme: TabBarTheme(
          labelColor: Colors.white, // Couleur blanche pour l'onglet sélectionné
          unselectedLabelColor: Colors.white.withOpacity(0.5), // Couleur blanche transparente pour les autres onglets
          labelStyle: TextStyle(
            fontWeight: FontWeight.bold, // Texte en gras
          ),
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Y & W',
            style: TextStyle(
              fontWeight: FontWeight.bold, // Texte en gras
              color: Colors.white, // Couleur blanche
            ),
          ),
          centerTitle: true, // Centrer le titre dans la barre d'applications
          bottom: TabBar(
            controller: _tabController,
            tabs: _tabs,
            indicatorColor: Colors.white,
            isScrollable: true,
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: <Widget>[
            _buildLevelPage('Débutant', Colors.black, Colors.white, ProgramListD()),
            _buildLevelPage('Intermédiaire', Colors.black, Colors.white, ProgramListI()),
            _buildLevelPage('Expert', Colors.black, Colors.white, ProgramListE()),
          ],
        ),
      ),
    );
  }

  Widget _buildLevelPage(String level, Color backgroundColor, Color textColor, Widget programList) {
    return Container(
      color: backgroundColor,
      child: Center(
        child: programList,
      ),
    );
  }
}
