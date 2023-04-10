drop database elet;

create database elet;

use elet;

create table tbl_users (
	id_user int not null auto_increment primary key,
    user_name varchar(50) not null unique,
    user_pwd varchar(100) not null,
    is_admin int not null,
    user_creation_date timestamp default current_timestamp
);

create table tbl_cases (
	id_case int not null auto_increment primary key,
    case_name varchar(200) not null,
    case_desc text not null,
    usr_id int not null,
    case_area varchar(25) not null default "Soporte",
    case_status varchar(25) not null default "Abierto",
    case_creation_date timestamp default current_timestamp,
    case_last_update_date timestamp on update current_timestamp,
    case_solution text,
    foreign key (usr_id) references tbl_users(id_user)
);

create table tbl_case_admin (
	id_case_admin int not null auto_increment primary key,
    case_id int not null unique,
    admin_id int not null,
    case_admin_creation_date timestamp default current_timestamp,
    foreign key (case_id) references tbl_cases(id_case),
    foreign key (admin_id) references tbl_users(id_user)
);

create table tbl_admin_rol (
	id_admin_rol int not null auto_increment primary key,
    admin_id int not null unique,
    rol ENUM('Ingeniero', 'Editor', 'Asistente', 'Gerente','IngenieroM') 
    );

create table tbl_faq(
	id_faq int not null auto_increment primary key,
    name_faq text not null,
    question_faq text not null,
    answer_faq text not null,
    faq_creation_date timestamp default current_timestamp
);
drop table tbl_faq;
insert into tbl_faq (admin_id,question_faq,answer_faq) values (1, "Question1","Answer1");

insert into tbl_admin_rol (admin_id, rol) values (1, "Gerente");
insert into tbl_admin_rol (admin_id, rol) values (4, "Ingeniero");
insert into tbl_admin_rol (admin_id, rol) values (2, "Editor");
insert into tbl_admin_rol (admin_id, rol) values (3, "Asistente");
insert into tbl_admin_rol (admin_id, rol) values (5, "IngenieroM");

SELECT case_area,case_solution,case_creation_date,case_desc from tbl_case_admin
INNER JOIN tbl_users ON tbl_case_admin.admin_id = tbl_users.id_user
INNER JOIN tbl_cases ON tbl_case_admin.case_id = tbl_cases.id_case 
WHERE case_status = "Cerrado";

SELECT user_name FROM tbl_users
INNER JOIN tbl_admin_rol ON tbl_users.id_user = tbl_admin_rol.admin_id
WHERE tbl_admin_rol.rol = 'Ingeniero';

select * from tbl_faq;
select * from tbl_users;
SELECT c.id_case, c.case_name, u.user_name as user_username,c.case_area, u2.user_name as admin_username, c.case_status, c.case_creation_date, c.case_last_update_date FROM tbl_cases c INNER JOIN tbl_users u ON c.usr_id = u.id_user LEFT JOIN tbl_case_admin ca ON c.id_case = ca.case_id LEFT JOIN tbl_users u2 ON ca.admin_id = u2.id_user  where case_status='En mantenimiento' order by c.id_case;

-- Crear un nuevo reporte
insert into tbl_users (user_name, user_pwd, is_admin) values ("g_soporte", "g_soporte", 1);
insert into tbl_users (user_name, user_pwd, is_admin) values ("g_mto", "g_mto", 1);
insert into tbl_users (user_name, user_pwd, is_admin) values ("asis", "asis", 1);
insert into tbl_users (user_name, user_pwd, is_admin) values ("ing_soporte", "ing_soporte", 1);
insert into tbl_users (user_name, user_pwd, is_admin) values ("ing_mto", "ing_mto", 0);
insert into tbl_users (user_name, user_pwd, is_admin) values ("editor", "editor", 0);
insert into tbl_users (user_name, user_pwd, is_admin) values ("rodri", "rodri", 0);
insert into tbl_users (user_name, user_pwd, is_admin) values ("valencia", "valencia", 0);
insert into tbl_users (user_name, user_pwd, is_admin) values ("aranzuki", "aranzuki", 0);

insert into tbl_admin_rol (admin_id, rol) values (1, "Gerente");
insert into tbl_admin_rol (admin_id, rol) values (2, "Gerente");
insert into tbl_admin_rol (admin_id, rol) values (7, "Gerente");
insert into tbl_admin_rol (admin_id, rol) values (3, "Asistente");
insert into tbl_admin_rol (admin_id, rol) values (4, "Ingeniero");
insert into tbl_admin_rol (admin_id, rol) values (5, "IngenieroM");
insert into tbl_admin_rol (admin_id, rol) values (6, "Editor");
SELECT id_case, case_name, case_desc, case_solution FROM tbl_cases WHERE case_status = 'Cerrado' and case_solution is no null;
select * from tbl_cases;


insert into tbl_cases (case_name, case_desc, usr_id, case_solution) values ("Nombre 1", "Descripcion 1", 2, "Solución 1");
insert into tbl_cases (case_name, case_desc, usr_id, case_solution) values ("Nombre 2", "Descripcion 2", 3, "Solución 2");
insert into tbl_cases (case_name, case_desc, usr_id, case_solution) values ("Nombre 3", "Descripcion 3", 4, "Solución 3");

insert into tbl_case_admin (case_id, admin_id) values (1, 1);
insert into tbl_case_admin (case_id, admin_id) values (2, 1);
insert into tbl_case_admin (case_id, admin_id) values (3, 1);

drop table tbl_case;

select * from tbl_case_admin;
select * from tbl_users;
select * from tbl_cases;

-- Modificar el estado de un caso con id = 2
update tbl_cases set case_status = "En mantenimiento" where id_case = 1;

-- Modificar el departamento de un caso con id = 2
update tbl_cases set case_area = "Mantenimiento" where id_case = 1;

SELECT id_user,user_name FROM tbl_users INNER JOIN tbl_admin_rol ON tbl_users.id_user = tbl_admin_rol.admin_id WHERE tbl_admin_rol.rol = 'IngenieroM';
-- Eliminar el caso con id = 1
delete from tbl_cases where id = 1;

-- Contar numero de casos cerrados
select count(id) from tbl_cases where estado = "Cerrado";

select * from tbl_cases;

select id, case_name, case_desc from tbl_cases;

SELECT c.id_case, c.case_name, u.user_name as user_username,c.case_area, u2.user_name as admin_username, c.case_status, c.case_creation_date, c.case_last_update_date FROM tbl_cases 
c INNER JOIN tbl_users u ON c.usr_id = u.id_user LEFT JOIN tbl_case_admin ca ON c.id_case = ca.case_id 
LEFT JOIN tbl_users u2 ON ca.admin_id = u2.id_user where case_status='En mantenimiento' and case_area='Mantenimiento' order by c.id_case;

SELECT case_area,case_creation_date,case_desc from tbl_case_admin
INNER JOIN tbl_users ON tbl_case_admin.admin_id = tbl_users.id_user
INNER JOIN tbl_cases ON tbl_case_admin.case_id = tbl_cases.id_case WHERE admin_id=1 AND case_id=1;

INSERT INTO tbl_case_admin (case_id, admin_id) VALUES (4, 5) ON DUPLICATE KEY UPDATE admin_id = 5;
truncate table tbl_cases;

-- Eliminar la tabla 'tbl_cases'
drop table tbl_cases;
drop table tbl_case_admin;