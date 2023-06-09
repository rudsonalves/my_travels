import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/place_detail_screen.dart';
import './screens/place_form_screen.dart';
import './utils/app_routes.dart';
import './screens/places_list_screen.dart';
import './providers/great_places.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GreatPlaces()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        debugShowCheckedModeBanner: false,
        // home: const PlaceFormScreen(),
        routes: {
          AppRoutes.placesList: (context) => const PlacesListScreen(),
          AppRoutes.placeForm: (context) => const PlaceFormScreen(),
          AppRoutes.placeDetail: (context) => const PlaceDetailScreen(),
        },
      ),
    );
  }
}
