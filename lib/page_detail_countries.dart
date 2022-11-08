import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'countries_model.dart';
import 'covid_data_source.dart';

class PageDetailCountries extends StatefulWidget {
  const PageDetailCountries({Key? key}) : super(key: key);
  @override
  _PageDetailCountriesState createState() => _PageDetailCountriesState();
}

class _PageDetailCountriesState extends State<PageDetailCountries> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Countries Detail"),
      // ),
      body: _buildDetailCountriesBody(),
    );
  }

  Widget _buildDetailCountriesBody() {
    return Container(
      child: FutureBuilder(
        future: CovidDataSource.instance.loadCountries(),
        builder: (
            BuildContext context,
            AsyncSnapshot<dynamic> snapshot,
            ) {
          if (snapshot.hasError) {
            return _buildErrorSection();
          }
          if (snapshot.hasData) {
            CountriesModel countriesModel =
            CountriesModel.fromJson(snapshot.data);
            return _buildSuccessSection(countriesModel);
          }
          return _buildLoadingSection();
        },
      ),
    );
  }

  Widget _buildErrorSection() {
    return Text("Error");
  }

  Widget _buildEmptySection() {
    return Text("Empty");
  }

  Widget _buildLoadingSection() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildSuccessSection(CountriesModel data) {
    return Scaffold(

      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 300.0,
              floating: false,
              pinned: true,
              stretch: true,
              flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  collapseMode: CollapseMode.parallax,
                  title: const Text("Covid19 Countries",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 16.0,
                      )),
                  background: Image.network(
                    "https://media.istockphoto.com/photos/coronavirus-2019ncov-title-background-picture-id1207067986",
                    fit: BoxFit.cover,
                  )),
            ),
          ];
        },


        body:

        Padding(
          padding: const EdgeInsets.all(10.0),

          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            itemCount: data.countries?.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                decoration: BoxDecoration(color: Colors.blue.shade200,
                    borderRadius: BorderRadius.circular(10,)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "${data.countries?[index].name}",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      "(${data.countries?[index].iso3})",
                      style: const TextStyle(
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),


      ),
    );
  }

  Widget _buildItemCountries(String value) {
    return Text(value);
  }
}