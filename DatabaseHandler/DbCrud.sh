#!/bin/bash
################ Contains all CRUD  functions of the database

sqlStatement=""

#######
## function take mysql username,password orderId, date and employee name
##      return        0    order inserted
##      return        1    order not inserted
function insertInvoice() {
  sqlStatement=" insert into Bills.Orders values ($3,\"$4\",\"$5\")"
  mysql -u "$1" -p"$2" -e "$sqlStatement"
  if [ $? -eq 1 ]; then
    return 1
  fi
  return 0
}

#######
## function take mysql username,password, orderId,productName,price,quantity
##      return        0    orderDetail inserted
##      return        1    orderDetail not inserted
function insertInvoiceDetails() {
  sqlStatement=" insert into Bills.OrderDetails(orderId,productName,price,quantity) values ($3,\"$4\",$5,$6)"
  mysql -u "$1" -p"$2" -e "$sqlStatement"
  if [ $? -eq 1 ]; then
    return 1
  fi
  return 0
}

#######
## function create order and insert data into Orders and OrdersDetails tables
##  Takes  mysql username password,orderId,date,employeeName,productBName,price,quantity
##      return        0    order created
##      return        1    order not created

function createOrder() {
  insertInvoice "$1" "$2" "$3" "$4" "$5"
  insertInvoiceDetails "$1" "$2" "$3" "$6" "$7" "$8"
  if [ $? -eq 1 ]; then
    return 1
  fi
  return 0
}

#######
## function create order and insert data into Orders and OrdersDetails tables
##  Takes  mysql username password,orderId,date,employeeName,productBName,price,quantity
##      return        0    order created
##      return        1    order not created
function deleteOrder() {
  sqlStatement="delete from Bills.orderDetails where orderId = $3;delete from Bills.Order where  id = $3"
  mysql -u "$1" -p"$2" -e "$sqlStatement"
  if [ $? -eq 1 ]; then
    return 1
  fi
  return 0
}

#######
## function display selected Invoice
##      return        0    order displayed
##      return        1    mysql credentials wrong
function displayOrder() {
  sqlStatement="select OD.orderId,OD.productName,OD.price,OD.quantity from Bills.Orders as o
                  inner join Bills.OrderDetails OD on o.id = OD.orderId where OD.orderId = $3"
  mysql -u "$1" -p"$2" -e "$sqlStatement"
  if [ $? -eq 1 ]; then
    return 1
  fi
  return 0
}

#######
## function display orders
##      return        0    order displayed
##      return        1    mysql credentials wrong
function displayOrders() {
  sqlStatement="select OD.orderId,OD.productName,OD.price,OD.quantity from Bills.Orders as o
                  inner join Bills.OrderDetails OD on o.id = OD.orderId"
  mysql -u "$1" -p"$2" -e "$sqlStatement"
  if [ $? -eq 1 ]; then
    return 1
  fi
  return 0
}
