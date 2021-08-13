show user;

select * from tab;

select * from tbl_member;

desc tbl_member;

memberno, pwd, name, mobile, email, birth, jubun, engname, chinaname, grade, enterday, graduateday, absencecnt, , fk_regseq, fk_deptseq, address, detailaddress, extraaddress, img, graduateok, currentsemester

select count(*)
from tbl_member
where memberno='108' and pwd='245976f7bf72702514cd146d10f8b342d7ef30045822fa2c411f62f29e133326';


SELECT * FROM USER_SEQUENCES;


-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------증명서종류테이블

create table tbl_certificateKind(
certificateKindSeq           number               not null         -- 증명서 구분 번호 (프라이머리키)
,certificateName     varchar2(50)         not null                -- 증명서 이름
,charge        number default 0  not null                           -- 증명서 종류별 수수료
,lang number(1) default 0 not null                                   -- 국문/영문 유무 
                                                                                              --국문만 가능하면 0, 국문/영문 둘 다 가능하면 1
,constraint PK_tbl_certificateKind_seq primary key(certificateKindSeq)
,constraint CK_tbl_certificateKind_lang check( lang in(1,0) )
);

create sequence certificateKindSeq
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------증명서테이블

create table tbl_certificate (
certificateSeq                  number                                         not null                    -- 증명서 번호 pirmary키
,fk_certificateKindSeq      number                                        not null                    -- 증명서 종류 번호
,fk_memberNo                  number                                         not null                    -- 신청자 : 학번
,applicationDate                date                default sysdate   not null                      -- 신청일자
,count                                number                                         not null                     -- 발급부수
,grantDate                          date                                                                                  --  승인일자
,grantStatus                       number          default 0                                                 -- 0 신청, 1 승인, 2 반려, 3보류
,returnreason                     varchar2(200)                                                                 -- 반려사유
,lang                              number(1)                                      not null                   -- 국문/영문 구분 0이면 국문 / 1이면 영문
,recieveWay                 number(1)                                       not null                    -- 수령방법 0:직접수령 1:등기수령
,constraint PK_tbl_certificate_seq primary key(certificateSeq)
,constraint FK_tbl_certificate_kindSeq foreign key(fk_certificateKindSeq) references tbl_certificateKind(certificateKindSeq)
,constraint FK_tbl_certificate_memberNo foreign key(fk_memberNo) references tbl_member(memberno)
,constraint CK_tbl_certificate_lang check( lang in(1,0) )
,constraint CK_tbl_certificate_recieveWay check( recieveWay in(1,0) )
,constraint CK_tbl_certificate_grantStatus check( grantStatus in(0,1,2,3) )
);

delete tbl_certificate;
drop table tbl_certificate purge;

drop sequence certificateSeq;
-- 증명서 테이블 시퀀스 생성
create sequence certificateSeq
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------공지테이블

-- 학과 공지사항 테이블 생성
create table tbl_hsNotice
(
noticeNo                 number          not null                   -- 공지번호
,fk_deptSeq           number                                           -- 학과번호
,fk_subjectNo         varchar2(20)                                    -- 과목번호
--,fk_adminNo                number          not null              -- 공지글 작성한 관리자번호
,subject                   varchar2(500)  not null                -- 공지제목
,contents               varchar2(2000)   not null             -- 공지내용
,writeDay                date            default sysdate            -- 게시일자
,readCount             number default 0      not null       -- 글조회수
,fileName               varchar2(255)                                -- WAS(톰캣)에 저장될 파일명(20200725092715353243254235235234.png)
,orgFilename        varchar2(255)                                -- 진짜 파일명(강아지.png)  // 사용자가 파일을 업로드 하거나 파일을 다운로드 할때 사용되어지는 파일명
,fileSize                  number                                           -- 파일크기
,status                   number(1)        not null                   -- 0 이면 전체공지, 1이면 학과공지, 2면 과목공지
,constraint PK_tbl_hsNotice_noticeNo primary key(noticeNo)
,constraint FK_tbl_hsNotice_deptSeq foreign key(fk_deptSeq)  references tbl_dept(deptSeq)
,constraint FK_tbl_hsNotice_subjectNo foreign key(fk_subjectNo)  references tbl_subject(subjectNo)
--,constraint FK_tbl_deptNotice_adminNo foreign key(fk_adminNo)  references tbl_admin(adminNo)
);


-- 학과 공지사항 테이블 시퀀스 생성
create sequence hsNoticeSeq
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------학생테이블
-- 학생 테이블 생성
create table tbl_member
(memberNo            number                 not null   -- 학번
,pwd                 VARCHAR2(200)          not null   -- 비밀번호
,name                varchar2(20)           not null   -- 성명
,mobile              VARCHAR2(200)          not null   -- 연락처
,email               varchar2(200)          not null   -- 이메일
,birth               varchar2(20)                      -- 생년월일
,jubun               varchar2(200)          not null   -- 주민번호
,engName             varchar2(30)                      -- 영문성명
,chinaName           varchar2(30)                      -- 한자성명
,img                 VARCHAR2(200)                     -- 사진
,grade               number(5)                         -- 학년
,totalSemester       number(5)                         -- 현재이수학기
,enterDay            DATE default sysdate              -- 입학날짜
,graduateDay         DATE                              -- 졸업날짜
,postcode            varchar2(5)                       -- 우편번호
,address             varchar2(200)                     -- 주소
,detailaddress       VARCHAR2(50)                      -- 상세주소
,extraaddress        VARCHAR2(50)                      -- 참고주소
,absenceCnt          number(2) default 0               -- 휴학횟수
,graduateok          number(2) default 0               -- 졸업가능여부
,fk_regSeq           number              not null      -- 학적번호
,fk_deptSeq          number              not null      -- 학과번호
,constraint PK_tbl_member_memberNo primary key(memberNo)
,constraint FK_tbl_member_regSeq foreign key(fk_regSeq)  references tbl_school_reg(regSeq)
,constraint FK_tbl_membert_deptSeq foreign key(fk_deptSeq)  references tbl_dept(deptSeq) 
);

alter table tbl_member
add (totalSemester       number(5));

desc tbl_member

-- 학생 테이블 시퀀스 생성
create sequence tbl_member_seq
start with 100
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

select * from tbl_member;

update tbl_member set pwd='9695b88a59a1610320897fa84cb7e144cc51f2984520efb77111d94b402a8382';

commit;


-------------------------------------------------------------------------------------------일정테이블-------------------------------------------------------------------------------------------------------------------------------------

drop table tbl_schedule purge;
drop sequence scheduleSeq;
select * from tbl_schedule;
delete from tbl_schedule;

create table tbl_schedule
(
scheduleNo                 number          not null              -- 일정번호
,fk_deptSeq           number                                           -- 학과번호
,fk_subjectNo         varchar2(20)                                    -- 과목번호
,subject                   varchar2(500)  not null                -- 일정이름
,contents               varchar2(2000)                               -- 일정내용
,startDate                varchar2(200)                       not null            -- 일정 시작일자
,endDate                 varchar2(200)                       not null            -- 일정 종료일자
,status                   number(1)        not null                   -- 0 이면 전체일정, 1이면 학과일정, 2면 과목일정
,constraint PK_tbl_schedule_scheduleNo primary key(scheduleNo)
,constraint FK_tbl_schedule_deptSeq foreign key(fk_deptSeq)  references tbl_dept(deptSeq)
,constraint FK_tbl_schedule_subjectNo foreign key(fk_subjectNo)  references tbl_subject(subjectNo)
);

create sequence scheduleSeq
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

commit;

insert into tbl_schedule(scheduleNo, subject, contents, startDate, endDate, status) 
values(scheduleSeq.nextval, '신정', '신정', '2021-01-01T00:00:00.000Z', '2021-01-01T24:00:00.000Z', 0);

