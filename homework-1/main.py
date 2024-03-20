"""Скрипт для заполнения данными таблиц в БД Postgres."""

import os
import csv

import psycopg2

conn_params = {
    "host": "localhost",
    "database": "north",
    "user": "postgres",
    "password": "nvv6656"
}


def get_filename(filename):
    """ Returns the correct file name with path. """
    return os.path.join(os.path.dirname(__file__), 'north_data', filename)


def load_table_from_csv(filename, table_name, connect):
    """ Saves data from a file to a database table. """

    # read csv file
    with open(get_filename(filename), newline='') as csvfile:
        csv_reader = csv.reader(csvfile, delimiter=',', quotechar='"')
        data = []
        for row in csv_reader:
            if csv_reader.line_num == 1:
                # its number of columns
                fields = ','.join('%s' for r in row)
            else:
                data.append(row)

    # save to table
    with connect.cursor() as cursor:
        for row in data:
            cursor.execute(f"INSERT INTO {table_name} VALUES ({fields})", row)
        connect.commit()


def main():
    """ Initialize the connection to the database and send data to the tables. """

    pg_conn = psycopg2.connect(**conn_params)
    load_table_from_csv("customers_data.csv", "customers", pg_conn)
    load_table_from_csv("employees_data.csv", "employees", pg_conn)
    load_table_from_csv("orders_data.csv", "orders", pg_conn)


if __name__ == "__main__":
    main()
