import 'package:firebase_database/firebase_database.dart';
import 'package:flutterfire_ui/database.dart';
import 'package:system_biodairect/fitness_app/fitness_app_theme.dart';
import 'package:flutter/material.dart';
import 'package:system_biodairect/fitness_app/ui_view/recipes_view/recipe_list_view.dart';
import 'package:system_biodairect/model/recipe.dart';

class StabilizacjaRecipe extends StatefulWidget {
  @override
  _StabilizacjaRecipeState createState() => _StabilizacjaRecipeState();
}

class _StabilizacjaRecipeState extends State<StabilizacjaRecipe>{
  
  Animation<double>? topBarAnimation;

  List<Recipe> recipesList = [];
  List<Widget> listViews = <Widget>[];
  final ScrollController scrollController = ScrollController();
  Query refAktywacjat1 = FirebaseDatabase.instance.ref('Przepisy_2').child('Stabilizacja').child('Tydzien1');
  Query refAktywacjat2 = FirebaseDatabase.instance.ref('Przepisy_2').child('Stabilizacja').child('Tydzien2');
  Query refAktywacjat3 = FirebaseDatabase.instance.ref('Przepisy_2').child('Stabilizacja').child('Tydzien3');
  double topBarOpacity = 0.0;

  @override
  void initState() {
    super.initState();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      color: FitnessAppTheme.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            getAppBarUI(),
            Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              child: Padding(
                padding: EdgeInsets.only(
                  top: AppBar().preferredSize.height + MediaQuery.of(context).padding.top + 36,),
                child: Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: FirebaseDatabaseQueryBuilder(
                    query: refAktywacjat1,
                    builder: (context, snapshot, _) {
                      // ...

                      return GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, 
                          childAspectRatio: MediaQuery.of(context).size.width /
                            (MediaQuery.of(context).size.height / 1.6),),
                        itemCount: snapshot.docs.length,
                        itemBuilder: (context, index) {
                          // if we reached the end of the currently obtained items, we try to
                          // obtain more items
                          if (snapshot.hasMore && index + 1 == snapshot.docs.length) {
                            // Tell FirebaseDatabaseQueryBuilder to try to obtain more items.
                            // It is safe to call this function from within the build method.
                            snapshot.fetchMore();
                          }
                          final recipeInfo = snapshot.docs[index].value as Map<dynamic, dynamic>;
                          Recipe recipes = Recipe.fromMap(recipeInfo);
                          return GestureDetector(
                            onTap: (){
                              print('${recipes.kcal}');
                            },
                            child: RecipeListView(recipeKcal: recipes.kcal, recipeName: recipes.nazwa)
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 8, left: 8),
              child: SizedBox(
                width: AppBar().preferredSize.height - 8,
                height: AppBar().preferredSize.height - 8,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(AppBar().preferredSize.height),
                    child: Center(
                      child: Icon(
                        Icons.arrow_back,
                      ),
                    ),
                    onTap: () => Navigator.of(context).pop(true),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }



  Widget getAppBarUI() {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          child: Container(
            decoration: BoxDecoration(
              color: FitnessAppTheme.white.withOpacity(topBarOpacity),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: FitnessAppTheme.grey
                    .withOpacity(0.4 * topBarOpacity),
                      offset: const Offset(0, 5),
                      blurRadius: 5.0, 
                      spreadRadius: 0),
              ],
            ),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).padding.top,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 16,
                    right: 16,
                    top: 40 - 8.0 * topBarOpacity,
                    bottom: 20 - 8.0 * topBarOpacity
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                         child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Przepisy Stabilizacja',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontFamily: FitnessAppTheme.fontName,
                              fontWeight: FontWeight.w700,
                                fontSize: 22 + 6 - 6 * topBarOpacity,
                                letterSpacing: 1.2,
                                color: FitnessAppTheme.darkerText,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ]
    );
  }
}