insert into tbl_schedule(scheduleNo, subject, contents, startDate, endDate, status) 
values(scheduleSeq.nextval, '복학/휴학신청기간', '복학/휴학신청기간', '2021-01-12T00:00:00.000Z', '2021-01-14T24:00:00.000Z', 0);
insert into tbl_schedule(scheduleNo, subject, contents, startDate, endDate, status) 
values(scheduleSeq.nextval, '예비수강신청기간(재학/복학)', '예비수강신청기간(재학/복학)', '2021-01-19T00:00:00.000Z', '2021-01-21T24:00:00.000Z', 0);
insert into tbl_schedule(scheduleNo, subject, contents, startDate, endDate, status) 
values(scheduleSeq.nextval, '수강신청기간(재학/복학)', '수강신청기간(재학/복학)', '2021-01-26T00:00:00.000Z', '2021-01-29T24:00:00.000Z', 0);

commit;

select scheduleNo, subject, contents, startDate, endDate, status
from tbl_schedule
where status = 0

insert into tbl_schedule(scheduleNo, subject, contents, startDate, endDate, status) 
values(scheduleSeq.nextval, '신정', '신정', '2021-01-01T00:00:00.000Z', '2021-01-01T24:00:00.000Z', 0);
insert into tbl_schedule(scheduleNo, subject, contents, startDate, endDate, status) 
values(scheduleSeq.nextval, '신정', '신정', '2021-01-01T00:00:00.000Z', '2021-01-01T24:00:00.000Z', 0);
insert into tbl_schedule(scheduleNo, subject, contents, startDate, endDate, status) 
values(scheduleSeq.nextval, '신정', '신정', '2021-01-01T00:00:00.000Z', '2021-01-01T24:00:00.000Z', 0);
insert into tbl_schedule(scheduleNo, subject, contents, startDate, endDate, status) 
values(scheduleSeq.nextval, '신정', '신정', '2021-01-01T00:00:00.000Z', '2021-01-01T24:00:00.000Z', 0);
insert into tbl_schedule(scheduleNo, subject, contents, startDate, endDate, status) 
values(scheduleSeq.nextval, '신정', '신정', '2021-01-01T00:00:00.000Z', '2021-01-01T24:00:00.000Z', 0);
insert into tbl_schedule(scheduleNo, subject, contents, startDate, endDate, status) 
values(scheduleSeq.nextval, '신정', '신정', '2021-01-01T00:00:00.000Z', '2021-01-01T24:00:00.000Z', 0);
insert into tbl_schedule(scheduleNo, subject, contents, startDate, endDate, status) 
values(scheduleSeq.nextval, '신정', '신정', '2021-01-01T00:00:00.000Z', '2021-01-01T24:00:00.000Z', 0);
-------------------------------------------------------------------------------------------학기별성적테이블-------------------------------------------------------------------------------------------------------------------------------------

create table tbl_courseKind (
    
)

show recyclebin;
purge recyclebin;

commit;

select * from tbl_member where memberno = '108';

update tbl_member set engname='PARK JIHYUN' , chinaname='朴知賢' , grade=1 , postcode='03373' , address='서오릉로 15길 5' , detailaddress ='502호' ,img='parkjihyun.jpg'
where memberno = '108';

select * from tbl_dept
select * from tbl_school_reg;
desc tbl_member;

select 
name, memberno, 
memberNo, pwd, name,deptName, r.status, mobile, email, birth, jubun, engName, chinaName, img, grade, totalSemester , enterDay, graduateDay, postcode, address, detailaddress, extraaddress, absenceCnt, graduateok 

from tbl_member M JOIN tbl_dept D
 on  M.fk_deptSeq = D.deptSeq
 join tbl_school_reg R
 on m.fk_regseq = r.regseq
 where memberNo = '108'
 
   -- func_gender(jubun)만들기2
    create or replace function func_gender_2
        (p_jubun in varchar2) 
        return varchar2
    is 
        v_gender varchar2(6);
    begin
        select case when substr(p_jubun,7,1) in('2','4') then '여' else '남' end  -- select된 결과물을 변수에 담아줘야함
        into v_gender -- select된 결과물을 변수에 담는 키워드 : into
        from dual;              
        
        return v_gender;
    end func_gender_2;
    --Function FUNC_GENDER_2이(가) 컴파일되었습니다.
    
       select func_gender_2('9710202234567')
    from dual;
 
        select func_gender_2(jubun)
    from tbl_member;
 
  with V as (
       select case when substr(jubun,7,1)in('1','3') then '남' else '여' end as gender
       from employees
      )

       select decode(grouping(gender),0,gender,'전체') as 성별
            , count(*) as 인원수
       from V
       group by rollup(gender);
 
with v  as (
select name, memberno, pwd,
                    func_gender_2(jubun) as gender, 
                    grade, enterDay, chinaName, engname, graduateday, fk_regSeq, fk_deptSeq, totalSemester, email, img, postcode, address, detailaddress, extraaddress, birth,
                    8-absenceCnt as absenceCnt
from tbl_member
where memberNo='108' and pwd='9695b88a59a1610320897fa84cb7e144cc51f2984520efb77111d94b402a8382'
) 
 
select name, memberno, pwd,  gender, grade, enterDay, chinaName, engname, graduateday, fk_regSeq, fk_deptSeq, totalSemester, email, img, postcode, address, detailaddress, extraaddress, birth, absenceCnt, deptName, status
from V JOIN tbl_dept D
 on  V.fk_deptSeq = D.deptSeq
 join tbl_school_reg R
 on V.fk_regseq = r.regseq
 where memberNo = '108'
 
 desc tbl_certificateKind;
 select * from tbl_certificateKind;
insert into tbl_certificateKind(certificateKindSeq, certificateName, charge, lang) values(certificateKindSeq.nextval,  '재학증명서', 500, 1);
insert into tbl_certificateKind(certificateKindSeq, certificateName, charge, lang) values(certificateKindSeq.nextval,  '졸업증명서', 500, 1);
insert into tbl_certificateKind(certificateKindSeq, certificateName, charge, lang) values(certificateKindSeq.nextval,  '성적증명서', 500, 1);
insert into tbl_certificateKind(certificateKindSeq, certificateName, charge, lang) values(certificateKindSeq.nextval,  '학적부', 500, 1);
insert into tbl_certificateKind(certificateKindSeq, certificateName, charge, lang) values(certificateKindSeq.nextval,  '수료증명서', 500, 1);
insert into tbl_certificateKind(certificateKindSeq, certificateName, charge, lang) values(certificateKindSeq.nextval,  '교육비납입증명서', 500, 1);
insert into tbl_certificateKind(certificateKindSeq, certificateName, charge, lang) values(certificateKindSeq.nextval,  '장학금수혜증명서', 500, 1);

select certificateKindSeq, certificateName, charge, lang
from tbl_certificateKind
order by 1;

desc tbl_certificate;
select * from tbl_certificate;

delete from tbl_certificate where fk_memberno = 102

0,1,2,3 0 신청, 1 승인, 2 반려, 3보류

delete tbl_certificate;
insert into tbl_certificate(certificateSeq, fk_certificateKindSeq, fk_memberNo, count, grantstatus, lang, recieveWay, applicationdate, grantdate) values(certificateSeq.nextval,4,102,2,3,0,0, sysdate-7, sysdate-6);
insert into tbl_certificate(certificateSeq, fk_certificateKindSeq, fk_memberNo, count, grantstatus, lang, recieveWay, applicationdate, grantdate) values(certificateSeq.nextval,3,102,2,2,1,0, sysdate-5, sysdate-4);
insert into tbl_certificate(certificateSeq, fk_certificateKindSeq, fk_memberNo, count, grantstatus, lang, recieveWay, applicationdate, grantdate) values(certificateSeq.nextval,2,102,2,1,1,1, sysdate-3, sysdate-2);
insert into tbl_certificate(certificateSeq, fk_certificateKindSeq, fk_memberNo, count, grantstatus, lang, recieveWay, applicationdate) values(certificateSeq.nextval,1,102,2,0,0,1, sysdate);

