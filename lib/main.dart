import 'package:chex_case/dummy_data.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(debugShowCheckedModeBanner: false, title: 'Flutter Demo', home: MainScreen());
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final ScrollController _scrollController = ScrollController();

  final ValueNotifier<String> categoryNameNotifier = ValueNotifier(categoryList.first.categoryName);

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.hasClients) {
        int index = ((_scrollController.offset.abs() - kToolbarHeight) / 75).ceil() ~/ 10;

        categoryNameNotifier.value = categoryList[index].categoryName;
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(() {});
    super.dispose();
  }

  jumpToScroll(int index) {
    if (index == 0) {
      _scrollController.jumpTo(_scrollController.position.minScrollExtent);
    } else {
      _scrollController.jumpTo((index * 10 * 75));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                    children: List.generate(
                        categoryList.length,
                        (index) => TextButton(
                            onPressed: () {
                              jumpToScroll(index);
                            },
                            child: Text(categoryList[index].categoryName)))),
              ),
            ),
            Expanded(
                child: Container(
              color: Colors.white,
              child: CustomScrollView(
                controller: _scrollController,
                shrinkWrap: true,
                slivers: [
                  SliverAppBar(
                    title: ValueListenableBuilder(
                      valueListenable: categoryNameNotifier,
                      builder: (BuildContext context, String value, Widget? child) {
                        return Text(value);
                      },
                    ),
                    pinned: true,
                  ),
                  SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                    return SizedBox(height: 75, child: Center(child: Text(dummyItems[index].itemName)));
                  }, childCount: dummyItems.length))
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
