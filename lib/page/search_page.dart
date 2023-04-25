import 'package:flutter/material.dart';

import '../database/database_helper.dart';
import '../models/customer.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);
  static const route = '/search-page';

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  String searchInput = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(20, 142, 146, 1),
        // automaticallyImplyLeading: false,
        title: const Text('Searching Page'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              child: TextField(
                onChanged: ((value) {
                  setState(() {
                    searchInput = value;
                  });
                }),
                cursorColor: Colors.black,
                controller: _searchController,
                decoration: const InputDecoration(
                  suffixIcon: Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                  hintText: 'Search by phone number',
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide:
                          BorderSide(color: Color.fromRGBO(20, 142, 146, 1))),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide:
                          BorderSide(color: Color.fromRGBO(20, 142, 146, 1))),
                ),
              ),
            ),
            FutureBuilder<List<Customer>>(
                future: DatabaseHelper.instance
                    .searchCustomer(_searchController.text),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Customer>> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: Text('Loading..'),
                    );
                  }
                  return snapshot.data!.isEmpty
                      ? const Center(
                          child: Text('No customers in list!'),
                        )
                      : Container(
                          height: 600,
                          child: SingleChildScrollView(
                            child: Column(
                              // shrinkWrap: true,
                              children: snapshot.data!.map((customer) {
                                return Card(
                                    margin: const EdgeInsets.all(10),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    elevation: 4,
                                    child: ListTile(
                                        leading: const Icon(
                                            Icons.account_circle_rounded,
                                            size: 35),
                                        title: Text(
                                          customer.name,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        // subtitle: Text('${customer.emailAddress}\n${customer.phoneNumber}'),
                                        subtitle: Text(
                                            '${customer.emailAddress}\n${customer.phoneNumber}'),
                                        trailing: customer.gender == 'male'
                                            ? const Icon(Icons.male)
                                            : const Icon(Icons.female)));
                              }).toList(),
                            ),
                          ),
                        );
                })
          ],
        ),
      ),
      // body: FutureBuilder<List<Customer>>(
      //     future:
      //         DatabaseHelper.instance.searchCustomer(_searchController.text),
      //     builder:
      //         (BuildContext context, AsyncSnapshot<List<Customer>> snapshot) {
      //       if (!snapshot.hasData) {
      //         return const Center(
      //           child: Text('Loading..'),
      //         );
      //       }
      //       return snapshot.data!.isEmpty
      //           ? const Center(
      //               child: Text('No customers in list!'),
      //             )
      //           : ListView(
      //               children: snapshot.data!.map((customer) {
      //                 return Card(
      //                     margin: const EdgeInsets.all(8),
      //                     shape: RoundedRectangleBorder(
      //                         borderRadius: BorderRadius.circular(15)),
      //                     elevation: 4,
      //                     child: ListTile(
      //                         leading: const Icon(
      //                             Icons.account_circle_rounded,
      //                             size: 35),
      //                         title: Text(
      //                           customer.name,
      //                           style: const TextStyle(
      //                               fontWeight: FontWeight.bold),
      //                         ),
      //                         // subtitle: Text('${customer.emailAddress}\n${customer.phoneNumber}'),
      //                         subtitle: Text(
      //                             '${customer.emailAddress}\n${customer.phoneNumber}'),
      //                         trailing: customer.gender == 'male'
      //                             ? const Icon(Icons.male)
      //                             : const Icon(Icons.female)));
      //               }).toList(),
      //             );
      //     }));
    );
  }
}
