import pymysql
import psycopg2
from pymongo import MongoClient, errors
from apscheduler.schedulers.background import BlockingScheduler

def integration():
    # Connect to the database
    connection = pymysql.connect(host='mutualfund_db',
                                user='root',
                                password='example',
                                database='mutualfund_product',
                                cursorclass=pymysql.cursors.DictCursor) #cursor exec query 

    #open connect - cursor exec to query

    client_employee = MongoClient("mutualfund_employee_mongo", 
                                    27017,
                                    username='aplikasi',
                                    password='aplikasi1234',
                                    authSource='mutualfund_employee', 
                                    authMechanism='SCRAM-SHA-1' )

    mutualfund_employee = client_employee["mutualfund_employee"] 


    connectionpgsql = psycopg2.connect(user='postgres',
                                    password='example',
                                    host='mutualfundclient_db',
                                    port=5432,
                                    database='mutualfund_client')

    with connection:
    #    with connection.cursor() as cursor:
            # Create a new record
    #       sql = "INSERT INTO `users` (`email`, `password`) VALUES (%s, %s)"
    #       cursor.execute(sql, ('webmaster@python.org', 'very-secret'))

        # connection is not autocommit by default. So you must commit to save
        # your changes.
    #  connection.commit()
        
        with connection.cursor() as cursor: 
            # Read a single record
            sql = "SELECT category_id, category_name, description, picture from categories"
            cursor.execute(sql)
            result = cursor.fetchall() 
            #print(result)
            with connectionpgsql.cursor() as cursor:
                truncate_query = """truncate table stg_categories"""
                cursor.execute(truncate_query)
            
            for rec in result:
                # print (rec)
                # category_id = rec['category_id']
                # category_name = rec['category_name']
                # description = rec['description']
                # picture = rec['picture']
                # print(category_id, category_name, description, picture) 
                insert_query = """INSERT INTO stg_categories (category_id, category_name, description, picture) VALUES(%s, %s, %s, %s)"""  
                with connectionpgsql.cursor() as cursor:
                    record_to_insert = (rec['category_id'],rec['category_name'],rec['description'],rec['picture']) 
                    cursor.execute(insert_query, record_to_insert)
                    connectionpgsql.commit()

        with connection.cursor() as cursor:
            # Read a single record
            sql = "SELECT * from products"
            cursor.execute(sql)
            result = cursor.fetchall()
            #print(result)
            with connectionpgsql.cursor() as cursor:
                truncate_query = """truncate table stg_products"""
                cursor.execute(truncate_query)
            for rec in result:
                #print (rec)
                insert_query = """INSERT INTO stg_products (product_id, product_name, supplier_id, category_id, quantity_per_unit, unit_price, units_in_stock, units_on_order, reorder_level, discontinued)
                VALUES(%s, %s, %s, %s, %s, %s, %s, %s, %s, %s)"""
                with connectionpgsql.cursor() as cursor:
                    record_to_insert = (rec['product_id'],rec['product_name'],rec['supplier_id'],rec['category_id'],rec['quantity_per_unit'],rec['unit_price'], rec['units_in_stock'], rec['units_on_order'], rec['reorder_level'], rec['discontinued'])
                    cursor.execute(insert_query, record_to_insert)
                    connectionpgsql.commit()
        
        with connection.cursor() as cursor:
            # Read a single record
            sql = "SELECT  supplier_id, company_name, contact_name, contact_title, address, city, postal_code, country, phone, fax, homepage from suppliers"
            cursor.execute(sql)
            result = cursor.fetchall()
            #print(result)
            with connectionpgsql.cursor() as cursor:
                truncate_query = """truncate table stg_suppliers"""
                cursor.execute(truncate_query)
            for rec in result:
                #print (rec)
                insert_query = """INSERT INTO stg_suppliers (supplier_id, company_name, contact_name, contact_title, address, city, postal_code, country, phone, fax, homepage) VALUES(%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)"""
                with connectionpgsql.cursor() as cursor:
                    record_to_insert = (rec['supplier_id'],rec['company_name'],rec['contact_name'],rec['contact_title'],rec['address'],rec['city'], rec['postal_code'], rec['country'], rec['phone'], rec['fax'], rec['homepage'])
                    cursor.execute(insert_query, record_to_insert)
                    connectionpgsql.commit()
        
        collection_region = mutualfund_employee["region"] 
        cursor_region = collection_region.find({})    
        collection_territories = mutualfund_employee["territories"] 
        cursor_territories = collection_territories.find({}) 
        collection_employees = mutualfund_employee["employees"] 
        cursor_employees = collection_employees.find({}) 
        collection_employee_territories = mutualfund_employee["employees_territories"] 
        cursor_employees_territories = collection_employee_territories.find({}) 


        with connectionpgsql.cursor() as cursor:
            truncate_query = """truncate table stg_region"""
            cursor.execute(truncate_query)
        for region in cursor_region:
            insert_query = """INSERT INTO stg_region (region_id, region_description)
                                values (%s,%s)"""
            #print (region['_id'])

            with connectionpgsql.cursor() as cursor:
                record_to_insert = (region['region_id'], region['region_description'])
                cursor.execute(insert_query, record_to_insert)
                connectionpgsql.commit()
            
        with connectionpgsql.cursor() as cursor:
            truncate_query = """truncate table stg_territories"""
            cursor.execute(truncate_query)

        for territories in cursor_territories:
            insert_query = """INSERT INTO stg_territories
                            (territory_id, territory_description, region_id) VALUES (%s,%s,%s)"""
            #print (territories['_id'])

            with connectionpgsql.cursor() as cursor:
                record_to_insert = (territories['territory_id'], territories['territory_description'], territories['region_id'])
                cursor.execute(insert_query, record_to_insert)
                connectionpgsql.commit()

        with connectionpgsql.cursor() as cursor:
            truncate_query = """truncate table stg_employees"""
            cursor.execute(truncate_query)

        for employees in cursor_employees:
            insert_query = """INSERT INTO stg_employees
                            (employee_id, last_name, first_name, title, title_of_courtesy, birth_date, hire_date, address, city, region, postal_code, country, home_phone, "extension", photo, notes, reports_to, photo_path)
                            VALUES(%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)"""
            #print (employees['_id'])
            
            with connectionpgsql.cursor() as cursor:
                record_to_insert = (employees['employee_id'], employees['last_name'], employees['first_name'], employees['title'], employees['title_of_courtesy'], employees['birth_date'],
                employees['hire_date'], employees['address'],employees['city'], employees['region'], employees['postal_code'], employees['country'], employees['home_phone'], employees['extension'], 
                employees['photo'], employees['notes'], employees['reports_to'],employees['photo_path'])
                cursor.execute(insert_query, record_to_insert)
                connectionpgsql.commit()
        

        with connectionpgsql.cursor() as cursor:
            truncate_query = """truncate table stg_employee_territories"""
            cursor.execute(truncate_query)


        for employees_territories in cursor_employees_territories:
            insert_query = """INSERT INTO stg_employee_territories (employee_id, territory_id)
                            VALUES(%s,%s)"""
            #print (employees_territories['_id'])

            with connectionpgsql.cursor() as cursor:
                record_to_insert = (employees_territories['employee_id'],employees_territories['territory_id'])
                cursor.execute(insert_query, record_to_insert)
                connectionpgsql.commit()

scheduler = BlockingScheduler()
scheduler.add_job(integration,trigger='cron', minute='*/1', timezone='Asia/Jakarta')
scheduler.start()
