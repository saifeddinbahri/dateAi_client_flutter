import 'package:date_ai/services/treatment_details_service.dart';
import 'package:date_ai/utils/screen_padding.dart';
import 'package:date_ai/utils/screen_size.dart';
import 'package:date_ai/utils/theme_helper.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class TreatmentPreviewScreen extends StatefulWidget {
  const TreatmentPreviewScreen({
    super.key,
    required this.image,
    required this.title,
    required this.disease,
    required this.id,
  });

  final String id;
  final String image;
  final String title;
  final String disease;

  @override
  State<TreatmentPreviewScreen> createState() => _TreatmentPreviewScreenState();
}

class _TreatmentPreviewScreenState extends State<TreatmentPreviewScreen> with SingleTickerProviderStateMixin{
  late TabController _tabController ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _tabController.dispose();
    super.dispose();
  }

  Future<Map<String, List<dynamic>>> _getTreatmentDetails() async {
    final treatmentDetailsService = TreatmentDetailsService(widget.id);
    Map<String,List<dynamic>> result = {
      'monthly': [],
      'weekly': []
    };

    var res = await treatmentDetailsService.execute();
    if (res.success){
      List<dynamic>? data  = res.data['data']['treatments'][0]['progressLogs'];
      if (data != null && data.isNotEmpty) {
        for (var e in data) {
          List<String> parts = e['notes'].split(':');
          if (e['frequency'] == 'WEEKLY'){
            result['weekly']?.add({'title': parts[0], 'body':parts[1]});
          } else {
            result['monthly']?.add({'title': parts[0], 'body':parts[1]});
          }
        }
      }
    }
    return result;
  }
  
  @override
  Widget build(BuildContext context) {
    final screenSize = ScreenSize(context);
    final theme = ThemeHelper(context);
    final screenPadding = ScreenPadding(context);

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stack(
            children: [
              Image.network(
                'https://img.freepik.com/free-photo/leaves-tropical-palm_23-2147829135.jpg?t=st=1731345775~exp=1731349375~hmac=70a6d94c6014fded77ac71ba3ca8a846d3b1544a5d5ddff6aee977599f38568d&w=996',
                fit: BoxFit.fill,
                height: screenSize.height * 0.45,
                width: screenSize.width ,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loading) {
                  if (loading != null) {
                    return Shimmer.fromColors(
                      baseColor: theme.colorScheme.inversePrimary.withOpacity(0.1),
                      highlightColor: theme.colorScheme.inversePrimary!.withOpacity(0.03),
                      child: Container(
                        height: screenSize.height * 0.33,
                        width: screenSize.width,
                        color: Colors.white,
                      ),
                    );
                  }
                  return child;
                },
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: screenSize.height * 0.1,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color.fromARGB(128, 0, 0, 0), Colors.transparent],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 30,
                left: 16,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: screenSize.width * 0.07,
                      ),
                    ),
                    SizedBox(width: screenSize.width *0.03,),
                    Text(
                      widget.disease,
                      style: theme.textStyle.titleLarge!.copyWith(
                        color: Colors.white
                      ),
                    ),
                  ],
                )
              ),
            ],
          ),
          SizedBox(
            height: screenSize.height * 0.05,
            child: TabBar(
              controller: _tabController,
              splashFactory: NoSplash.splashFactory,
              overlayColor: WidgetStateColor.transparent,
              tabs: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Weekly',
                      textAlign: TextAlign.center,
                      style: theme.textStyle.titleMedium,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Monthly',
                      textAlign: TextAlign.center,
                      style: theme.textStyle.titleMedium,
                    ),
                  ],
                ),
            ],
            ),
          ),
          SizedBox(
            height: screenSize.height *0.5,
            child: FutureBuilder<Map<String, List<dynamic>>>(
                future: _getTreatmentDetails(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return SizedBox(
                        height: screenSize.height * 0.8,
                        width: screenSize.width,
                        child: Center(child: CircularProgressIndicator(color: theme.colorScheme.primary,),)
                    );
                  }
                  if(snapshot.hasData) {

                    return TabBarView(
                      controller: _tabController,
                      children: [
                        _tabView(snapshot.data!['weekly']!),
                        _tabView(snapshot.data!['monthly']!),
                      ],
                    );
                  }
                  return Center(child: Text('No treatment found', style: theme.textStyle.titleMedium,),);
                },
            ),
          ),
        ],
      ),
    );
  }
  Widget _tabView(List<dynamic> data) {
    final screenSize = ScreenSize(context);
    final theme = ThemeHelper(context);
    final screenPadding = ScreenPadding(context);

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screenPadding.horizontal,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ...data.map((e) => dataItem(e['title'], e['body'])),
          ],
        ),
      ),
    );
  }

  Widget dataItem(String title, String body) {
    final theme = ThemeHelper(context);

    return ListTile(
      title: Text(
        title,
        style: theme.textStyle.titleMedium,
      ),
      subtitle: Text(
        body,
        style: theme.textStyle.bodyMedium,
      ),
    );
  }
}
