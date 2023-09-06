import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/order_data.dart';
import '../../viewmodels/order_view_model.dart';

class OrderScreen extends StatelessWidget {
  final OrderViewModel viewModel = Get.put(OrderViewModel());
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _editFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text('Order Screen'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 10, right: 10),
              child: Card(
                elevation: 5.0,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(height: 20),
                        TextFormField(
                          controller: nameController,
                          decoration: InputDecoration(
                            labelText: 'Order Name',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter an order name';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: descriptionController,
                          decoration: InputDecoration(
                            labelText: 'Description',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter an order description';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: priceController,
                          decoration: InputDecoration(
                            labelText: 'Price',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          keyboardType: TextInputType.numberWithOptions(decimal: true),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter a price';
                            }
                            final double? price = double.tryParse(value);
                            if (price == null || price <= 0) {
                              return 'Please enter a valid price';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 30),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              final name = nameController.text;
                              final description = descriptionController.text;
                              final price = double.parse(priceController.text);

                              final newOrder = Order(
                                id: viewModel.orders.length + 1,
                                name: name,
                                description: description,
                                price: price,
                              );

                              viewModel.addOrder(newOrder);

                              nameController.clear();
                              descriptionController.clear();
                              priceController.clear();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueGrey,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: Text('Add Order',style: TextStyle(fontFamily: 'Poppins'),),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Obx(
                  () => ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: viewModel.orders.length,
                    itemBuilder: (context, index) {
                    final order = viewModel.orders[index];
                    return Card(
                    elevation: 5.0,
                    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: ListTile(
                      title: Text(
                        order.name,
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,fontFamily: 'Poppins'),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            order.description,
                            style: TextStyle(fontSize: 14,fontFamily: 'Poppins'),
                          ),
                          SizedBox(height: 5), // Add some spacing
                          Text(
                            'Price: \$${order.price.toStringAsFixed(2)}',
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold,fontFamily: 'Poppins'),
                          ),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.edit,
                              color: Colors.blue,
                            ),
                            onPressed: () {
                              _editOrder(context, index, order);
                            },
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              viewModel.deleteOrder(index);
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

          ],
        ),
      ),
    );
  }

  void _editOrder(BuildContext context, int index, Order order) {
    final TextEditingController editNameController =
    TextEditingController(text: order.name);
    final TextEditingController editDescriptionController =
    TextEditingController(text: order.description);
    final TextEditingController editPriceController =
    TextEditingController(text: order.price.toString());

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Order',style: TextStyle(fontFamily: 'Poppins'),),
          content: Form(
            key: _editFormKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: editNameController,
                    decoration: InputDecoration(labelText: 'Order Name',
                        labelStyle: TextStyle(fontFamily: 'Poppins')
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter an order name';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: editDescriptionController,
                    decoration: InputDecoration(labelText: 'Description',labelStyle: TextStyle(fontFamily: 'Poppins')),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter an order description';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: editPriceController,
                    decoration: InputDecoration(labelText: 'Price',labelStyle: TextStyle(fontFamily: 'Poppins')),
                    keyboardType:
                    TextInputType.numberWithOptions(decimal: true),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a price';
                      }
                      final double? price = double.tryParse(value);
                      if (price == null || price <= 0) {
                        return 'Please enter a valid price';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                if (_editFormKey.currentState!.validate()) {
                  final newName = editNameController.text;
                  final newDescription = editDescriptionController.text;
                  final newPrice = double.parse(editPriceController.text);

                  final updatedOrder = Order(
                    id: order.id,
                    name: newName,
                    description: newDescription,
                    price: newPrice,
                  );
                  viewModel.editOrder(index, updatedOrder);
                  Navigator.of(context).pop();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueGrey,
                textStyle: TextStyle(fontFamily: 'Poppins'),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                'Save',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Poppins'
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueGrey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Poppins'
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
