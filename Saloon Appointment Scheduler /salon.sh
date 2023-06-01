#!/bin/bash


PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"


echo -e "\n~~~ Salon Appointment Schedule ~~~"

MAIN_MENU(){
  if [[ $1 ]]
  then
    echo -e "\n$1"
  fi

  #echo -e "\nSelect which service you would like."
  echo $($PSQL "SELECT * FROM services") | sed  's/ |/)/g'
  #echo "5) Exit"
  read SERVICE_ID_SELECTED

  
 # echo $
  if [[ ! $SERVICE_ID_SELECTED =~ ^[1-4]+$ ]]
  then
    MAIN_MENU    
  else
    APP $SERVICE_ID_SELECTED
  fi


}

APP(){

  SERVICE_SELECTED=$($PSQL "SELECT name FROM services WHERE service_id=$1")
  echo "You've selected $SERVICE_SELECTED. "

  echo -e "\nPlease enter your phone"
  read CUSTOMER_PHONE

  CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone='$CUSTOMER_PHONE'")

  if [[ -z $CUSTOMER_NAME ]]
  then
    echo -e "\nPlease enter your name"
    read CUSTOMER_NAME
    echo -e "\nHi $CUSTOMER_NAME"
    INSERT_CUSTOMER=$($PSQL "INSERT INTO customers(name,phone) VALUES('$CUSTOMER_NAME','$CUSTOMER_PHONE')")
  else
    echo "we know you. Hi c "
  fi

  echo -e "What time would you like to book your appointment for?"
  read SERVICE_TIME

  CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE name='$CUSTOMER_NAME'")
  #echo $CUSTOMER_ID"
  APPOINTMENT=$($PSQL "INSERT INTO appointments(customer_id,service_id,time) VALUES('$CUSTOMER_ID','$1','$SERVICE_TIME')")
  echo -e "\nI have put you down for a $SERVICE_SELECTED at $SERVICE_TIME, $CUSTOMER_NAME."

}

MAIN_MENU
