show tables;
drop table address ;
show tables;

-- 테이블 생성
create table person(
	idx int primary key auto_increment,
	name varchar(20) not null,
	age int default 0,
	gender char(1) not null check (gender in ('F', 'M'))
);

show tables;
select * from person;
insert into person (name, gender) values ('한사람','M');
insert into person (name, gender) values ('두사람','F');
insert into person (name, gender) values ('세사람','A'); -- 에러 체크 제약 걸림
select * from person;

insert into person values (0,'네사람',34,'F');
commit;

