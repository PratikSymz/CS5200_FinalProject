
-- users insert

INSERT INTO ecommerce.users (full_name, email, password)
values ('Alex Sid', 's@gmail.com', 'amber');

INSERT INTO ecommerce.users (full_name, email, password)
values ('John', 'j@gmail.com', '1234');

INSERT INTO ecommerce.users (full_name, email, password)
values ('Bruce Wayne', 'bw@gmail.com', 'batman');

INSERT INTO ecommerce.users (full_name, email, password)
values ('Clark Kent', 'ck@gmail.com', 'superman');

-- Address Insert statements 

INSERT INTO ecommerce.address (street_address_1, street_address_2, city, state, zip, user_id)
values ('75 land', 'huntington', 'boston', 'ma', 02115, 1);

INSERT INTO ecommerce.address (street_address_1, street_address_2, city, state, zip, user_id)
values ('huntingon 350', '', 'boston', 'ma', 02115, 2);

INSERT INTO ecommerce.address (street_address_1, street_address_2, city, state, zip, user_id)
values ('clari street', '', 'San Diego', 'CA', 90011, 3);

INSERT INTO ecommerce.address (street_address_1, street_address_2, city, state, zip, user_id)
values ('Luxy aptmt', 'strong st.', 'San Diego', 'CA', 95011, 4);

INSERT INTO ecommerce.address (street_address_1, street_address_2, city, state, zip, user_id)
values ('sea st.', '500', 'Buffalo', 'NY', 30004, 2);

-- insert Suppliers table

INSERT INTO ecommerce.supplier (company_name, contact_first_name, contact_last_name, contact_title)
values ('Z-electronics', 'Alex', 'Scott', 'CEO');

INSERT INTO ecommerce.supplier (company_name, contact_first_name, contact_last_name, contact_title)
values ('Genpa', 'Jeff', 'Gates', 'Manager');

INSERT INTO ecommerce.supplier (company_name, contact_first_name, contact_last_name, contact_title)
values ('xtra shoes and apparel', 'Sid', 'Chakra', 'COO');

-- insert category table

INSERT INTO ecommerce.category (category_name)
values ('electronics');

INSERT INTO ecommerce.category (category_name)
values ('apparel');

INSERT INTO ecommerce.category (category_name)
values ('home');

INSERT INTO ecommerce.category (category_name)
values ('shoes');

INSERT INTO ecommerce.category (category_name)
values ('accessories');


-- insert phone table

INSERT INTO ecommerce.phone (phone_number, is_primary, user_id)
values ('(269)5450900', True, 1);

INSERT INTO ecommerce.phone (phone_number, is_primary, user_id)
values ('6584247300', True, 2);

INSERT INTO ecommerce.phone (phone_number, is_primary, user_id)
values ('(269)542000', false, 2);

INSERT INTO ecommerce.phone (phone_number, is_primary, user_id)
values ('5695009400', false, 3);

INSERT INTO ecommerce.phone (phone_number, is_primary, user_id)
values ('737-813-0400', true, 4);

-- insert product table

INSERT INTO ecommerce.product (name, category_id, supplier_id, price, weight, short_desc, long_desc, image_url)
values ('Galaxy 31 pro', 1, 2, 500, 5.5, "phone from galaxy", "", "");

INSERT INTO ecommerce.product (name, category_id, supplier_id, price, weight, short_desc, long_desc, image_url)
values ('cotton sweater', 2, 2, 45, null, "cable knit pattern", "", "z.com/jpg");

INSERT INTO ecommerce.product (name, category_id, supplier_id, price, weight, short_desc, long_desc, image_url)
values ('usb adapter', 1, 1, 20, null, "type c adapter", "", "electric.com/jpg");

INSERT INTO ecommerce.product (name, category_id, supplier_id, price, weight, short_desc, long_desc, image_url)
values ('sports shoes', 4, 2, 60, null, "running shoes", "perfectly stitched with flexible insole", "");

INSERT INTO ecommerce.product (name, category_id, supplier_id, price, weight, short_desc, long_desc, image_url)
values ('Nike sports shoes', 4, 3, 60, null, "running shoes", "weather resistant and perfect for jogging in any weather", null);

INSERT INTO ecommerce.product (name, category_id, supplier_id, price, weight, short_desc, long_desc, image_url)
values ('Formal shoes', 4, 3, 90, null, "formal shoes", null, null);

INSERT INTO ecommerce.product (name, category_id, supplier_id, price, weight, short_desc, long_desc, image_url)
values ('ear rings gold', 5, 3, 15, 2.3, "jewellary for ears", null, "");

-- insert order table

INSERT INTO ecommerce.orders (order_date, total_price, user_id)
values ('2021-12-15', 30, 1);

INSERT INTO ecommerce.orders (order_date, total_price, user_id)
values ('2022-10-24', 120, 2);

INSERT INTO ecommerce.orders (order_date, total_price, user_id)
values ('2022-11-01', 545, 1);

INSERT INTO ecommerce.orders (order_date, total_price, user_id)
values ('2022-10-24', 120, 4);

-- insert order_product_details table

INSERT INTO ecommerce.order_product_details (order_id, product_id, quantity)
values (1, 7, 2);

INSERT INTO ecommerce.order_product_details (order_id, product_id, quantity)
values (2, 4, 1);

INSERT INTO ecommerce.order_product_details (order_id, product_id, quantity)
values (2, 5, 1);

INSERT INTO ecommerce.order_product_details (order_id, product_id, quantity)
values (3, 1, 1);

INSERT INTO ecommerce.order_product_details (order_id, product_id, quantity)
values (3, 2, 1);

INSERT INTO ecommerce.order_product_details (order_id, product_id, quantity)
values (4, 7, 1);

INSERT INTO ecommerce.order_product_details (order_id, product_id, quantity)
values (4, 2, 1);

INSERT INTO ecommerce.order_product_details (order_id, product_id, quantity)
values (4, 3, 4);