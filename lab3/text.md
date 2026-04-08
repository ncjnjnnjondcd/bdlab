## я переробив ER таблицю та sql код, щоб вони були більш складні, вони находяться в файлі [remadelab1_2](remadelab1_2)

1 показати всі данні про продажі

```sql
select * from sales;
```
![all sales](1.png)

2 показати всі данні про продажі де загальна кількість більше 3000
```sql
select * from sales
where total_amount > 3000
```
![all sales >3000](2.png)

3 показати неповторний час транзакцій в данних про продаж

```sql
select distinct sale_date from sales

```
![](3.png)

4 показати всі данні про постачальників
```sql
select distinct * from sales
```
![](4.png)

5 додати 2 нових постальчальників 
```sql

insert into suppliers (company_name, phone) 
values('макдональдс','+380445550088');
select * from suppliers;
```
![](5.png)

6 оновити постачальника 'макдональдс' на 'кфс'
```sql
update suppliers 
set company_name = 'кфс',phone ='+380445999999'
where company_name ='макдональдс';
select * from suppliers;
```
![](6.png)

7 замінити постачальників номера яких більше 5
```sql
select * from suppliers;
update suppliers 
set company_name = 'фора'
where id_suppliers >5;
```
![](7.png)

8 видалити постачальників 'кфс' або номер яких більше або рівно 6

```sql
delete from suppliers 
where company_name ='кфс' or id_supplier >6;
select * from suppliers;
```
![](8.png)


