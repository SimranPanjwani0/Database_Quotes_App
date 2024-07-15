import 'dart:ui';

import 'package:db_miner/appRoutes/app_routes.dart';
import 'package:db_miner/controller/quote_controller.dart';
import 'package:db_miner/controller/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.sizeOf(context);
    QuoteController listenable = Provider.of(context);
    QuoteController nonListenable = Provider.of(context, listen: false);
    ThemeController themePro = Provider.of(context);
    return Scaffold(
      backgroundColor: Colors.black12,
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(themePro.isDark
                    ? "https://i.pinimg.com/736x/2f/ac/11/2fac110cc941791cf0fa974bdb821ee4.jpg"
                    : "https://dspncdn.com/a1/media/originals/64/95/d3/6495d3311f1112049ebab1c7b5fb47f5.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: s.height * 0.03,
                ),
                Row(
                  children: [
                    const Text(
                      "Quotes",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 25,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoutes.instance.fav);
                      },
                      icon: const Icon(
                        Icons.favorite,
                        color: Colors.white,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        themePro.isDark = !themePro.isDark;
                      },
                      icon: themePro.isDark
                          ? const Icon(
                              Icons.light_mode,
                              size: 35,
                              color: Colors.white,
                            )
                          : const Icon(
                              Icons.dark_mode_rounded,
                              size: 35,
                              color: Colors.black,
                            ),
                    ),
                  ],
                ),
                listenable.allQuote.isEmpty
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Expanded(
                        child: ListView.builder(
                          itemCount: listenable.allQuote.length,
                          itemBuilder: (context, index) => GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, AppRoutes.instance.detail,
                                  arguments: listenable.allQuote[index]);
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: BackdropFilter(
                                filter: ImageFilter.blur(
                                  sigmaY: 5,
                                  sigmaX: 5,
                                ),
                                child: Container(
                                  margin: const EdgeInsets.only(bottom: 16),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.primaries[index % 18],
                                      width: 2,
                                    ),
                                    color: Colors.black.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    children: [
                                      Text(
                                        listenable.allQuote[index].text,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          listenable.allQuote[index].author,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
