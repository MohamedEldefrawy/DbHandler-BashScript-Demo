#!/bin/bash
################ Contains all functions that check the existence of the database and tables

sqlStatement=""

#######
## function take mysql username,password database name
##      return             0    database created
##      return             1    username or password wrong
function isDatabaseExist() {
  sqlStatement="create database if not exists $3;"
  mysql -u "$1" -p"$2" -e "$sqlStatement"
  if [ $? -eq 1 ]; then
    return 1
  fi
  return 0
}

#isDatabaseExist root Mohamed\$5265104@D Bills

#######
## function take mysql username,password
##      return             0    tables created
##      return             1    username or password wrong
function isTableExist() {
  sqlStatement="create table if not exists Bills.Orders
              (
                  id           int primary key,
                  orderDate    date,
                  employeeName varchar(50)
              ); CREATE TABLE if not exists Bills.OrderDetails
                 (
                     id          int NOT NULL,
                     orderId     int         DEFAULT NULL,
                     productName varchar(50) DEFAULT NULL,
                     price       int         DEFAULT NULL,
                     quantity    int         DEFAULT NULL,
                     PRIMARY KEY (id),
                     KEY orderId (orderId),
                     CONSTRAINT OrderDetails_ibfk_1 FOREIGN KEY (orderId) REFERENCES Orders (id)
                 );"
  mysql -u "$1" -p"$2" -e "$sqlStatement"
  if [ $? -eq 1 ]; then
    return 1
  fi
  return 0
}

#######
## function take mysql username,password and invoice id
##      return             0    Invoice exist
##      return             1    Invoice not exist
function isInvoiceExist() {
  sqlStatement="select count(*) from Bills.Orders where Orders.id=$3"
  local count=$(mysql -u "$1" -p"$2" -e "$sqlStatement")
  count=$(echo "$count" | tail -1)
  if [ $count -ne 1 ]; then
    return 1
  fi
  return 0
}

#######
## function take mysql username,password and invoice id
##      return             0    InvoiceDetails exist
##      return             1    InvoiceDetails not exist
function isInvoiceHasDetails() {
  sqlStatement="select count(*) from Bills.OrderDetails where OrderDetails.orderId=$3"
  local count=$(mysql -u "$1" -p"$2" -e "$sqlStatement")
  count=$(echo "$count" | tail -1)

  if [ $count -eq 0 ]; then
    return 1
  fi
  return 0
}

isInvoiceHasDetails root Mohamed\$5265104@D 1000
