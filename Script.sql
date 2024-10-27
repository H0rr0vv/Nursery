drop database if exists nursery;
create database nursery;
use nursery;


drop table if exists nursery.домашние_животные;
CREATE TABLE nursery.домашние_животные (
    id BIGINT NOT NULL PRIMARY key,
    type varchar(100)
);

drop table if exists nursery.вьючные_животные;
CREATE TABLE nursery.вьючные_животные (
	id BIGINT NOT NULL PRIMARY key,
	type varchar(100)
);

drop table if exists nursery.собаки;
CREATE TABLE nursery.собаки (
    id_animal BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY key,
    name varchar(100),
    command varchar(100) default Null,
    birthday date,
    type_id BIGINT NOT NULL,
    
    foreign key (type_id) references nursery.домашние_животные(id)
);

drop table if exists nursery.кошки;
CREATE TABLE nursery.кошки (
    id_animal BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY key,
    name varchar(100),
    command varchar(100) default Null,
    birthday date,
    type_id BIGINT NOT null,
    
    foreign key (type_id) references nursery.домашние_животные(id)
);

drop table if exists nursery.хомяки;
CREATE TABLE nursery.хомяки (
    id_animal BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY key,
    name varchar(100),
    command varchar(100) default Null,
    birthday date,
    type_id BIGINT NOT null,
    
    foreign key (type_id) references nursery.домашние_животные(id)
);

drop table if exists nursery.ослы;
CREATE TABLE nursery.ослы (
    id_animal BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY key,
    name varchar(100),
    command varchar(100) default Null,
    birthday date,
    type_id BIGINT NOT null,
    
    foreign key (type_id) references nursery.вьючные_животные(id)
);

drop table if exists nursery.лошади;
CREATE TABLE nursery.лошади (
    id_animal BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY key,
    name varchar(100),
    command varchar(100) default Null,
    birthday date,
    type_id BIGINT NOT null,
    
    foreign key (type_id) references nursery.вьючные_животные(id)
);

drop table if exists nursery.верблюды;
CREATE TABLE nursery.верблюды (
    id_animal BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY key,
    name varchar(100),
    command varchar(100) default Null,
    birthday date,
    type_id BIGINT NOT null,
    
    foreign key (type_id) references nursery.вьючные_животные(id)
);

insert into nursery.домашние_животные(id, type)
values 
(1, 'Собаки'),
(2, 'Коты'),
(3, 'Хомяки');

insert into nursery.вьючные_животные(id, type)
values 
(1, 'Ослы'),
(2, 'Лошади'),
(3, 'Верблюды');

insert into nursery.собаки(name, command, birthday, type_id)
values 
('Бадди', 'голос', '2023-05-24', 1),
('Луна', 'сидеть', '2018-08-12', 1),
('Макс', 'голос', '2020-03-02', 1),
('Чарли', 'дай лапу', '2023-12-05', 1),
('Белла', null , '2024-07-06', 1);

insert into nursery.кошки(name, command, birthday, type_id)
values 
('Шурик', null, '2024-09-25', 2),
('Мурка', null, '2024-09-25', 2),
('Снежок', 'ко мне', '2016-01-12', 2),
('Котя', 'дай лапу', '2019-11-29', 2),
('Тишка', null , '2022-01-06', 2);

insert into nursery.хомяки(name, command, birthday, type_id)
values 
('Пухляш', null, '2021-12-30', 3),
('Чип', null, '2024-04-04', 3);

insert into nursery.ослы(name, command, birthday, type_id)
values 
('Кекс', 'Стоять', '2020-02-12', 1),
('Боня', 'Ко мне', '2019-06-12', 1);

insert into nursery.лошади(name, command, birthday, type_id)
values 
('Скакун', 'Галоп', '2021-11-09', 2),
('Ветра', 'Прыжок', '2021-08-25', 2);

insert into nursery.верблюды(name, command, birthday, type_id)
values 
('Бимбо', 'Ко мне', '2021-12-30', 3);

delete from nursery.верблюды;

create table nursery.ослы_и_лошади (
	id_animal BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY key,
    name varchar(100),
    command varchar(100) default Null,
    birthday date,
    type_id BIGINT NOT null
);

insert into nursery.ослы_и_лошади (name, command, birthday, type_id)
select name, command, birthday, type_id from nursery.ослы
union all
select name, command, birthday, type_id from nursery.лошади;

create table nursery.молодые_животные (
	id_animal BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY key,
    name varchar(100),
    command varchar(100) default Null,
    birthday date,
    type_id BIGINT NOT null
);

insert into nursery.молодые_животные (name, command, birthday, type_id)
select name, command, birthday, type_id from nursery.ослы
where datediff(curdate(), birthday) > 365 and datediff(curdate(), birthday) < 1095
union all
select name, command, birthday, type_id from nursery.лошади
where datediff(curdate(), birthday) > 365 and datediff(curdate(), birthday) < 1095
union all
select name, command, birthday, type_id from nursery.верблюды
where datediff(curdate(), birthday) > 365 and datediff(curdate(), birthday) < 1095
union all
select name, command, birthday, type_id from nursery.собаки
where datediff(curdate(), birthday) > 365 and datediff(curdate(), birthday) < 1095
union all
select name, command, birthday, type_id from nursery.кошки
where datediff(curdate(), birthday) > 365 and datediff(curdate(), birthday) < 1095
union all
select name, command, birthday, type_id from nursery.хомяки
where datediff(curdate(), birthday) > 365 and datediff(curdate(), birthday) < 1095;

alter table nursery.молодые_животные 
add age int;

update nursery.молодые_животные
set age = floor(datediff(curdate(), birthday) / 30);