update tbl_certificate set grantdate = sysdate-6 where certificateSeq = 9;
update tbl_certificate set grantdate = sysdate-4 where certificateSeq = 10;
update tbl_certificate set grantdate = sysdate-2 where certificateSeq =11;
 commit;
 
 select * from tbl_certificate;
 
 delete from tbl_certificate where certificateseq > 12;
 
 desc tbl_certificateKind;
 
 select case when grantStatus = 0 then '신청' when grantStatus = 1 then '승인' when grantStatus = 2 then '반려' else '보류' end AS grantStatus
 from tbl_certificate
 
 select   row_number() over(order by certificateSeq desc) as rno,
                m.name, certificateName
                , to_char(applicationDate, 'yyyy-mm-dd')as applicationDate
                , count
                ,to_char(grantDate, 'yyyy-mm-dd' as grantDate
            , case when grantStatus = 0 then '신청' when grantStatus = 1 then '승인' when grantStatus = 2 then '반려' else '보류' end AS grantStatus
            , case when c.lang = 0 then '국문' else '영문' end as lang
            , case when c.recieveWay = 0 then '직접수령' else '등기수령' end as recieveWay
 from tbl_certificate C join tbl_certificateKind K
 on K.certificateKindSeq  = C.fk_certificateKindSeq
 join tbl_member M
 on c.fk_memberno = m.memberno
 where fk_memberno = 108
 
 commit;
 
 select * from tbl_dept --컴공 2
 select * from tbl_subject;
 desc tbl_hsnotice;
 select * from tbl_hsnotice;

select * from tbl_hsnotice;
commit;
insert into tbl_hsnotice (noticeno, subject, contents, status) values(hsNoticeSeq.nextval, '이것은 전체공지입니다.', '전체공지테스트입니다.', 0);
insert into tbl_hsnotice (noticeno, fk_deptSeq, subject, contents, status) values(hsNoticeSeq.nextval, 2,'이것은 학과공지입니다.', '학과공지테스트입니다.', 1);
insert into tbl_hsnotice (noticeno, fk_subjectNo, subject, contents, status) values(hsNoticeSeq.nextval, 'NE118', '이것은 전체공지입니다.', '전체공지테스트입니다.', 2);

insert into tbl_hsnotice (noticeno, subject, contents, status) values(hsNoticeSeq.nextval, '새해인사.', '학우여러분 새해 복 많이 받으십시오..', 0);
insert into tbl_hsnotice (noticeno, subject, contents, status) values(hsNoticeSeq.nextval, '[중앙도서관] 2020학년도 42차 신착도서 안내',
'2020학년도 42차 신착도서 (HL0479585-HL0479656)<br><br>
- 게시일: 2020년 12월 30일<br>
- 장소: 중앙도서관 2층 자료실 신착도서코너<br>
           (신착도서는 2주 동안 게시합니다. )<br>
- 문의: 031-379-0152 (국내서 수서), 0154 (국외서수서/정리), 0155 (국내서 정리), 0161(대출실)<br><br>
*희망신청자료의 경우는 신청자에게 게시일로부터 3일간 우선권이 부여됩니다.*<br><br>
서명	청구기호<br>
심청전 전집. 8	811.105 심813 v.8 <br>
심청전 전집. 9	811.105 심813 v.9 <br>
심청전 전집. 10	811.105 심813 v.10 <br>
심청전 전집. 11	811.105 심813 v.11 <br>
심청전 전집. 12	811.105 심813 v.12 <br>
타인의 인력	780.951 최64ㅌ<br>
애국가 논쟁의 기록과 진실 :문화운동가 임진택의 애국가 바로잡기 	782.421599 임79ㅇ<br>
정통 정신분석의 기법과 실제. 2	616.8917 G798t이 v.2 <br>
(지금-여기에서의) 전이 분석 	616.8914 B344a정<br>
기업재무 	658.15 B512c14고<br>
기본 재무관리 	658.15 B512f4선<br>
기본 재무관리 	658.15 B512f4선 c.2 <br>
기본 재무관리 	658.15 B512f4선 c.3 <br>
객관식 재무관리 =Financial management. 1	658.15076 이64ㄱ14 v.1 <br>
객관식 재무관리 =Financial management. 2	658.15076 이64ㄱ14 v.2 <br>
', 0);
insert into tbl_hsnotice (noticeno, subject, contents, status) values(hsNoticeSeq.nextval, '[중앙도서관] 2020학년도 43차 신착도서 안내',
'2020학년도 42차 신착도서 (HL0479585-HL0479656)<br><br>
- 게시일: 2020년 12월 30일<br>
- 장소: 중앙도서관 2층 자료실 신착도서코너<br>
           (신착도서는 2주 동안 게시합니다. )<br>
- 문의: 031-379-0152 (국내서 수서), 0154 (국외서수서/정리), 0155 (국내서 정리), 0161(대출실)<br><br>
*희망신청자료의 경우는 신청자에게 게시일로부터 3일간 우선권이 부여됩니다.*<br><br>
서명	청구기호<br>
심청전 전집. 8	811.105 심813 v.8 <br>
심청전 전집. 9	811.105 심813 v.9 <br>
심청전 전집. 10	811.105 심813 v.10 <br>
심청전 전집. 11	811.105 심813 v.11 <br>
심청전 전집. 12	811.105 심813 v.12 <br>
타인의 인력	780.951 최64ㅌ<br>
애국가 논쟁의 기록과 진실 :문화운동가 임진택의 애국가 바로잡기 	782.421599 임79ㅇ<br>
정통 정신분석의 기법과 실제. 2	616.8917 G798t이 v.2 <br>
(지금-여기에서의) 전이 분석 	616.8914 B344a정<br>
기업재무 	658.15 B512c14고<br>
기본 재무관리 	658.15 B512f4선<br>
기본 재무관리 	658.15 B512f4선 c.2 <br>
기본 재무관리 	658.15 B512f4선 c.3 <br>
객관식 재무관리 =Financial management. 1	658.15076 이64ㄱ14 v.1 <br>
객관식 재무관리 =Financial management. 2	658.15076 이64ㄱ14 v.2 <br>
', 0);
commit;
insert into tbl_hsnotice (noticeno, subject, contents, status) values(hsNoticeSeq.nextval, '[학생지원팀] 동계방학 단축근무로 인한 증명서 발급 업무시간 안내', '전체공지테스트입니다.', 0);
update tbl_hsnotice set subject = '[공모] 대백제전 포스터 디자인 공모전' where noticeno = 8;
insert into tbl_hsnotice (noticeno, subject, contents, status) values(hsNoticeSeq.nextval, '이것은 전체공지입니다.', '전체공지테스트입니다.', 0);
insert into tbl_hsnotice (noticeno, subject, contents, status) values(hsNoticeSeq.nextval, '이것은 전체공지입니다.', '전체공지테스트입니다.', 0);

delete from tbl_hsnotice where noticeno = 9

update tbl_hsnotice set subject='이것은 과목공지입니다.', contents='과목공지테스트입니다.' where noticeno = 3

select * from tbl_dept;

insert into tbl_hsnotice (noticeno, fk_deptSeq, subject, contents, status) values(hsNoticeSeq.nextval, 1,'대면 기말고사 시행 관련 학생 준수사항 안내', '
대면 기말고사 시행 관련 학생 준수사항 안내<br><br>
코로나-19 감염증 예방 및 확산방지를 위하여, 기말시험 기간 중 아래 내용을 반드시 준수할 것을 공지합니다.<br><br>
   1. 캠퍼스 건물 내 음식물 반입금지 (건물 내 음식 섭취 금지)<br>
   2. 금일부터 고위험 시설 출입금지 (예시 : 유흥시설, 실내 공연장, 노래연습장 등)<br>
   3. 학생들 간의 모임 및 행사 금지<br>
   4. 마스크 상시 착용 (입과 코가 완전히 가려지도록 착용)<br>
   5. 시험시간 전·후에도 개인간 간격 2m이상 유지<br><br>
SKY대학교 모든 구성원들의 안전을 위하여, 위의 사항을 반드시 준수하여 주시기 바랍니다.<br>
 ', 1);
insert into tbl_hsnotice (noticeno, fk_deptSeq, subject, contents, status) values(hsNoticeSeq.nextval, 14,'기말고사 시행 관련 안내', '학과공지테스트입니다.', 1);
insert into tbl_hsnotice (noticeno, fk_deptSeq, subject, contents, status) values(hsNoticeSeq.nextval, 15,'학생 준수사항 안내', '학과공지테스트입니다.', 1);

commit;

select * from tbl_subject;

AA101
AB204
NE317
NE119
insert into tbl_hsnotice (noticeno, fk_subjectNo, subject, contents, status) values(hsNoticeSeq.nextval, 'AA101', '대면 수업 관련 안내', '전체공지테스트입니다.', 2);
insert into tbl_hsnotice (noticeno, fk_subjectNo, subject, contents, status) values(hsNoticeSeq.nextval, 'AB204', '2021년 첫째주 휴강 관련 안내', '휴강할거에여', 2);
insert into tbl_hsnotice (noticeno, fk_subjectNo, subject, contents, status) values(hsNoticeSeq.nextval, 'NE317', '과제 공지', '전체공지테스트입니다.', 2);
insert into tbl_hsnotice (noticeno, fk_subjectNo, subject, contents, status) values(hsNoticeSeq.nextval, 'NE119', '강의실 공사 안내', '전체공지테스트입니다.', 2);

select row_number() over(order by noticeNo desc) as rno, noticeNo, subject, contents, to_char(writeday, 'yyyy-dd-mm') as writeday, readcount, filename, orgfilename, filesize, status
from tbl_hsnotice where status = 0 ;

select row_number() over(order by noticeNo desc) as rno, noticeNo, fk_deptSeq, deptName, subject, contents,  to_char(writeday, 'yyyy-dd-mm') as writeday, readcount, filename, orgfilename, filesize, status 
from tbl_hsnotice H join tbl_dept D
on H.fk_deptSeq = D.deptSeq
where status = 1;

select row_number() over(order by noticeNo desc) as rno, noticeNo, fk_subjectNo, subjectName, subject, contents,  to_char(writeday, 'yyyy-dd-mm') as writeday, readcount, filename, orgfilename, filesize, status
from tbl_hsnotice H  join tbl_subject S
on H.fk_subjectNo = S.subjectNo
where status = 2;

select row_number() over(order by noticeNo desc) as rno, noticeNo, fk_subjectNo, subjectName, subject, contents,  to_char(writeday, 'yyyy-dd-mm') as writeday, readcount, filename, orgfilename, filesize, status

select * from tbl_course where fk_memberno = 108 and courseyear =  to_char(sysdate, 'yyyy')-1;

select * from tbl_course where fk_memberno = 108;

select * from tbl_course;
select * from tbl_subject;

select fk_memberNo, subjectName, semester, courseyear, mustStatus, fk_deptSeq
from tbl_course C join tbl_subject S 
on c.fk_subjectNo = s.subjectNo
where fk_memberNo = 108
order by courseyear desc, semester desc;

select * from tbl_dept

select fk_memberNo, subjectName, semester, courseYear, mustStatus, fk_deptSeq, deptName
from
(
select fk_memberNo, subjectName, semester, courseyear, mustStatus, fk_deptSeq, case when to_char(sysdate, 'q') in(1,2) then 1 else 2 end as thisSemester, deptName
from tbl_course C join tbl_subject S 
on c.fk_subjectNo = s.subjectNo
join tbl_dept D
on s.fk_deptSeq = d.deptSeq
where fk_memberNo = 102 and courseyear = to_char(sysdate, 'yyyy')
order by courseyear desc, semester desc
) V
where semester = thissemester

select * 
from tbl_course C join tbl_subject S 
on c.fk_subjectNo = s.subjectNo
join tbl_dept D
on s.fk_deptSeq = d.deptSeq


  
        
        select kind(교필)
        from dual
        
        with T as
        (
        select fk_memberNo, subjectName, semester, courseYear, mustStatus, fk_deptSeq, thisSemester
		from
			(
			select fk_memberNo, subjectName, semester, courseyear, mustStatus, fk_deptSeq, case when to_char(sysdate, 'q') in(1,2) then 1 else 2 end as thisSemester
			from tbl_course C join tbl_subject S 
			on c.fk_subjectNo = s.subjectNo
			where fk_memberNo = 108 and courseyear = to_char(sysdate, 'yyyy')-1
			order by courseyear desc, semester desc
			) V
		where semester = thisSemester
        ) 
        
        select memberNo, semester, courseYear, subjectName, mustStatus, m.fk_deptSeq, thisSemester
        from tbl_member M join T 
        on m.memberNo = t.fk_memberNo
        where m.fk_deptSeq = t.fk_deptSeq
        
        
        select *
        from tbl_subject
        where mustStatus = 0
        
        select count(*)
        from tbl_course
        where fk_memberNo = 108 -- 46
        
        select count(*) -- 46
        from tbl_course c join tbl_subject s
        on c.fk_subjectNo = s.subjectNo
        where fk_memberNo = 108
 
 ---------------------------------------------------------------------------------------------학생별 수강내역 조회------------------------------------------------------------------------------------------------------------------------------------------
        
        -- 이번학기 수강내역
        select fk_memberNo, subjectName, semester, courseYear, mustStatus, fk_deptSeq
		from
			(
			select fk_memberNo, subjectName, semester, courseyear, mustStatus, fk_deptSeq, case when to_char(sysdate, 'q') in(1,2) then 1 else 2 end as thisSemester
			from tbl_course C join tbl_subject S 
			on c.fk_subjectNo = s.subjectNo
			where fk_memberNo = 102 and courseyear = to_char(sysdate, 'yyyy')
			order by courseyear desc, semester desc
			) V
		where semester = thisSemester
        
          -- 이번학기 전공 필수 조회
        select  semester, courseYear, subjectName
        from 
        (
        select semester, courseYear, subjectName, mustStatus, s_deptSeq, fk_deptSeq as m_deptSeq, case when to_char(sysdate, 'q') in(1,2) then 1 else 2 end as thisSemester
        from
        (
            select semester, courseYear, fk_memberNo, subjectName, mustStatus, deptSeq as s_deptSeq
            from tbl_course c join tbl_subject s
            on c.fk_subjectNo = s.subjectNo
            join tbl_dept d
            on s.fk_deptSeq = d.deptSeq
            where fk_memberNo = 108
        )V
        join tbl_member m
        on v.fk_memberNo = m.memberNo
        )T
        where s_deptSeq = m_deptSeq and muststatus = 0 and semester = thissemester and courseYear = to_char(sysdate, 'yyyy')
        
        -- 이번학기 전공 선택 조회
        select  semester, courseYear, subjectName
        from 
        (
        select semester, courseYear, subjectName, mustStatus, s_deptSeq, fk_deptSeq as m_deptSeq, case when to_char(sysdate, 'q') in(1,2) then 1 else 2 end as thisSemester
        from
        (
            select semester, courseYear, fk_memberNo, subjectName, mustStatus, deptSeq as s_deptSeq
            from tbl_course c join tbl_subject s
            on c.fk_subjectNo = s.subjectNo
            join tbl_dept d
            on s.fk_deptSeq = d.deptSeq
            where fk_memberNo = 102
        )V
        join tbl_member m
        on v.fk_memberNo = m.memberNo
        )T
        where s_deptSeq = m_deptSeq and muststatus = 1 and semester = thissemester and courseYear = to_char(sysdate, 'yyyy')
        
          -- 이번학기 교양필수 조회
        select semester, courseYear, subjectName
        from
        (
            select semester, courseYear, subjectName, mustStatus, deptSeq, case when to_char(sysdate, 'q') in(1,2) then 1 else 2 end as thisSemester
            from tbl_course c join tbl_subject s
            on c.fk_subjectNo = s.subjectNo
            join tbl_dept d
            on s.fk_deptSeq = d.deptSeq
            where fk_memberNo = 108
        )V
        where deptSeq = 23 and mustStatus = 0 and semester = thissemester and courseYear = to_char(sysdate, 'yyyy')
        
         -- 이번학기 교양선택 조회
        select semester, courseYear, subjectName
        from
        (
            select semester, courseYear, subjectName, mustStatus, deptSeq, case when to_char(sysdate, 'q') in(1,2) then 1 else 2 end as thisSemester
            from tbl_course c join tbl_subject s
            on c.fk_subjectNo = s.subjectNo
            join tbl_dept d
            on s.fk_deptSeq = d.deptSeq
            where fk_memberNo = 108
        )V
        where deptSeq = 23 and mustStatus = 1 and semester = thissemester and courseYear = to_char(sysdate, 'yyyy')

       -- 이번학기 일반 선택 조회
        select  semester, courseYear, subjectName
        from 
        (
        select semester, courseYear, subjectName, mustStatus, s_deptSeq, fk_deptSeq as m_deptSeq, case when to_char(sysdate, 'q') in(1,2) then 1 else 2 end as thisSemester
        from
        (
            select semester, courseYear, fk_memberNo, subjectName, mustStatus, deptSeq as s_deptSeq
            from tbl_course c join tbl_subject s
            on c.fk_subjectNo = s.subjectNo
            join tbl_dept d
            on s.fk_deptSeq = d.deptSeq
            where fk_memberNo = 108
        )V
        join tbl_member m
        on v.fk_memberNo = m.memberNo
        )T
        where s_deptSeq != m_deptSeq and s_deptSeq != 23 and semester = thissemester and courseyear = to_char(sysdate, 'yyyy')

---------------------------------------------------------------------------------------------------------------------정리전 ----------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

         -- 이번학기 교양선택 조회
        select courseNo, semester, courseYear, fk_memberNo, fk_subjectNo, subjectName, deptName, mustStatus, subjectNo, deptSeq
        from
        (
            select courseNo, semester, courseYear, fk_memberNo, fk_subjectNo, subjectName, deptName, mustStatus, subjectNo, deptSeq, case when to_char(sysdate, 'q') in(1,2) then 1 else 2 end as thisSemester
            from tbl_course c join tbl_subject s
            on c.fk_subjectNo = s.subjectNo
            join tbl_dept d
            on s.fk_deptSeq = d.deptSeq
            where fk_memberNo = 108
        )V
        where deptSeq = 23 and mustStatus = 1 and semester = thissemester and courseyear = to_char(sysdate, 'yyyy')
        
        -- 이번학기 교양 필수 조회
      select courseNo, semester, courseYear, fk_memberNo, fk_subjectNo, subjectName, deptName, mustStatus, subjectNo, deptSeq
        from
        (
            select courseNo, semester, courseYear, fk_memberNo, fk_subjectNo, subjectName, deptName, mustStatus, subjectNo, deptSeq, case when to_char(sysdate, 'q') in(1,2) then 1 else 2 end as thisSemester
            from tbl_course c join tbl_subject s
            on c.fk_subjectNo = s.subjectNo
            join tbl_dept d
            on s.fk_deptSeq = d.deptSeq
            where fk_memberNo = 102
        )V
        where deptSeq = 23 and mustStatus = 0 and semester = thissemester and courseyear = to_char(sysdate, 'yyyy')
        
        -- 이번학기 전공 선택 조회
        select courseNo, semester, courseYear, fk_memberNo, fk_subjectNo, subjectName, deptName, mustStatus, subjectNo, s_deptSeq, m_deptSeq
        from 
        (
        select courseNo, semester, courseYear, fk_memberNo, fk_subjectNo, subjectName, deptName, mustStatus, subjectNo, s_deptSeq, fk_deptSeq as m_deptSeq, case when to_char(sysdate, 'q') in(1,2) then 1 else 2 end as thisSemester
        from
        (
            select courseNo, semester, courseYear, fk_memberNo, fk_subjectNo, subjectName, deptName, mustStatus, subjectNo, deptSeq as s_deptSeq
            from tbl_course c join tbl_subject s
            on c.fk_subjectNo = s.subjectNo
            join tbl_dept d
            on s.fk_deptSeq = d.deptSeq
            where fk_memberNo = 102
        )V
        join tbl_member m
        on v.fk_memberNo = m.memberNo
        )T
        where s_deptSeq = m_deptSeq and muststatus = 1 and semester = thissemester and courseyear = to_char(sysdate, 'yyyy')
        
        -- 이번학기 전공 필수 조회
        select courseNo, semester, courseYear, fk_memberNo, fk_subjectNo, subjectName, deptName, mustStatus, subjectNo, s_deptSeq, m_deptSeq
        from 
        (
        select courseNo, semester, courseYear, fk_memberNo, fk_subjectNo, subjectName, deptName, mustStatus, subjectNo, s_deptSeq, fk_deptSeq as m_deptSeq, case when to_char(sysdate, 'q') in(1,2) then 1 else 2 end as thisSemester
        from
        (
            select courseNo, semester, courseYear, fk_memberNo, fk_subjectNo, subjectName, deptName, mustStatus, subjectNo, deptSeq as s_deptSeq
            from tbl_course c join tbl_subject s
            on c.fk_subjectNo = s.subjectNo
            join tbl_dept d
            on s.fk_deptSeq = d.deptSeq
            where fk_memberNo = 108
        )V
        join tbl_member m
        on v.fk_memberNo = m.memberNo
        )T
        where s_deptSeq = m_deptSeq and muststatus = 0 and semester = thissemester and courseyear = to_char(sysdate, 'yyyy')
        
        --  이번학기 일반 선택 조회
        select courseNo, semester, courseYear, fk_memberNo, fk_subjectNo, subjectName, deptName, mustStatus, subjectNo, s_deptSeq, m_deptSeq
        from 
        (
        select courseNo, semester, courseYear, fk_memberNo, fk_subjectNo, subjectName, deptName, mustStatus, subjectNo, s_deptSeq, fk_deptSeq as m_deptSeq, case when to_char(sysdate, 'q') in(1,2) then 1 else 2 end as thisSemester
        from
        (
            select courseNo, semester, courseYear, fk_memberNo, fk_subjectNo, subjectName, deptName, mustStatus, subjectNo, deptSeq as s_deptSeq
            from tbl_course c join tbl_subject s
            on c.fk_subjectNo = s.subjectNo
            join tbl_dept d
            on s.fk_deptSeq = d.deptSeq
            where fk_memberNo = 102
        )V
        join tbl_member m
        on v.fk_memberNo = m.memberNo
        )T
        where s_deptSeq != m_deptSeq and s_deptSeq != 23 and semester = thissemester and courseyear = to_char(sysdate, 'yyyy')
        
        -- 한명 전체 수업 내역 조회
        select courseNo, semester, courseYear, fk_memberNo, fk_subjectNo, subjectName, deptName, mustStatus, subjectNo, deptSeq
        from tbl_course c join tbl_subject s
        on c.fk_subjectNo = s.subjectNo
        join tbl_dept d
        on s.fk_deptSeq = d.deptSeq
        where fk_memberNo = 108
        
        select * from tbl_course
        select * from tbl_subject
        
        
        
        -- 교양선택 조회
        select courseNo, semester, courseYear, fk_memberNo, fk_subjectNo, subjectName, deptName, mustStatus, subjectNo, deptSeq
        from
        (
            select courseNo, semester, courseYear, fk_memberNo, fk_subjectNo, subjectName, deptName, mustStatus, subjectNo, deptSeq
            from tbl_course c join tbl_subject s
            on c.fk_subjectNo = s.subjectNo
            join tbl_dept d
            on s.fk_deptSeq = d.deptSeq
            where fk_memberNo = 108
        )V
        where deptSeq = 23 and mustStatus = 1
        
        -- 교양 필수 조회
      select courseNo, semester, courseYear, fk_memberNo, fk_subjectNo, subjectName, deptName, mustStatus, subjectNo, deptSeq
        from
        (
            select courseNo, semester, courseYear, fk_memberNo, fk_subjectNo, subjectName, deptName, mustStatus, subjectNo, deptSeq
            from tbl_course c join tbl_subject s
            on c.fk_subjectNo = s.subjectNo
            join tbl_dept d
            on s.fk_deptSeq = d.deptSeq
            where fk_memberNo = 108
        )V
        where deptSeq = 23 and mustStatus = 0
        
        -- 전공 선택 조회
        select courseNo, semester, courseYear, fk_memberNo, fk_subjectNo, subjectName, deptName, mustStatus, subjectNo, s_deptSeq, m_deptSeq
        from 
        (
        select courseNo, semester, courseYear, fk_memberNo, fk_subjectNo, subjectName, deptName, mustStatus, subjectNo, s_deptSeq, fk_deptSeq as m_deptSeq
        from
        (
            select courseNo, semester, courseYear, fk_memberNo, fk_subjectNo, subjectName, deptName, mustStatus, subjectNo, deptSeq as s_deptSeq
            from tbl_course c join tbl_subject s
            on c.fk_subjectNo = s.subjectNo
            join tbl_dept d
            on s.fk_deptSeq = d.deptSeq
            where fk_memberNo = 108
        )V
        join tbl_member m
        on v.fk_memberNo = m.memberNo
        )T
        where s_deptSeq = m_deptSeq and muststatus = 1
        
        -- 전공 필수 조회
        select courseNo, semester, courseYear, fk_memberNo, fk_subjectNo, subjectName, deptName, mustStatus, subjectNo, s_deptSeq, m_deptSeq
        from 
        (
        select courseNo, semester, courseYear, fk_memberNo, fk_subjectNo, subjectName, deptName, mustStatus, subjectNo, s_deptSeq, fk_deptSeq as m_deptSeq
        from
        (
            select courseNo, semester, courseYear, fk_memberNo, fk_subjectNo, subjectName, deptName, mustStatus, subjectNo, deptSeq as s_deptSeq
            from tbl_course c join tbl_subject s
            on c.fk_subjectNo = s.subjectNo
            join tbl_dept d
            on s.fk_deptSeq = d.deptSeq
            where fk_memberNo = 108
        )V
        join tbl_member m
        on v.fk_memberNo = m.memberNo
        )T
        where s_deptSeq = m_deptSeq and muststatus = 0
        
        -- 일반 선택 조회
        select courseNo, semester, courseYear, fk_memberNo, fk_subjectNo, subjectName, deptName, mustStatus, subjectNo, s_deptSeq, m_deptSeq
        from 
        (
        select courseNo, semester, courseYear, fk_memberNo, fk_subjectNo, subjectName, deptName, mustStatus, subjectNo, s_deptSeq, fk_deptSeq as m_deptSeq
        from
        (
            select courseNo, semester, courseYear, fk_memberNo, fk_subjectNo, subjectName, deptName, mustStatus, subjectNo, deptSeq as s_deptSeq
            from tbl_course c join tbl_subject s
            on c.fk_subjectNo = s.subjectNo
            join tbl_dept d
            on s.fk_deptSeq = d.deptSeq
            where fk_memberNo = 108
        )V
        join tbl_member m
        on v.fk_memberNo = m.memberNo
        )T
        where s_deptSeq != m_deptSeq and s_deptSeq != 23
        
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------        
         -- 교양선택 조회(기이수)
        select semester, courseYear, subjectName, mustStatus, subjectNo, deptSeq, score, credits
        from
        (
            select semester, courseYear, fk_subjectNo, subjectName, mustStatus, subjectNo, deptSeq, score, credits,  case when to_char(sysdate, 'q') in(1,2) then 1 else 2 end as thisSemester
            from tbl_course c join tbl_subject s
            on c.fk_subjectNo = s.subjectNo
            join tbl_dept d
            on s.fk_deptSeq = d.deptSeq
            where fk_memberNo = 108
        )V
        where deptSeq = 23 and mustStatus = 1 and semester != thisSemester
        
        -- 교양필수 조회(기이수)
        select semester, courseYear, subjectName, mustStatus, subjectNo, deptSeq, score, credits
        from
        (
            select semester, courseYear, fk_subjectNo, subjectName, mustStatus, subjectNo, deptSeq, score, credits,  case when to_char(sysdate, 'q') in(1,2) then 1 else 2 end as thisSemester
            from tbl_course c join tbl_subject s
            on c.fk_subjectNo = s.subjectNo
            join tbl_dept d
            on s.fk_deptSeq = d.deptSeq
            where fk_memberNo = 108
        )V
        where deptSeq = 23 and mustStatus = 0 and semester != thisSemester
        
        --전공선택 조회(기이수)
       select semester, courseYear, subjectName, mustStatus, subjectNo, deptSeq, score, credits
        from 
        (
        select semester, courseYear, subjectName, mustStatus, subjectNo, deptSeq, fk_deptSeq as m_deptSeq, score, credits,  case when to_char(sysdate, 'q') in(1,2) then 1 else 2 end as thisSemester
        from
        (
            select semester, courseYear, fk_memberNo, subjectName, mustStatus, subjectNo, deptSeq, score, credits
            from tbl_course c join tbl_subject s
            on c.fk_subjectNo = s.subjectNo
            join tbl_dept d
            on s.fk_deptSeq = d.deptSeq
            where fk_memberNo = 108
        )V
        join tbl_member m
        on v.fk_memberNo = m.memberNo
        )T
        where deptSeq = m_deptSeq and muststatus = 1 and semester != thisSemester
        
        -- 전공필수 조회(기이수)
       select semester, courseYear, subjectName, mustStatus, subjectNo, deptSeq, score, credits
        from 
        (
        select semester, courseYear, subjectName, mustStatus, subjectNo, deptSeq, fk_deptSeq as m_deptSeq, score, credits,  case when to_char(sysdate, 'q') in(1,2) then 1 else 2 end as thisSemester
        from
        (
            select semester, courseYear, fk_memberNo, subjectName, mustStatus, subjectNo, deptSeq, score, credits
            from tbl_course c join tbl_subject s
            on c.fk_subjectNo = s.subjectNo
            join tbl_dept d
            on s.fk_deptSeq = d.deptSeq
            where fk_memberNo = 108
        )V
        join tbl_member m
        on v.fk_memberNo = m.memberNo
        )T
        where deptSeq = m_deptSeq and muststatus = 0 and semester != thisSemester
        
          -- 일반 선택 조회
       select semester, courseYear, subjectName, mustStatus, subjectNo, deptSeq, score, credits
        from 
        (
        select semester, courseYear, subjectName, mustStatus, subjectNo, deptSeq, fk_deptSeq as m_deptSeq, score, credits,  case when to_char(sysdate, 'q') in(1,2) then 1 else 2 end as thisSemester
        from
        (
            select semester, courseYear, fk_memberNo, subjectName, mustStatus, subjectNo, deptSeq, score, credits
            from tbl_course c join tbl_subject s
            on c.fk_subjectNo = s.subjectNo
            join tbl_dept d
            on s.fk_deptSeq = d.deptSeq
            where fk_memberNo = 106
        )V
        join tbl_member m
        on v.fk_memberNo = m.memberNo
        )T
        where deptSeq != m_deptSeq and  deptSeq != 23 and muststatus = 0 and semester != thisSemester
        
        
 ------------------------------------------------기이수성적 union으로 엮어보기 --------------------------------------------------------------------------------------------------------------------------------------------------
    
    select semester, courseYear, subjectName, mustStatus, subjectNo, deptSeq, score, credits, division
    from
    (
    -- 교양선택 조회(기이수)
    select semester, courseYear, subjectName, mustStatus, subjectNo, deptSeq, score, credits, division
        from
        (
            select semester, courseYear, subjectName, mustStatus, subjectNo, deptSeq, score, credits
                      , courseYear||'-'||semester as courseSemester
                       ,   to_char(sysdate, 'yyyy')||'-'||case when to_char(sysdate, 'q') in(1,2) then 1 else 2 end as thisSemester
                       , func_gyoyang(deptSeq, mustStatus) as division
            from tbl_course c join tbl_subject s
            on c.fk_subjectNo = s.subjectNo
            join tbl_dept d
            on s.fk_deptSeq = d.deptSeq
            where fk_memberNo = 108
        )V
        where deptSeq = 23 and mustStatus = 1 and courseSemester != thisSemester
        union
        -- 교양필수 조회(기이수)
        select semester, courseYear, subjectName, mustStatus, subjectNo, deptSeq, score, credits, division
        from
        (
            select semester, courseYear, fk_subjectNo, subjectName, mustStatus, subjectNo, deptSeq, score, credits
                        , courseYear||'-'||semester as courseSemester
                        ,   to_char(sysdate, 'yyyy')||'-'||case when to_char(sysdate, 'q') in(1,2) then 1 else 2 end as thisSemester
                        ,   func_gyoyang(deptSeq, mustStatus) as division
            from tbl_course c join tbl_subject s
            on c.fk_subjectNo = s.subjectNo
            join tbl_dept d
            on s.fk_deptSeq = d.deptSeq
            where fk_memberNo = 108
        )V
        where deptSeq = 23 and mustStatus = 0 and courseSemester != thisSemester
        union
        --전공선택 조회(기이수)
       select semester, courseYear, subjectName, mustStatus, subjectNo, deptSeq, score, credits, division
        from 
        (
        select semester, courseYear, subjectName, mustStatus, subjectNo, deptSeq, fk_deptSeq as m_deptSeq, score, credits, courseSemester,
                    to_char(sysdate, 'yyyy')||'-'||thisSemester as thisSemester
                    ,func_major(deptSeq, fk_deptSeq, mustStatus) as division
        from
        (
            select semester, courseYear, fk_memberNo, subjectName, mustStatus, subjectNo, deptSeq, score, credits
                      , courseYear||'-'||semester as courseSemester,  case when to_char(sysdate, 'q') in(1,2) then 1 else 2 end as thisSemester
            from tbl_course c join tbl_subject s
            on c.fk_subjectNo = s.subjectNo
            join tbl_dept d
            on s.fk_deptSeq = d.deptSeq
            where fk_memberNo = 108
        )V
        join tbl_member m
        on v.fk_memberNo = m.memberNo
        )T
        where deptSeq = m_deptSeq and muststatus = 1 and courseSemester != thisSemester
        union
        -- 전공필수 조회(기이수)
       select semester, courseYear, subjectName, mustStatus, subjectNo, deptSeq, score, credits, division
        from 
        (
        select semester, courseYear, subjectName, mustStatus, subjectNo, deptSeq, fk_deptSeq as m_deptSeq, score, credits, courseSemester,
                    to_char(sysdate, 'yyyy')||'-'||thisSemester as thisSemester
                     ,func_major(deptSeq, fk_deptSeq, mustStatus) as division
        from
        (
            select semester, courseYear, fk_memberNo, subjectName, mustStatus, subjectNo, deptSeq, score, credits,
                     courseYear||'-'||semester as courseSemester,  case when to_char(sysdate, 'q') in(1,2) then 1 else 2 end as thisSemester
            from tbl_course c join tbl_subject s
            on c.fk_subjectNo = s.subjectNo
            join tbl_dept d
            on s.fk_deptSeq = d.deptSeq
            where fk_memberNo = 108
        )V
        join tbl_member m
        on v.fk_memberNo = m.memberNo
        )T
        where deptSeq = m_deptSeq and muststatus = 0 and courseSemester != thisSemester
        union
          -- 일반 선택 조회
       select semester, courseYear, subjectName, mustStatus, subjectNo, deptSeq, score, credits, division
        from 
        (
        select semester, courseYear, subjectName, mustStatus, subjectNo, deptSeq, fk_deptSeq as m_deptSeq, score, credits, courseSemester,
                    to_char(sysdate, 'yyyy')||'-'||thisSemester as thisSemester
                     ,func_major(deptSeq, fk_deptSeq, mustStatus) as division
        from
        (
            select semester, courseYear, fk_memberNo, subjectName, mustStatus, subjectNo, deptSeq, score, credits,
                     courseYear||'-'||semester as courseSemester,  case when to_char(sysdate, 'q') in(1,2) then 1 else 2 end as thisSemester
            from tbl_course c join tbl_subject s
            on c.fk_subjectNo = s.subjectNo
            join tbl_dept d
            on s.fk_deptSeq = d.deptSeq
            where fk_memberNo = 108
        )V
        join tbl_member m
        on v.fk_memberNo = m.memberNo
        )T
        where deptSeq != m_deptSeq and  deptSeq != 23  and courseSemester != thisSemester
        )G
        where score is not null
        order by courseYear desc, semester desc, deptseq asc, muststatus asc
        
 -------------------------------------------------------------------------------------------- 당학기 성적조회------------------------------------------------------------------------------------------------------------------------------------
    select  courseYear, semester, division, subjectNo ,subjectName, credits, score, func_score(score) as grade,
                case when score = 'F' then '미이수' else '이수' end as complete, deptSeq, mustStatus
    from  
    (
    -- 교양선택 조회(기이수)
    select semester, courseYear, subjectName, mustStatus, subjectNo, deptSeq, score, credits, division
        from
        (
            select semester, courseYear, subjectName, mustStatus, subjectNo, deptSeq, score, credits
                      , courseYear||'-'||semester as courseSemester
                       ,   to_char(sysdate, 'yyyy')||'-'||case when to_char(sysdate, 'q') in(1,2) then 1 else 2 end as thisSemester
                       , func_gyoyang(deptSeq, mustStatus) as division
            from tbl_course c join tbl_subject s
            on c.fk_subjectNo = s.subjectNo
            join tbl_dept d
            on s.fk_deptSeq = d.deptSeq
            where fk_memberNo = 102
        )V
        where deptSeq = 23 and mustStatus = 1 and courseSemester = thisSemester
        union
        -- 교양필수 조회(기이수)
        select semester, courseYear, subjectName, mustStatus, subjectNo, deptSeq, score, credits, division
        from
        (
            select semester, courseYear, fk_subjectNo, subjectName, mustStatus, subjectNo, deptSeq, score, credits
                        , courseYear||'-'||semester as courseSemester
                        ,   to_char(sysdate, 'yyyy')||'-'||case when to_char(sysdate, 'q') in(1,2) then 1 else 2 end as thisSemester
                        ,   func_gyoyang(deptSeq, mustStatus) as division
            from tbl_course c join tbl_subject s
            on c.fk_subjectNo = s.subjectNo
            join tbl_dept d
            on s.fk_deptSeq = d.deptSeq
            where fk_memberNo = 102
        )V
        where deptSeq = 23 and mustStatus = 0 and courseSemester = thisSemester
        union
        --전공선택 조회(기이수)
       select semester, courseYear, subjectName, mustStatus, subjectNo, deptSeq, score, credits, division
        from 
        (
        select semester, courseYear, subjectName, mustStatus, subjectNo, deptSeq, fk_deptSeq as m_deptSeq, score, credits, courseSemester,
                    to_char(sysdate, 'yyyy')||'-'||thisSemester as thisSemester
                    ,func_major(deptSeq, fk_deptSeq, mustStatus) as division
        from
        (
            select semester, courseYear, fk_memberNo, subjectName, mustStatus, subjectNo, deptSeq, score, credits
                      , courseYear||'-'||semester as courseSemester,  case when to_char(sysdate, 'q') in(1,2) then 1 else 2 end as thisSemester
            from tbl_course c join tbl_subject s
            on c.fk_subjectNo = s.subjectNo
            join tbl_dept d
            on s.fk_deptSeq = d.deptSeq
            where fk_memberNo = 102
        )V
        join tbl_member m
        on v.fk_memberNo = m.memberNo
        )T
        where deptSeq = m_deptSeq and muststatus = 1 and courseSemester = thisSemester
        union
        -- 전공필수 조회(기이수)
       select semester, courseYear, subjectName, mustStatus, subjectNo, deptSeq, score, credits, division
        from 
        (
        select semester, courseYear, subjectName, mustStatus, subjectNo, deptSeq, fk_deptSeq as m_deptSeq, score, credits, courseSemester,
                    to_char(sysdate, 'yyyy')||'-'||thisSemester as thisSemester
                     ,func_major(deptSeq, fk_deptSeq, mustStatus) as division
        from
        (
            select semester, courseYear, fk_memberNo, subjectName, mustStatus, subjectNo, deptSeq, score, credits,
                     courseYear||'-'||semester as courseSemester,  case when to_char(sysdate, 'q') in(1,2) then 1 else 2 end as thisSemester
            from tbl_course c join tbl_subject s
            on c.fk_subjectNo = s.subjectNo
            join tbl_dept d
            on s.fk_deptSeq = d.deptSeq
            where fk_memberNo = 102
        )V
        join tbl_member m
        on v.fk_memberNo = m.memberNo
        )T
        where deptSeq = m_deptSeq and muststatus = 0 and courseSemester = thisSemester
        union
          -- 일반 선택 조회
       select semester, courseYear, subjectName, mustStatus, subjectNo, deptSeq, score, credits, division
        from 
        (
        select semester, courseYear, subjectName, mustStatus, subjectNo, deptSeq, fk_deptSeq as m_deptSeq, score, credits, courseSemester,
                    to_char(sysdate, 'yyyy')||'-'||thisSemester as thisSemester
                     ,func_major(deptSeq, fk_deptSeq, mustStatus) as division
        from
        (
            select semester, courseYear, fk_memberNo, subjectName, mustStatus, subjectNo, deptSeq, score, credits,
                     courseYear||'-'||semester as courseSemester,  case when to_char(sysdate, 'q') in(1,2) then 1 else 2 end as thisSemester
            from tbl_course c join tbl_subject s
            on c.fk_subjectNo = s.subjectNo
            join tbl_dept d
            on s.fk_deptSeq = d.deptSeq
            where fk_memberNo = 102
        )V
        join tbl_member m
        on v.fk_memberNo = m.memberNo
        )T
        where deptSeq != m_deptSeq and  deptSeq != 23  and courseSemester = thisSemester
        )G
        order by courseYear desc, semester desc, deptseq asc, muststatus asc
        
        
        select * from tbl_course where fk_memberNo = 108 and fk_subjectno = 'EB103'
        select * from tbl_subject where subjectno = 'EB103'
        select * from tbl_dept
        
        
        select semester, courseYear, subjectName, mustStatus, subjectNo, deptSeq, score, credits
        from 
        (
        select semester, courseYear, subjectName, mustStatus, subjectNo, deptSeq, fk_deptSeq as m_deptSeq, score, credits, courseSemester,
                    to_char(sysdate, 'yyyy')||'-'||thisSemester as thisSemester
        from
        (
            select semester, courseYear, fk_memberNo, subjectName, mustStatus, subjectNo, deptSeq, score, credits,
                        courseYear||'-'||semester as courseSemester,  case when to_char(sysdate, 'q') in(1,2) then 1 else 2 end as thisSemester
            from tbl_course c join tbl_subject s
            on c.fk_subjectNo = s.subjectNo
            join tbl_dept d
            on s.fk_deptSeq = d.deptSeq
            where fk_memberNo = 106
        )V
        join tbl_member m
        on v.fk_memberNo = m.memberNo
        )T
        where deptSeq != m_deptSeq and muststatus = 0   and courseSemester != thisSemester
        
    -- func_gyoyang(deptSeq, mustStatus)만들기
    create or replace function func_gyoyang
        (
        p_deptSeq in number,
        p_mustStatus in number
        )
        return varchar2
    is 
        v_gyoyang varchar2(20);
    begin
        select case when p_deptSeq = 23  and p_mustStatus = 0 then '교양필수' else '교양선택' end  -- select된 결과물을 변수에 담아줘야함
        into v_gyoyang -- select된 결과물을 변수에 담는 키워드 : into
        from dual; 
        
        return v_gyoyang;
    end func_gyoyang;
    --Function FUNC_GYOYANG이(가) 컴파일되었습니다.
    
    select func_gyoyang(23, 0) as gyoyang
    from dual
     
      -- func_major(s_deptSeq, d_deptSeq, mustStatus)만들기
    create or replace function func_major
        (
        s_deptSeq in number,
        d_deptSeq in number,
        p_mustStatus in number
        )
        return varchar2
    is 
        v_major varchar2(20);
    begin
        select case when s_deptSeq = d_deptSeq  and p_mustStatus = 0 then '전공필수' when s_deptSeq = d_deptSeq  and p_mustStatus = 1 then '전공선택' else '일반선택' end  -- select된 결과물을 변수에 담아줘야함
        into v_major -- select된 결과물을 변수에 담는 키워드 : into
        from dual; 
        
        return v_major;
    end func_major;
    --Function FUNC_MAJOR이(가) 컴파일되었습니다.
    
    select func_major(3,2,0) as major
    from dual
    
        
         -- 사용자 정의 함수
    /*
        [문법]
        create or replace function 함수명
        (파라미터변수명 in 파라미터변수의타입)
        return 리턴시킬타입
        is 
           변수선언
        begin
           명령어
           return 값
        end 함수명;    
    */
    
    
           /* ---- **** if문 **** ----
           
                if      조건1  then  실행문장1;
                elsif   조건2  then  실행문장2;
                else                 실행문장3;
                end if;
           */
    
    -- func_gender(jubun)만들기
    create or replace function func_gender
        (p_jubun in varchar2) -- (p_jubun in varchar2(13)) 자리수를 쓰면 오류!!
        return varchar2       -- varchar2(4) 자리수를 쓰면 오류!!
        is 
           v_genderNum varchar2(1);  -- is와 begin 사이는 변수를 선언하는 부분이다.
           v_gender    varchar2(10);    -- 크기는 크게 잡는게 좋다.
        begin
           -- p_jubun이 '9510201234567'이라고 하면 
           v_genderNum := substr(p_jubun,7,1); --'1' '2' '3' '4' 변수에 값을 담을때는 := 을 사용
           
           if v_genderNum in('1','3') then v_gender := '남';
           else v_gender := '여';
           end if;
           
           return v_gender;
        end func_gender;
    -- Function FUNC_GENDER이(가) 컴파일되었습니다.
        
        -- func_socre(p_score) 함수 만들기
       create or replace function func_score
        (p_score in varchar2) 
        return varchar2      
        is 
           v_score varchar2(20); 
        begin
           select case when p_score = 'A+' then '4.3' 
           when p_score ='A' then '4.0'
           when p_score ='A-' then '3.7' 
           when p_score ='B+' then '3.3'
           when p_score ='B' then '3.0'
           when p_score ='B-' then '2.7'
           when p_score ='C+' then '2.3'
           when p_score ='C' then '2.0'
           when p_score ='C-' then '1.7'
           when p_score ='D+' then '1.3'
           when p_score ='D' then '1.0'
           when p_score ='D-' then '0.7'
           else '0' end
           into v_score
           from dual; 
           
           return v_score;
        end func_score; 
        --Function FUNC_SCORE이(가) 컴파일되었습니다.
commit;
       -- func_creditsNoF(p_score, p_credits) 함수 만들기
       create or replace function func_creditsNoF
        (
        p_score in varchar2,
        p_credits in number
        ) 
        return number      
        is 
           v_credits number; 
        begin
           select case when p_score = 'F' then 0
           else p_credits end
           into v_credits
           from dual; 
           
           return v_credits;
        end func_creditsNoF; 
        --Function FUNC_CREDITSNOF이(가) 컴파일되었습니다.

select * from tab;

select * from tbl_course where score = 'D-';

-- 학기, 이수학점, 평점평균, 최초평점평균, 학사경고
select courseSemester, cCradits, round(totalScore/credits, 2) as averageScore , round(totalScore/cCradits, 2) as firstAverageScore,
            case when round(totalScore/credits, 2) <= 1.5 then '경고' else '- ' end as warning
from
(
select  courseSemester, sum(credits) as credits, sum(cCradits) as cCradits, sum(grade*credits) as totalScore
from
(
select  courseYear||'-'||semester as courseSemester, func_score(score) as grade, credits, func_creditsNoF(score,credits) as cCradits
from tbl_course c join tbl_subject  s
on c.fk_subjectNo = s.subjectNo
where fk_memberNo = 108 and score is not null
)V
where courseSemester != to_char(sysdate, 'yyyy-q')
group by courseSemester
order by courseSemester desc
)T

select * from tbl_subject
select * from tbl_course where courseYear = '2021'

select * from tbl_schedule