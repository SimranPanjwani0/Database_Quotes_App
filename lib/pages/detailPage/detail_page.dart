import 'dart:ui';
import 'package:db_miner/controller/quote_controller.dart';
import 'package:db_miner/controller/wallpaper_controller.dart';
import 'package:db_miner/modals/quote_modal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class DetailPage extends StatelessWidget {
  DetailPage({super.key});

  List<Color> listColor = [
    const Color(0xffF9991E),
    const Color(0xff00BB9C),
    const Color(0xff08CF5B),
    const Color(0xffF35375),
    const Color(0xffAE5AE4),
    const Color(0xff088BCF),
    const Color(0xff393646),
    const Color(0xff4F4557),
    const Color(0xff6D5D6E),
    const Color(0xffF4EEE0),
    const Color(0xff9DC08B),
    const Color(0xff4E944F),
    const Color(0xff42855B),
    const Color(0xffC4DFAA),
    const Color(0xff40513B),
    const Color(0xff557153),
    const Color(0xff3C6255),
    const Color(0xff5F8D4E),
    const Color(0xff7D8F69),
    const Color(0xffE3B7A0),
    const Color(0xffFF6666),
    const Color(0xffFF8989),
    const Color(0xffFCAEAE),
    const Color(0xffFFEADD),
    const Color(0xffA78295),
    const Color(0xff73777B),
    const Color(0xff826F66),
    const Color(0xff99627A),
    const Color(0xff867070),
    const Color(0xff9E7676),
    const Color(0xffBB9981),
    const Color(0xff6B728E),
    const Color(0xffC1A3A3),
    const Color(0xff845460),
    const Color(0xffF3C5C5),
    ...Colors.primaries,
    ...Colors.accents,
  ];

  List<TextStyle> quoteFontFamily = [
    GoogleFonts.abel(),
    GoogleFonts.roboto(),
    GoogleFonts.dancingScript(),
    GoogleFonts.bitter(),
    GoogleFonts.anton(),
    GoogleFonts.yatraOne(),
    GoogleFonts.pacifico(),
    GoogleFonts.fjallaOne(),
    GoogleFonts.shadowsIntoLight(),
    GoogleFonts.indieFlower(),
    GoogleFonts.zillaSlab(),
    GoogleFonts.satisfy(),
    GoogleFonts.permanentMarker(),
    GoogleFonts.amaticSc(),
    GoogleFonts.cinzel(),
    GoogleFonts.sairaCondensed(),
    GoogleFonts.kalam(),
    GoogleFonts.courgette(),
    GoogleFonts.righteous(),
    GoogleFonts.tinos(),
    GoogleFonts.lobster(),
    GoogleFonts.changa(),
    GoogleFonts.greatVibes(),
    GoogleFonts.zeyada(),
    GoogleFonts.aladin(),
    GoogleFonts.kaushanScript(),
    GoogleFonts.pathwayGothicOne(),
    GoogleFonts.sacramento()
  ];

  @override
  Widget build(BuildContext context) {
    Quote quote = ModalRoute.of(context)!.settings.arguments as Quote;
    Size s = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    "https://dspncdn.com/a1/media/originals/64/95/d3/6495d3311f1112049ebab1c7b5fb47f5.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    SizedBox(
                      height: s.height * 0.08,
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Colors.white,
                      ),
                    ),
                    const Text(
                      "Details",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  clipBehavior: Clip.hardEdge,
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                    child: Container(
                      height: s.height * 0.4,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                            quote.image,
                          ),
                          fit: BoxFit.cover,
                        ),
                        color: Colors.black.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Text(
                            quote.text,
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                            style: Provider.of<QuoteController>(context)
                                .quoteStyle
                                .merge(
                                  TextStyle(
                                    color: Provider.of<QuoteController>(context)
                                        .txtColor,
                                    fontSize: 20,
                                  ),
                                ),
                          ),
                          const Spacer(),
                          Align(
                            alignment: Alignment.centerRight,
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "Author  ",
                                    style: Provider.of<QuoteController>(context)
                                        .quoteStyle
                                        .merge(
                                          TextStyle(
                                            color: Provider.of<QuoteController>(
                                                    context)
                                                .txtColor,
                                            fontSize: 20,
                                          ),
                                        ),
                                  ),
                                  TextSpan(
                                    text: quote.author,
                                    style: Provider.of<QuoteController>(context)
                                        .quoteStyle
                                        .merge(
                                          TextStyle(
                                            color: Provider.of<QuoteController>(
                                                    context)
                                                .txtColor,
                                            fontSize: 20,
                                          ),
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: s.height * 0.01,
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "Category  ",
                                    style: Provider.of<QuoteController>(context)
                                        .quoteStyle
                                        .merge(
                                          TextStyle(
                                            color: Provider.of<QuoteController>(
                                                    context)
                                                .txtColor,
                                            fontSize: 20,
                                          ),
                                        ),
                                  ),
                                  TextSpan(
                                    text: quote.category,
                                    style: Provider.of<QuoteController>(context)
                                        .quoteStyle
                                        .merge(
                                          TextStyle(
                                            color: Provider.of<QuoteController>(
                                                    context)
                                                .txtColor,
                                            fontSize: 20,
                                          ),
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: s.height * 0.03,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      Provider.of<WallpaperController>(context)
                          .allWallpaper
                          .length,
                      (index) => GestureDetector(
                        onTap: () {
                          Provider.of<WallpaperController>(context,
                                  listen: false)
                              .getImage(quote: quote, index: index);
                        },
                        child: Container(
                          height: s.height * 0.15,
                          width: s.width * 0.3,
                          margin: EdgeInsets.only(
                            right: s.width * 0.03,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: NetworkImage(
                                Provider.of<WallpaperController>(context)
                                    .allWallpaper[index]
                                    .previewUrl,
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: s.height * 0.03,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      listColor.length,
                      (index) => GestureDetector(
                        onTap: () {
                          Provider.of<QuoteController>(
                            context,
                            listen: false,
                          ).changeColor(color: listColor[index]);
                        },
                        child: Container(
                          height: s.height * 0.08,
                          width: s.width * 0.15,
                          margin: EdgeInsets.only(
                            right: s.width * 0.03,
                          ),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: listColor[index],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: s.height * 0.03,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      quoteFontFamily.length,
                      (index) => GestureDetector(
                        onTap: () {
                          Provider.of<QuoteController>(
                            context,
                            listen: false,
                          ).changeStyle(style: quoteFontFamily[index]);
                        },
                        child: Text(
                          "ABC   ",
                          textAlign: TextAlign.center,
                          style: quoteFontFamily[index].merge(
                            const TextStyle(
                              wordSpacing: 10,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    Provider.of<QuoteController>(
                      context,
                      listen: false,
                    ).addToFav(quote: quote);
                    Provider.of<QuoteController>(
                      context,
                      listen: false,
                    ).insertData(quote: quote);
                  },
                  icon: Icon(
                    Icons.favorite,
                    color: quote.isLiked ? Colors.red : Colors.white,
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
