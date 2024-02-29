import 'package:flutter/material.dart';

String monthText(int month) {
  switch (month) {
    case 1:
      return "Jan";
    case 2:
      return "Feb";
    case 3:
      return "Mar";
    case 4:
      return "Apr";
    case 5:
      return "May";
    case 6:
      return "Jun";
    case 7:
      return "Jul";
    case 8:
      return "Aug";
    case 9:
      return "Sep";
    case 10:
      return "Oct";
    case 11:
      return "Nov";

    default:
      return "Des";
  }
}

Widget categoryIcon(category) {
  if (category == "مطعم") {
    return Icon(
      Icons.restaurant,
      color: Colors.grey[700],
    );
  } else if (category == "مقهى") {
    return Icon(
      Icons.coffee_outlined,
      color: Colors.grey[700],
    );
  } else if (category == "تسوق") {
    return Icon(
      Icons.shopping_bag_outlined,
      color: Colors.grey[700],
    );
  } else if (category == "فاتورة") {
    return Icon(
      Icons.receipt,
      color: Colors.grey[700],
    );
  } else if (category == "قرض") {
    return Icon(
      Icons.payments_outlined,
      color: Colors.grey[700],
    );
  } else if (category == "حوالة") {
    return Icon(
      Icons.payment,
      color: Colors.grey[700],
    );
  } else {
    return Icon(
      Icons.more_horiz,
      color: Colors.grey[700],
    );
  }
}
