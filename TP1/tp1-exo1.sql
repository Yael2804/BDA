/*Question 1*/
DROP TABLE section;

create table section(
    course_id varchar(8),
    sec_id varchar(8),
    semester varchar(6)
    check (semester in ('Fall', 'Winter', 'Spring', 'Summer')),
    year numeric(4, 0),
    building varchar(15),
    room_number varchar(7),
    time_slot_id varchar(4),
    primary key (course_id, sec_id, semester, year),
    foreign key (course_id) references course,
    foreign key (building, room_number) references classroom
    );


/*Question 4*/
insert into course values ('BIO -101', 'Intro. to Biology', 'Biology', '4') ;
