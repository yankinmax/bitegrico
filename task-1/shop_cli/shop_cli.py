#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import sys, os
import psycopg2

from tools import config

customers = [
    ['Max', 20, 'UAH'],
    ['Gleb', 15, 'USD'],
    ['Petya', 10, 'EUR'],
    ['Andrey', 20, 'UAH'],
    ['Vasya', 15, 'GBP'],
    ['Sasha', 10, 'USD'],
    ['Olya', 20, 'UAH'],
    ['Masha', 15, 'GBP'],
    ['Yula', 10, 'EUR'],
]

products = [
    ['Toy', 'Marks and Spencer', 28.99, 29.99, 3.55, 3, 'Max'],
    ['Bear', 'Just Cavalli', 24.99, 25.99, 3.55, 1, 'Max'],
    ['Teddy', 'Dsquared', 24.99, 25.99, 3.55, 2, 'Petya'],
    ['Bud', 'Obolon', 4.99, 4.99, 0.55, 2, 'Gleb'],
    ['Beer', 'Brovarnya', 3.99, 3.99, 0.35, 5, 'Petya'],
    ['Bread', 'Kiyv Hlib', 1.99, 1.99, 8.30, 1, 'Andrey'],
    ['Butter', 'Silpo', 4.99, 4.99, 1.55, 2, 'Sasha'],
    ['Sugar', 'Auchan', 15.99, 16.99, 3.55, 5, 'Vasya'],
    ['Hamburger', 'Mcdonalds', 5.99, 5.99, 0.55, 2, 'Yula'],
    ['Cheeseburger', 'Mcdonalds', 5.99, 5.99, 0.55, 1, 'Vasya'],
    ['Pomefries', 'Mcdonalds', 5.99, 5.99, 0.55, 1, 'Sasha'],
]

def db_connect():
    conn = None
    try:
        params = config()
        conn = psycopg2.connect(**params) 
        return conn
    except (Exception, psycopg2.DatabaseError) as error:
        exc_type, exc_obj, exc_tb = sys.exc_info()
        print(str(error)+'. line:'+str(exc_tb.tb_lineno))
        raise error

class Product:

    def __init__(self, product_name=None, brand=None, cost_price=None, price=None, weight=None):        
        self.product_name = product_name
        self.brand = brand
        self.cost_price = float(cost_price)
        self.price = float(price)
        self.weight = float(weight)

class Customer:

    def __init__(self, customer_name, discount, currency):        
        self.customer_name = customer_name
        self.discount = int(discount)
        self.currency = currency

    def set_customer_info(self):
        conn = db_connect()
        cursor = conn.cursor()
        cursor.callproc('external."spAppInsertStagingCustomer"',(self.customer_name,
                                                                self.discount,
                                                                self.currency          
                                                                ))
        conn.commit()
        cursor.close()
        conn.close()

class Buy(Product):

    def __init__(self, product_name, brand, cost_price, price, weight, quantity=None, customer_name=None):
        super().__init__(product_name, brand, cost_price, price, weight)        
        self.quantity = int(quantity)
        self.customer_name = customer_name

    def set_product_info(self):
        conn = db_connect()
        cursor = conn.cursor()
        cursor.callproc('external."spAppInsertStagingProduct"',(self.product_name,
                                                                self.brand,
                                                                self.cost_price,
                                                                self.price,
                                                                self.weight          
                                                                ))
        conn.commit()
        cursor.close()
        conn.close()           

    def buy_product(self):
        conn = db_connect()
        cursor = conn.cursor()
        cursor.callproc('external."spAppBuyProduct"',(self.product_name, self.customer_name, self.quantity))
        conn.commit()
        cursor.close()
        conn.close()

class Check(Buy):

    def __init__(self):
        return

    def get_sales_info(self, product_name):
        conn = db_connect()
        cursor = conn.cursor()
        cursor.callproc('external."spAppGetSalesInfo"',(product_name,))
        result = cursor.fetchall()
        products = []
        product = {}
        for record in result:
            print('{} has brought {} by {} for {} {} in quantity of {}! Total price is {}!'.format(record[6],\
                record[0], record[1], record[2], record[7], record[4], record[5]))
        conn.commit()                
        cursor.close()
        conn.close()

if __name__ == "__main__":
    '''Register customers'''
    for i in customers:
        customer_name = i[0]
        discount = i[1]
        currency = i[2]
        customer = Customer(customer_name, discount, currency)
        customer.set_customer_info()

    '''Register and buy products'''
    for i in products:
        product_name = i[0] 
        brand = i[1] 
        cost_price = i[2] 
        price = i[3] 
        weight = i[4]  
        quantity = i[5] 
        customer_name = i[6]
        product = Buy(product_name, brand, cost_price, price, weight, quantity, customer_name)
        product.set_product_info()
        product.buy_product()
   
    '''Check sales'''
    check_shop = Check()
    check_shop.get_sales_info('Toy')
    check_shop.get_sales_info('Bear')
    check_shop.get_sales_info('Teddy')
    check_shop.get_sales_info('Bud')
    check_shop.get_sales_info('Beer')
    check_shop.get_sales_info('Bread')
    check_shop.get_sales_info('Hamburger')
    check_shop.get_sales_info('Sugar')

