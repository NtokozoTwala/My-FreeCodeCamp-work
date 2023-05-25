#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

echo $($PSQL "DELETE FROM games;")
echo $($PSQL "DELETE FROM teams;")

IFS=','

cat games.csv | while read -r YEAR ROUND WINNER OPPONENT W_GOAL O_GOAL
do

if [[ $YEAR = 'year' ]]
then
  continue
fi
echo $YEAR $ROUND $WINNER $OPPONENT $W_GOAL $O_GOAL
done

