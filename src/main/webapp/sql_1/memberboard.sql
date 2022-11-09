회원가입테이블
create table member2(
	member_id		varchar2(15),
	member_pw		varchar2(13),
	member_name		varchar2(15),
	member_age		number,
	member_gender	varchar2(6),
	member_email	varchar2(20),
	PRIMARY KEY(member_id)
);

회원명단테이블(게시판)
create table memberboard(
	board_num		number,
	board_id		varchar2(20),
	board_subject	varchar2(50),
	board_content	varchar2(2000),
	board_file		varchar2(50),
	board_re_ref	number,
	board_re_lev	number,
	board_re_seq	number,
	board_readcount	number,
	board_date		date,
	PRIMARY KEY(board_num)
);

두 테이블의 관계설정
alter table memberboard add constraint pk_board_id foreign key(board_id)
references member2(member_id) on delete cascade;

alter table member2 drop column member_email;
alter table member2 add member_email varchar2(20);

drop table memberboard purge;
drop table member2 purge;

delete from member2 where member_id='hong';


select * from member2;
select * from memberboard order by board_num desc;

