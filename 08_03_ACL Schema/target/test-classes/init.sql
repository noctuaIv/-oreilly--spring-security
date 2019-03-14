   	drop table APPOINTMENT if exists;
    drop table AUTO_USER if exists;
    drop table SERVICES if exists;

    create table APPOINTMENT (
        APPOINTMENT_ID bigint generated by default as identity,
        APPOINTMENT_DT timestamp,
        MAKE varchar(255),
        MODEL varchar(255),
        YEAR smallint,
        USER_ID bigint,
        STATUS varchar(255),
        primary key (APPOINTMENT_ID)
    );

    create table AUTO_USER (
        autoUserId bigint generated by default as identity,
        EMAIL varchar(255),
        FIRST_NAME varchar(255),
        LAST_NAME varchar(255),
        PASSWORD varchar(255),
        USERNAME varchar(255),
        ROLE varchar(255),
        primary key (autoUserId)
    );

    create table SERVICES (
        APPOINTMENT_ID bigint not null,
        NAME varchar(255)
    );

    alter table APPOINTMENT 
        add constraint FK_hjr0wl1nbp09iulymmarqjj08 
        foreign key (USER_ID) 
        references AUTO_USER;

    alter table SERVICES 
        add constraint FK_e1e9lupq7o7mwsgtbkwd6uivn 
        foreign key (APPOINTMENT_ID) 
        references APPOINTMENT;
        
create table acl_sid(
	id bigint generated by default as identity(start with 100) not null primary key,
	principal boolean not null,
	sid varchar_ignorecase(100) not null,
	constraint unique_uk_1 unique(sid,principal)
);

create table acl_class(
	id bigint generated by default as identity(start with 100) not null primary key,
	class varchar_ignorecase(100) not null,
	constraint unique_uk_2 unique(class)
);

create table acl_object_identity(
	id bigint generated by default as identity(start with 100) not null primary key,
	object_id_class bigint not null,
	object_id_identity bigint not null,
	parent_object bigint,
	owner_sid bigint,
	entries_inheriting boolean not null,
	constraint unique_uk_3 unique(object_id_class,object_id_identity),
	constraint foreign_fk_1 foreign key(parent_object)references acl_object_identity(id),
	constraint foreign_fk_2 foreign key(object_id_class)references acl_class(id),
	constraint foreign_fk_3 foreign key(owner_sid)references acl_sid(id)
);

create table acl_entry(
	id bigint generated by default as identity(start with 100) not null primary key,
	acl_object_identity bigint not null,
	ace_order int not null,
	sid bigint not null,
	mask integer not null,
	granting boolean not null,
	audit_success boolean not null,
	audit_failure boolean not null,
	constraint unique_uk_4 unique(acl_object_identity,ace_order),
	constraint foreign_fk_4 foreign key(acl_object_identity) references acl_object_identity(id),
	constraint foreign_fk_5 foreign key(sid) references acl_sid(id)
);


insert into AUTO_USER (autoUserId, EMAIL, FIRST_NAME, LAST_NAME, PASSWORD, USERNAME, ROLE) values (null, 'kevin.m.bowersox@gmail.com', 'Kevin', 'Bowersox', 'password', 'kbowersox', 'ROLE_ADMIN');
insert into AUTO_USER (autoUserId, EMAIL, FIRST_NAME, LAST_NAME, PASSWORD, USERNAME, ROLE) values (null, 'johndoe@gmail.com', 'John', 'Doe', 'password', 'jodoe', 'ROLE_USER');
insert into AUTO_USER (autoUserId, EMAIL, FIRST_NAME, LAST_NAME, PASSWORD, USERNAME, ROLE) values (null, 'janedoe@gmail.com', 'Jane', 'Doe', 'password', 'jadoe', 'ROLE_USER');
insert into AUTO_USER (autoUserId, EMAIL, FIRST_NAME, LAST_NAME, PASSWORD, USERNAME, ROLE) values (null, 'juniordoe@gmail.com', 'Junior', 'Doe', 'password', 'jrdoe', 'ROLE_USER');

insert into APPOINTMENT (APPOINTMENT_ID, APPOINTMENT_DT, MAKE, MODEL, YEAR, USER_ID, STATUS) values (1,'2015-08-12 00:00:00', 'Subaru', 'Impreza', '2015', 1, 'Initial');
insert into APPOINTMENT (APPOINTMENT_ID, APPOINTMENT_DT, MAKE, MODEL, YEAR, USER_ID, STATUS) values (2,'2015-08-12 00:00:00', 'Subaru', 'Legacy', '2015', 2, 'Initial');

insert into SERVICES (APPOINTMENT_ID, NAME)  values (1, 'Oil Change');
insert into SERVICES (APPOINTMENT_ID, NAME)  values (1, 'Tire Change');
insert into SERVICES (APPOINTMENT_ID, NAME)  values (2, 'Antifreeze Change');
insert into SERVICES (APPOINTMENT_ID, NAME)  values (2, 'Bulb Change');

	
	
	
	
	

























