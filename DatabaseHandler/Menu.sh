#!/bin/bash
source DbChecker.sh
source DbCrud.sh

password=$(cat pw)

function printDbState() {
  isDatabaseExist root "$password" Bills
  if [ $? -eq 0 ]; then
    echo "Bills Database has been created successfully"
  else
    echo "Bills database not exist check mysql credentials"

  fi
}

function printTablesState() {
  isTableExist root "$password"
  if [ $? -eq 0 ]; then
    echo "Order and OrderDetails tables has been created successfully"
  else
    echo "Orders and OrderDetails are not exist check mysql credentials"
  fi
}

###### Take invoice Id
## Print Invoice state
function printInvoiceSelectedState() {
  isInvoiceExist root "$password" "$1"

  if [ $? -eq 0 ]; then
    printInvoicesState
  else
    echo "No Order found with the selected ID"
  fi
}

####### Print all  Invoices
function printInvoicesState() {
  isInvoiceExist root "$password"
  displayOrders root "$password"
}

printMenu() {
  exit=0
  while [ $exit -eq 0 ]; do
    #    read -rp "Please select Operation 1-Insert\n  2- Delete\n 3-Print Invoice\n 4-print all Invoices\n 5-Exit\n" result
    echo "Please select operation : -"
    echo "1) Insert Invoice"
    echo "2) Delete Invoice"
    echo "3) Print Invoice"
    echo "4) Print all Invoices"
    read -rp "5) Exit " result

    if [ "$result" -eq 1 ]; then
      read -rp "Please Enter orderId: " orderId
      read -rp "Please Enter Invoice date: " date
      read -rp "Please Enter Employee name: " employeeName
      read -rp "Please Enter product name: " productName
      read -rp "Please Enter product price: " price
      read -rp "Please Enter product quantity: " quantity
      createOrder root "$password" "$orderId" "$date" "$employeeName" "$productName" "$price" "$quantity"
      if [ $? -eq 0 ]; then
        echo "Invoice has been created"
      else
        echo "Failed to create Invoice"
      fi
    elif [ "$result" -eq 2 ]; then
      read -rp "Please Enter orderId" orderId
      deleteOrder root "$password" "$orderId"
      if [ $? -eq 0 ]; then
        echo "Invoice has been deleted"
      else
        echo "Failed to delete Invoice"
      fi
    elif [ "$result" -eq 3 ]; then
      read -rp "Please Enter orderId: " orderId
      echo $orderId
      printInvoiceSelectedState $orderId
    elif [ "$result" -eq 4 ]; then
      printInvoicesState
    elif [ "$result" -eq 5 ]; then
      exit=1
    fi
  done
}
