Create Table Product_List(
  id int primary key not null,
  name varchar(30) not null,
  description text,
  quantity decimal not null,
  price money not null
);
/*
Product_List is the standard inventory list without sale prices, just the regular prices. Quantity is in decimal so that it can be both a measure of
weight or number of items. For Product_list, quantity should always be 1.00 for 1.00 lb or 1.00 item. Price is a money type because There shouldn't be
any fractional money. Id will be the unique id each product will have. This will be the primary key across all tables to easily get all information
about a certain product. Use description to describe the product.
*/

Create Table Loose_Sale(
  id int primary key not null,
  name varchar(30) not null,
  description text,
  quantity decimal not null,
  new_price money not null
);  
/*
Loose_Sale table is used when the sale price is not dependent on a strict quantity amount. Ex. If candy is on sale for $2.00 for 1 lb and a customer buys
0.5 lb of candy, the price for the candy will be 0.5 * $2.00 = $1.00. Use description to describe the sale, "1 lb for $1".
*/

Create Table Exact_Sale(
  id int primary key not null,
  name varchar(30) not null,
  description text,
  quantity decimal not null,
  new_price money not null
);  
/*
Exact_Sale table is used for strict quantity affecting the sale price. Ex. "Buy 2 get 1 Free" will be description, 3 will be quantity and new_price will
be 2 * product_list.price. This way when ever someone buys 3, they should only be charged for 2. If a customer buys 2, the cashier will be able to inform
the customer about the sale because of the description. Will work for "3 for $1" type deals as well. The customer will be charge for as much of the 
quantity can satisfy the sale requirement. Ex. If an item is only sale for 3 for $1 and a customer buys 5, they will be charged for 
$1 + 2 * product_list.price.
*/

Create Table Receipt(
  id int primary key not null,
  name varchar(30) not null,
  quantity decimal not null,
  price money not null,
  discount money not null
);
/*
This table will be the receipt given to the customer. It will list the items' id, name, quantity bought and at what price and the discount if applicable.
Discount can be found by getting the original price and subtracting from it the sale price.
*/

Create Table Product_History(
  id int primary key not null,
  name varchar(30) not null,
  description text,
  quantity[] decimal not null,
  price money[] not null,
  history date[] not null
);
/*
This will be the record log of sale prices for the company. It lists the item id, name, description, quantity, price, and history(dates price changed).
The quantity, price, and history are arrays and should always have the same number of elements to get corresponding data. Whenever there's a sale, there 
should be the sale quantity, sale price, and date the sale started added to each array. Then when the sale is over, add the original quantity and price and the date.
*/
   