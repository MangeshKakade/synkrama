import 'package:get/get.dart';
import '../models/order_data.dart';

class OrderViewModel extends GetxController {
  final orders = <Order>[].obs;

  void addOrder(Order order) {
    orders.add(order);
  }

  void editOrder(int index, Order updatedOrder) {
    orders[index] = updatedOrder;
  }

  void deleteOrder(int index) {
    orders.removeAt(index);
  }
}
