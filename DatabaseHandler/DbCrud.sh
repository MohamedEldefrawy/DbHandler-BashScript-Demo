#!/bin/bash
source DbChecker.sh
################ Contains all CRUD  functions of the database

isDatabaseExist root Mohamed\$5265104@D Bills

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
}

#######
## function create order and insert data into Orders and OrdersDetails tables
##  Takes  mysql username password,orderId,date,employeeName,productBName,price,quantity
##      return        0    order created
##      return        1    order not created

function createOrder() {
  # shellcheck disable=SC2086
  insertInvoice "$1" $2 "$3" "$4" "$5"
  insertInvoiceDetails "$1" "$2" "$3" "$6" "$7" "$8"
  if [ $? -eq 1 ]; then
    return 1
  fi
  return 0
}
