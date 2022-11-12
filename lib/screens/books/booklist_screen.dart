import 'package:flutter/material.dart';
import 'package:flutter_book_api1/screens/shared/cart_badge.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_book_api1/models/book.dart';
import 'package:flutter_book_api1/providers/book_provider.dart';
import 'package:flutter_book_api1/screens/books/components/bookitem.dart';


class BookListScreen extends StatelessWidget {
  const BookListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Books'),
        //โชว์สินค้าในตักกร้า
        actions: const [Badge()],
      ),
      body: const BookGrid(),
    );
  }
}

class BookGrid extends StatefulWidget {
  const BookGrid({super.key});

  @override
  State<BookGrid> createState() => _BookGridState();
}

class _BookGridState extends State<BookGrid> {
  CoffeeProvider books = CoffeeProvider();
  List<Book>? searchBooks = [];
  TextEditingController editingController = TextEditingController();

  List<String> categoryList = [
    "Web Development",
    "Internet",
    "Java",
    "Microsoft .NET",
    "Mobile Technology",
    "Programming",
    "Software Engineering"
  ];

  List<String> selectedCategoryList = [];

  final PageController _controller =
      PageController(initialPage: 0, viewportFraction: 0.9);

  Future? _loadBook;
  List<Book> _listBook = [];

  @override
  void initState() {
    super.initState();
    _loadBook = _getBook();
  }

  _getBook() async{
    return await books.getCoffee();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    

    //Code for create book list using FutureBuilder
    return FutureBuilder(
      future: _loadBook,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          return const Center(
            child: CircularProgressIndicator() ,
            );
        }else if(snapshot.connectionState == ConnectionState.done){
          if(snapshot.hasData){
            int numberItem = 4;
            var size = MediaQuery.of(context).size;
            final double itemHeight = (size.height * 0.6) / 2;
            final double itemWidth = size.width / 2;

            _listBook= snapshot.data;

            if (searchBooks!.isEmpty &&
                editingController.text.isEmpty &&
                selectedCategoryList.isEmpty) {
              searchBooks = _listBook;
            }

            return Column(
        children: [
          //Book Search
          bookSearch(),

          //Category
          bookCategory(),
          const SizedBox(
            height: 15,
          ),

          //PageView
          (searchBooks!.isEmpty)
              ? noBookDisplay(itemHeight)
              : bookListDisplay(numberItem, itemWidth, itemHeight),

          //Paging
          (searchBooks!.isNotEmpty)
              ? bookPaging(numberItem)
              : const SizedBox.shrink(),
          const SizedBox(
            height: 20,
          )
        ],
      );

          }
        }else{
          return const Center(child: CircularProgressIndicator(),);
        }
        return const Text("No Data");
      },       
    );
  }

  Container bookSearch() {
    return Container(
      margin: const EdgeInsets.all(15.0),
      alignment: Alignment.centerLeft,
      child: TextField(
        onEditingComplete: () {
          setState(() {
            List<Book> bookTemp;
            if (editingController.text.isNotEmpty) {
              bookTemp = books.findBookTitle(editingController.text,_listBook);
            } else {
              bookTemp = _listBook;
            }

            if (selectedCategoryList.isNotEmpty) {
              searchBooks = bookTemp.where((bk) {
                return selectedCategoryList.contains(bk.coffeeName)
                    ? true
                    : false;
              }).toList();
            } else {
              searchBooks = bookTemp;
            }
          });
        },
        controller: editingController,
        decoration: InputDecoration(
            labelText: "Search",
            hintText: "Search",
            fillColor: Colors.blueGrey[100],
            filled: true,
            prefixIcon: const Icon(Icons.search),
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  if (selectedCategoryList.isEmpty) {
                    searchBooks = _listBook;
                  } else {
                    searchBooks = _listBook.where((bk) {
                      return selectedCategoryList.contains(bk.coffeeDescription)
                          ? true
                          : false;
                    }).toList();
                  }
                });

                editingController.clear();
              },
              icon: const Icon(Icons.clear_rounded),
            ),
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0)))),
      ),
    );
  }

  SingleChildScrollView bookCategory() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: buildChoiceList(),
      ),
    );
  }

  List<Widget> buildChoiceList() {
    List<Widget> choices = [];

    choices.add(
      const SizedBox(
        width: 20,
      ),
    );
    for (var cat in categoryList) {
      choices.add(categoryChoices(cat, selectedCategoryList.contains(cat)));
      choices.add(
        const SizedBox(
          width: 5,
        ),
      );
    }
    choices.add(
      const SizedBox(
        width: 15,
      ),
    );

    return choices;
  }

  ChoiceChip categoryChoices(String categoryName, bool categorySelected) {
    return ChoiceChip(
        label: Text(
          categoryName,
          style: GoogleFonts.lato(
              letterSpacing: 1,
              textStyle:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
        ),
        avatar: (categorySelected)
            ? const CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.check_rounded,
                  color: Colors.black,
                  size: 20.0,
                ),
              )
            : null,
        labelStyle: TextStyle(
          color: (categorySelected) ? Colors.white : Colors.white,
        ),
        backgroundColor: Colors.grey.withOpacity(0.8),
        selectedColor: Colors.black,
        shadowColor: Colors.grey.withOpacity(0.4),
        selected: categorySelected,
        shape: const StadiumBorder(
            side: BorderSide(color: Colors.blueGrey, width: 1)),
        onSelected: (selected) {
          setState(() {
            selectedCategoryList.contains(categoryName)
                ? selectedCategoryList.remove(categoryName)
                : selectedCategoryList.add(categoryName);

            List<Book> bookTemp;
            if (editingController.text.isNotEmpty) {
              bookTemp = books.findBookTitle(editingController.text,_listBook);
            } else {
              bookTemp = _listBook;
            }

            if (selectedCategoryList.isNotEmpty) {
              searchBooks = bookTemp.where((bk) {
                return selectedCategoryList.contains(bk.coffeeName)
                    ? true
                    : false;
              }).toList();
            } else {
              searchBooks = bookTemp;
            }
          });
        });
  }

  Container noBookDisplay(double itemHeight) {
    return Container(
        height: itemHeight,
        alignment: Alignment.center,
        child: const Text(
          "No book found!",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 30, color: Colors.red, fontWeight: FontWeight.bold),
        ));
  }

  Expanded bookListDisplay(
      int numberItem, double itemWidth, double itemHeight) {
    return Expanded(
      child: PageView.builder(
          controller: _controller,
          scrollDirection: Axis.horizontal,
          itemCount: (searchBooks!.length / numberItem).ceil(),
          itemBuilder: (context, p) {
            return GridView.builder(
              padding: const EdgeInsets.all(5.0),
              itemCount: numberItem,
              itemBuilder: (ctx, i) {
                if (((p * numberItem) + i) < searchBooks!.length) {
                  return BookItem(book: searchBooks![(p * numberItem) + i]);
                } else {
                  return const SizedBox.shrink();
                }
              },
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: (itemWidth / itemHeight),
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
              ),
            );
          }),
    );
  }

  SmoothPageIndicator bookPaging(int numberItem) {
    return SmoothPageIndicator(
      count: (searchBooks!.length / numberItem).ceil(),
      controller: _controller,
      effect: ScrollingDotsEffect(
          activeDotColor: Colors.black87,
          dotColor: Colors.blueGrey.withOpacity(0.3),
          spacing: 6.0,
          fixedCenter: true),
    );
  }
}
